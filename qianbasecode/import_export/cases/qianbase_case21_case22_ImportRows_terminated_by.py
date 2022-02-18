# -*- coding:utf8 -*-
#################################
# date        : 2021-12-06
# func        : 
# author      : fangrenyi
# copyright   : esgyn
# date file   : 当前路径下的/PrepareTheData/
# description : 
#################################


import pytest
import time
import os
import sys
import re
#if not os.environ.get("typeinfo"):
#    os.environ["typeinfo"] = "import_export"
try:
    curdir=os.getcwd()
    syspath = curdir
    if "qianbasecode" in curdir:
        syspath = curdir.split("qianbasecode")[0]
    os.chdir(syspath)
except Exception as e:
    print("修改工作到根路径失败:errmsg:%s"%e)
    sys.exit()

try:
    from factory.collect import write_logger
    from factory.import_export import ssh
    from factory.import_export import execcmd
    from factory.conf import *
    from factory.import_export import import_export
except Exception as e:
    sys.path.append(syspath)
    from factory.collect import write_logger
    from factory.import_export import ssh
    from factory.import_export import execcmd
    from factory.conf import *
    from factory.import_export import import_export

def case21_qianbase():
    try:
        basepath = os.getcwd()
        prepath = os.path.abspath(os.path.join(basepath, "qianbasecode/import_export/PrepareTheData/"))
        
        #获取OneDatabaseOneTable.sql的数据文件
        sonpath = os.path.abspath(os.path.join(basepath, "qianbasecode/import_export/PrepareTheData/case21.txt"))
        sonpath2 = os.path.abspath(os.path.join(basepath, "qianbasecode/import_export/PrepareTheData/StructTableWithNULL.sql"))
        
        #获取配置文件的相应参数
        qianbase = import_export.Base_bk().returnpara()
        dbname = qianbase['dbname']
        user = qianbase['user']
        password = qianbase['sshpassword']
        host = qianbase['host']
        dbport = qianbase['dbport']
        sshport = qianbase['sshport']
        bindir = qianbase['bindir']
        localpath = qianbase['localpath']
        httppath = qianbase['httppath']
        nodeid= localpath.split('/')[2]
        csvpath = '/extern/%s' %(localpath.split('/')[3])

        ssharg = [host, sshport,user, password]
        #集群初始化
        import_export.instbk()
         
        #拷贝文件
        import_export.Base_bk().scp_file(sonpath,prepath)
        import_export.Base_bk().scp_file(sonpath2,prepath)
        
        command,command2,d  = execcmd.execdatafile(bindir,host,dbport,sonpath2)
        ssh.myssh(command,ssharg)
        #获取其他信息
        # 和导入的DataTableWithNULL.sql文件第一行一致。
        newdb = d["newdb"]
        tabname = d['tabname']

        #导入
        #获取所有nodeid ip
        ssh2 = ssh.myssh(command2,ssharg)
        backip,backdbport = execcmd.nodeidip(ssh2,nodeid)
        storeinfo = execcmd.querystore()
        newssharg = [backip, sshport, user, password]
        store = storeinfo[nodeid]

        cmd = 'mkdir -p %s/extern;cp -r %s %s/extern/' %(store,sonpath,store)
        ssh.myssh(cmd,newssharg)
        importstr = localpath.split("export")[0]
        importcmd = "use %s;IMPORT INTO %s delimited DATA ('%scase21.txt') WITH rows_terminated_by = '#', fields_terminated_by = ',';" %(newdb,tabname,importstr)

        ssh.myssh(execcmd.execcmd(importcmd,host,dbport),ssharg) 
        execcmd.judgecmd("IMPORT", ssharg, 3)

        #导入的数据
        desdatacomm = 'use %s;select * from %s' % (newdb,tabname)
        des = execcmd.dealwithstr(ssh.myssh(execcmd.execcmd(desdatacomm,host,dbport),ssharg))
        exp = ['id\tbalance', '1\t1', '2\t2']

        #对比表数据
        write_logger(logfile).info('\ndes:%s \nexp:%s' %(des,exp))
        assert exp == des,'数据不匹配'
        
        #检查状态是否正常
        execcmd.checkstat(ssharg)

        #删除scp的文件目录(回退操作)
        import_export.Base_bk().rm_file()

    except Exception as e:
        #检查状态是否正常
        execcmd.checkstat(ssharg)
        #删除scp的文件目录(回退操作)
        import_export.Base_bk().rm_file()
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()

if __name__ == '__main__':
    case21_qianbase()
    





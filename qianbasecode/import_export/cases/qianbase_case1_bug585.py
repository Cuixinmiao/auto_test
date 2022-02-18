# -*- coding:utf8 -*-
#################################
# date        : 2021-11-12
# func        : 
# author      : caihailong
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

def case1_qianbase():
    try:
        basepath = os.getcwd()
        prepath = os.path.abspath(os.path.join(basepath, "qianbasecode/import_export/PrepareTheData/"))
        
        #获取OneDatabaseOneTable.sql的数据文件
        sonpath = os.path.abspath(os.path.join(basepath, "qianbasecode/import_export/PrepareTheData/DataTableWithNULL.sql"))
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
        #拷贝文件到服务端
        import_export.Base_bk().scp_file(sonpath,prepath)

        #集群初始化
        import_export.instbk()
     
        #执行数据文件
        t1 = execcmd.execdatafile(bindir,host,dbport,sonpath)
        ssh.myssh(t1[0],ssharg)
        
        #获取其他信息
        # 和导入的DataTableWithNULL.sql文件第一行一致。
        newdb = t1[2]["newdb"]
        tabname = t1[2]['tabname']

        #导出        
        exportcmd = "EXPORT INTO CSV '%s' WITH nullas = ' ' FROM TABLE %s.%s;" %(localpath,newdb,tabname)
        ssh.myssh(execcmd.execcmd(exportcmd,host,dbport),ssharg)
        #再插入两条数据
        insecomm = 'use %s;INSERT INTO %s VALUES(7, 8100.73),(8, 9400.10);' % (newdb,tabname)
        ssh.myssh(execcmd.execcmd(insecomm,host,dbport),ssharg)
        
        exdatacomm = 'use %s;select * from %s' % (newdb,tabname)
        #导出的数据没有后插入的两条
        expdata = execcmd.dealwithstr(ssh.myssh(execcmd.execcmd(exdatacomm,host,dbport),ssharg))[:-2]
        
        #获取所有nodeid ip
        ssh2 = ssh.myssh(t1[1],ssharg)
        backip,backdbport = execcmd.nodeidip(ssh2,nodeid)
        storeinfo = execcmd.querystore()
        store = storeinfo[nodeid]
        newssharg = [backip, sshport, user, password]

        #获取csv文件和处理
        inbackpath = '%s%s' % (store,csvpath)
        cmd = 'cd %s;ls' %(inbackpath)
        refile = ssh.myssh(cmd,newssharg)
        inbackfile = refile.strip().split()
        tmplist = ['%s/%s' %(localpath,i)  for i in inbackfile]
        importstr = ','.join(tmplist)

        #导入
        #拷贝文件
        import_export.Base_bk().scp_file(sonpath2,prepath)
        #执行数据文件
        t2 = execcmd.execdatafile(bindir,host,dbport,sonpath2)
        ssh.myssh(t2[0],ssharg)
        #rename
        rename = 'use %s;alter table %s rename to %s1' %(newdb,tabname,tabname)
        ssh.myssh(execcmd.execcmd(rename,host,dbport),ssharg)        

        importcmd = "use %s;IMPORT table  %s(id INT PRIMARY KEY, balance DECIMAL(15,2)) CSV DATA ('%s') WITH nullif = ' ';" %(newdb,tabname,importstr)
        ret = ssh.myssh2(execcmd.execcmd(importcmd,host,dbport),ssharg) 
        execcmd.judgecmd("IMPORT", ssharg, 3)

        #导入的数据
        desdata = execcmd.dealwithstr(ssh.myssh(execcmd.execcmd(exdatacomm,host,dbport),ssharg))

        #对比表结构、数据
        write_logger(logfile).info('\nexpdata:%s \ndesdata:%s' %(expdata,desdata))
        assert expdata == desdata,'数据不匹配'
        assert 'NOTICE: IMPORT TABLE has been deprecated in 9.0' in ret,'no pass'
        
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
    case1_qianbase()
    





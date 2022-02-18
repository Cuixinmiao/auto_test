# -*- coding:utf8 -*-
#################################
# date        : 2021-12-06
# func        : Export 
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

def case9_qianbase():
    try:
        basepath = os.getcwd()
        prepath = os.path.abspath(os.path.join(basepath, "qianbasecode/import_export/PrepareTheData/"))
        #获取OneDatabaseOneTable.sql的数据文件
        sonpath = os.path.abspath(os.path.join(basepath, "qianbasecode/import_export/PrepareTheData/StructTableJson.sql"))
        sonpath2 = os.path.abspath(os.path.join(basepath, "qianbasecode/import_export/PrepareTheData/simple-sorted.json"))
       
        #获取配置文件的相应参数
        qianbase = import_export.Base_bk().returnpara()
        dbname = qianbase['dbname']
        user = qianbase['user']
        password = qianbase['sshpassword']
        host = qianbase['host']
        dbport = qianbase['dbport']
        sshport = qianbase['sshport']
        bindir = qianbase['bindir']
        localpath = qianbase['localpath'].split('export')[0]
        filename = sonpath2.split("/")[-1]
        nodeid =  localpath.split('/')[2]
        
        ssharg = [host, sshport,user, password]
        #拷贝文件到服务端
        import_export.Base_bk().scp_file(sonpath,prepath)
        import_export.Base_bk().scp_file(sonpath2,prepath)
        #集群初始化
        import_export.instbk()
     
        #执行数据文件
        t1 = execcmd.execdatafile(bindir,host,dbport,sonpath)
        ssh.myssh(t1[0],ssharg)
        
        #获取其他信息
        # 和导入的DataTableWithoutNULL.sql文件第一行一致。
        newdb = t1[2]["newdb"]
        tabname = t1[2]['tabname']

        #导入       
        #获取所有nodeid ip
        ssh2 = ssh.myssh(t1[1],ssharg)
        backip,backdbport = execcmd.nodeidip(ssh2,nodeid)
        storeinfo = execcmd.querystore()
        store = storeinfo[nodeid]
        newssharg = [backip, sshport, user, password]

        cmd = 'mkdir %s/extern;cp %s %s/extern' %(store,sonpath2,store)
        ssh.myssh(cmd,newssharg)

        schema='{"type": "record","name": "simple","fields":[{ "name": "i", "type": "int" },{ "name": "s", "type": "string" },{ "name": "c", "type": "int"}]}'
        importcmd = """IMPORT INTO %s.%s AVRO DATA ('%s%s') WITH data_as_json_records,schema='%s';""" %(newdb,tabname,localpath,filename,schema)
        
        exfile = prepath + '/tmp.txt'
        if os.path.exists(exfile):
            os.remove(exfile)
        os.makedirs(os.path.dirname(exfile), exist_ok=True)
        with open(exfile,"w") as f:
            f.write(importcmd)
            f.close()
        
        #执行导入文件
        import_export.Base_bk().scp_file(exfile,prepath)
        t = execcmd.execdatafile(bindir,host,dbport,exfile)
        ssh.myssh(t[0],ssharg)
        execcmd.judgecmd("IMPORT", ssharg, 3)
        
        #导入
        cmd2 = 'use %s;select * from %s' %(newdb,tabname)
        
        data = execcmd.dealwithstr(ssh.myssh(execcmd.execcmd(cmd2,backip,backdbport),ssharg))
        desdata = eval(str(data).replace("\\t", ','))
        expdata = ['i,s,c', '1,abcds,11', '2,abcd,12'] 
        #对比表结构、数据
        write_logger(logfile).info('\nexpdata:%s \ndesdata:%s' %(expdata,desdata))
        assert expdata == desdata,'数据不匹配'

        #检查状态是否正常
        execcmd.checkstat(ssharg)

        #删除scp的文件目录(回退操作)
        import_export.Base_bk().rm_file()
    except Exception as e:
        #删除scp的文件目录(回退操作)
        import_export.Base_bk().rm_file()
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()


if __name__ == '__main__':
    case9_qianbase()
    





# -*- coding:utf8 -*-
#################################
# date        : 2021-11-12
# func        : backup and restore
# author      : caihailong
# copyright   : esgyn
# date file   : 当前路径下的/PrepareTheData/OneDatabaseOneTable.sql
# description :集群级备份集群时间点恢复，单database单table增量备份时间点恢复无with参数，时间点重装拷贝恢复无with参数
#################################


import pytest
import time
import os
import sys
import re
#if not os.environ.get("typeinfo"):
#    os.environ["typeinfo"] = "backup_restore"
print(os.environ.get("typeinfo"))
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
    from factory.backup_restore import ssh
    from factory.backup_restore import execsql
    from factory.conf import *
    from factory.backup_restore import backup_restore
except Exception as e:
    sys.path.append(syspath)
    from factory.collect import write_logger
    from factory.backup_restore import ssh
    from factory.backup_restore import execsql
    from factory.conf import *
    from factory.backup_restore import backup_restore

def case122_qianbase():
    try:
        basepath = os.getcwd()
        prepath = os.path.abspath(os.path.join(basepath, "qianbasecode/backup_restore/PrepareTheData/"))
        
        #获取OneDatabaseOneTable.sql的数据文件
        sonpath = os.path.abspath(os.path.join(basepath, "qianbasecode/backup_restore/PrepareTheData/OneDatabaseOneTable.sql"))
        
        #获取配置文件的相应参数
        qianbase = backup_restore.Base_bk().returnpara()
        dbname = qianbase['dbname']
        user = qianbase['user']
        securepw = qianbase['securepw']
        password = qianbase['sshpassword']
        host = qianbase['host']
        dbport = qianbase['dbport']
        sshport = qianbase['sshport']
        bindir = qianbase['bindir']
        securemode = qianbase["securemode"]
        gm = qianbase['gm']
        nodeid = qianbase['nodeid']
        backdir = qianbase['backdir']
        
        if gm == 'gm':
            with_para_bk = "with gm_encryption,revision_history"
            with_para_rt = "with gm_encryption"
        else:
            with_para_bk = "with revision_history"
            with_para_rt = ""
        ssharg = [host, sshport,user, password]

        backup_restore.Base_bk().scp_file(sonpath,prepath)
        #集群初始化
        backup_restore.instbk()

        #执行数据文件
        command,command2,d  = execsql.execdatafile(bindir,host,dbport,sonpath)
        ssh0 = ssh.myssh(command,ssharg)

        #获取其他信息
        # 和导入的OneDatabaseOneTable.sql文件第一行一致。
        newdb = d["newdb"]
        tabname = d['tabname']
        
        #进行备份
        bakcommand = "BACKUP  INTO 'nodelocal://%s/%s' %s;" % (nodeid, backdir,with_para_bk)
        ssh.myssh(execsql.execcmd(bakcommand,host,dbport),ssharg)
        #等待备份完成
        execsql.judgecmd("BACKUP",ssharg,3)

        time.sleep(1)
        time0 = execsql.dealwithstr(ssh.myssh(execsql.execcmd("set time zone '0';select sysdate();",host,dbport),ssharg))[-1]
        time.sleep(1)

        #再插入两条数据 
        insecomm = 'use %s;INSERT INTO %s VALUES(7, 8100.73),(8, 9400.10);' % (newdb,tabname)
        ssh.myssh(execsql.execcmd(insecomm,host,dbport),ssharg)

        time.sleep(1)
        time1 = execsql.dealwithstr(ssh.myssh(execsql.execcmd("set time zone '0';select sysdate();",host,dbport),ssharg))[-1]
        print(time1)
        time.sleep(1)

        #增量备份1
        bakcommand1 = "BACKUP INTO LATEST IN  'nodelocal://%s/%s' %s;" % (nodeid, backdir,with_para_bk)
        ssh.myssh(execsql.execcmd(bakcommand1,host,dbport),ssharg)
        #等待备份完成
        execsql.judgecmd("BACKUP",ssharg,3)
        
        time.sleep(1)
        time2 = execsql.dealwithstr(ssh.myssh(execsql.execcmd("set time zone '0';select sysdate();",host,dbport),ssharg))[-1]
        print(time2)
        time.sleep(1)

        #再插入两条数据
        insecomm2 = 'use %s;INSERT INTO %s VALUES(9, 100.73),(10, 960.10);' % (newdb,tabname)
        ssh.myssh(execsql.execcmd(insecomm2,host,dbport),ssharg)

        time.sleep(1)
        time3 = execsql.dealwithstr(ssh.myssh(execsql.execcmd("set time zone '0';select sysdate();",host,dbport),ssharg))[-1]
        print(time3)
        time.sleep(1)

        #增量备份2
        bakcommand2 = "BACKUP INTO LATEST IN  'nodelocal://%s/%s' %s;" % (nodeid, backdir,with_para_bk)
        ssh.myssh(execsql.execcmd(bakcommand2,host,dbport),ssharg)
        #等待备份完成
        execsql.judgecmd("BACKUP",ssharg,3)

        #查备份文件
        backuppath,backfile = execsql.showbackupcmd(nodeid, backdir,ssharg)
        print(backuppath,backfile)
        excommand = 'use %s;show create table %s' % (newdb,tabname)
        exdatacomm = 'use %s;select * from %s' % (newdb,tabname)
        exp = execsql.dealwithstr(ssh.myssh(execsql.execcmd(excommand,host,dbport),ssharg))
        expdata = execsql.dealwithstr(ssh.myssh(execsql.execcmd(exdatacomm,host,dbport),ssharg))

        #获取所有nodeid ip
        ssh2 = ssh.myssh(command2,ssharg)
        backip,backdbport = execsql.nodeidip(ssh2,nodeid)
        newssharg = [backip, sshport, user, password]
        storeinfo = execsql.querystore()
        backuppath = eval(backuppath)
       
        ###校验1###
        #拷贝备份文件到相应路径
        store = storeinfo[nodeid]
        rootstore = '/root/'
        cpcommand = 'rm -rf %sextern;cp -r %s/extern %s' % (rootstore,store,rootstore)
        ssh.myssh(cpcommand,newssharg)

        #再次初始化
        backup_restore.instbk()

        #拷贝到回相应路径
        cpcommand = 'cp -r %sextern %s/' % (rootstore, store)
        ssh.myssh(cpcommand,newssharg)

        #进行时间点恢复，恢复到time0
        rescommand = "RESTORE FROM '%s%s' AS OF SYSTEM TIME '%s' %s;" % (backuppath, backfile,time0,with_para_rt)
        print(rescommand)
        ssh.myssh(execsql.execcmd(rescommand,host,dbport),ssharg)
        #等待恢复完成
        execsql.judgecmd("RESTORE", ssharg, 3)
        
        #断言
        cmd = 'show databases;'
        ret = ssh.myssh(execsql.execcmd(cmd,host,dbport),ssharg)
        assert 'dbms_temp_system' in ret and newdb not in ret,'no pass'
     
        #检查状态是否正常
        execsql.checkstat(ssharg)

        #删除scp的文件目录(回退操作)
        backup_restore.Base_bk().rm_file()
    except Exception as e:
        #删除scp的文件目录(回退操作)
        backup_restore.Base_bk().rm_file()
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()

if __name__ == '__main__':
    case122_qianbase()


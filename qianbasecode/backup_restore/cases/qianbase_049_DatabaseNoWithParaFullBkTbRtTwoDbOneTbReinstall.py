# -*- coding:utf8 -*-
#################################
# date        : 2021-11-12
# func        : backup and restore
# author      : caihailong
# copyright   : esgyn
# date file   : 当前路径下的/PrepareTheData/TwoDatabaseOneTable.sql
# description : 库级备份表级恢复，两database单table库级备份表级恢复无with参数，拷贝重装新建同名库恢复无with参数
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

def case49_qianbase():
    try:
        basepath = os.getcwd()
        prepath = os.path.abspath(os.path.join(basepath, "qianbasecode/backup_restore/PrepareTheData/"))

        #获取TwoDatabaseOneTable.sql的数据文件
        sonpath = os.path.abspath(os.path.join(basepath, "qianbasecode/backup_restore/PrepareTheData/TwoDatabaseOneTable.sql"))
        
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
            with_para_bk = "with gm_encryption"
            with_para_rt = "with gm_encryption"
        else:
            with_para_bk = ""
            with_para_rt = ""
        ssharg = [host, sshport,user, password]


        backup_restore.Base_bk().scp_file(sonpath,prepath)
        #集群初始化
        backup_restore.instbk()

        #执行数据文件
        command,command2,d  = execsql.execdatafile(bindir,host,dbport,sonpath)
        ssh.myssh(command,ssharg)

        #获取其他信息
        # 和导入的OneDatabaseOneTable.sql文件第一行一致。
        newdb = d["newdb"]
        tabname = d['tabname']
        newdb2 = d["newdb2"]
        tabname2 = d['tabname2']
        
        #进行备份
        bakcommand = "BACKUP database %s,%s  INTO 'nodelocal://%s/%s'  %s;" % (newdb,newdb2,nodeid, backdir,with_para_bk)
        ssh.myssh(execsql.execcmd(bakcommand,host,dbport),ssharg)
        #等待备份完成
        execsql.judgecmd("BACKUP",ssharg,3)

        #再插入两条数据
        insecomm = 'use %s;INSERT INTO %s VALUES(7, 8100.73),(8, 9400.10);' % (newdb,tabname)
        ssh.myssh(execsql.execcmd(insecomm,host,dbport),ssharg)

        insecomm2 = 'use %s;INSERT INTO %s VALUES(7, 800.73),(8, 940.13);' % (newdb2,tabname2)
        ssh.myssh(execsql.execcmd(insecomm2,host,dbport),ssharg)

        #查备份文件
        backuppath,backfile = execsql.showbackupcmd(nodeid, backdir,ssharg)

        excommand = 'use %s;show create table %s' % (newdb,tabname)
        exdatacomm = 'use %s;select * from %s' % (newdb,tabname)
        exp = execsql.dealwithstr(ssh.myssh(execsql.execcmd(excommand,host,dbport),ssharg))

        excommand2 = 'use %s;show create table %s' % (newdb2,tabname2)
        exdatacomm2 = 'use %s;select * from %s' % (newdb2,tabname2)
        exp2 = execsql.dealwithstr(ssh.myssh(execsql.execcmd(excommand2,host,dbport),ssharg))


        #备份的数据没有后插入的两条
        expdata = execsql.dealwithstr(ssh.myssh(execsql.execcmd(exdatacomm,host,dbport),ssharg))[:-2]
        expdata2 = execsql.dealwithstr(ssh.myssh(execsql.execcmd(exdatacomm2,host,dbport),ssharg))[:-2]

        #获取所有nodeid ip
        ssh2 = ssh.myssh(command2,ssharg)
        backip,backdbport = execsql.nodeidip(ssh2,nodeid)
        storeinfo = execsql.querystore()
        newssharg = [backip, sshport, user, password]  
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
        
        #创建同名库
        createcom = 'use %s;create database %s' %(dbname,newdb)
        ssh.myssh(execsql.execcmd(createcom,host,dbport),ssharg)
        createcom2 = 'use %s;create database %s' %(dbname,newdb2)
        ssh.myssh(execsql.execcmd(createcom2,host,dbport),ssharg)
        

        #进行恢复
        backuppath = eval(backuppath)
        rescommand = "RESTORE table %s.%s,%s.%s FROM '%s%s'  %s;" % (newdb,tabname,newdb2,tabname2,backuppath, backfile,with_para_rt)
        ssh.myssh(execsql.execcmd(rescommand,host,dbport),ssharg)

        #等待恢复完成
        execsql.judgecmd("RESTORE", ssharg, 3)
        
        #查恢复后的数据、表结构
        des = execsql.dealwithstr(ssh.myssh(execsql.execcmd(excommand,backip,backdbport),newssharg))
        desdata = execsql.dealwithstr(ssh.myssh(execsql.execcmd(exdatacomm,backip,backdbport),newssharg))

        des2 = execsql.dealwithstr(ssh.myssh(execsql.execcmd(excommand2,backip,backdbport),newssharg))
        desdata2 = execsql.dealwithstr(ssh.myssh(execsql.execcmd(exdatacomm2,backip,backdbport),newssharg))
        
        #对比表结构、数据
        write_logger(logfile).info('\nexp:%s \ndes:%s' %(exp,des))
        assert exp == des,'表结构不匹配'
        write_logger(logfile).info('\nexpdata:%s \ndesdata:%s' %(expdata,desdata))
        assert expdata == desdata,'数据不匹配'
        write_logger(logfile).info('\nexp2:%s \ndes2:%s' %(exp2,des2))
        assert exp2 == des2,'表结构不匹配'
        write_logger(logfile).info('\nexpdata2:%s \ndesdata2:%s' %(expdata2,desdata2))
        assert expdata2 == desdata2,'数据不匹配'

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
    case49_qianbase()




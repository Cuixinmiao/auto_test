# -*- coding:utf8 -*-
#################################
# date        : 2021-11-12
# func        : backup and restore
# author      : caihailong
# copyright   : esgyn
# date file   : 当前路径下的/PrepareTheData/OneDatabaseOneTable.sql
# description : 表级备份恢复，单database单table表级备份恢复无with参数，恢复with skip_missing_views
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
def case119_qianbase():
    try:
        
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
            with_para_rt = "with gm_encryption,skip_missing_views"
        else:
            with_para_bk = ""
            with_para_rt = "with skip_missing_views"

        ssharg = [host, sshport,user, password]
       
        #集群初始化
        backup_restore.instbk()

        #获取其他信息
        # 和导入的OneDatabaseOneTable.sql文件第一行一致。
        newdb = 'bankdb'
        tabname = 'accounts'
       
        createcmd  = 'create database %s;use %s;create table %s (i_id integer not null,i_name varchar(24));CREATE OR REPLACE VIEW  view_%s as select i_id,i_name from %s;' %(newdb,newdb,tabname,tabname,tabname)
        ssh.myssh(execsql.execcmd(createcmd,host,dbport),ssharg)
        #进行备份
        backcommand = "BACKUP %s.view_%s  INTO 'nodelocal://%s/%s'  %s;" % (newdb,tabname,nodeid, backdir,with_para_bk)
        ssh.myssh(execsql.execcmd(backcommand,host,dbport),ssharg)
        #等待备份完成
        execsql.judgecmd("BACKUP",ssharg,3)

        dropcmd = 'use %s;drop view view_%s' %(newdb,tabname)
        ssh.myssh(execsql.execcmd(dropcmd,host,dbport),ssharg)

        #进行恢复
        backuppath,backfile = execsql.showbackupcmd(nodeid, backdir,ssharg)
        backuppath = eval(backuppath)
        rescommand = "RESTORE %s.view_%s FROM '%s%s'  %s;" % (newdb,tabname,backuppath, backfile,with_para_rt)
        ssh.myssh(execsql.execcmd(rescommand,host,dbport),ssharg)

        #等待恢复完成
        execsql.judgecmd("RESTORE", ssharg, 1)
       
        showtable = 'use %s;show tables' %(newdb)
        ret = ssh.myssh(execsql.execcmd(showtable,host,dbport),ssharg) 
        #查恢复后情况
        assert 'view' not in ret,'视图被恢复了，不正确'
        
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
    case119_qianbase()




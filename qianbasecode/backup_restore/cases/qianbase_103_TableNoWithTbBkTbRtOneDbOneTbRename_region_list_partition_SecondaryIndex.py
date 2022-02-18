# -*- coding:utf8 -*-
#################################
# date        : 2021-11-12
# func        : backup and restore
# author      : caihailong
# copyright   : esgyn
# date file   : 
# description : 集群备份集群恢复，单database单table集群备份无with参数，拷贝重装恢复无with参数 
#################################

import pytest
import time
import os
import sys
import re
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

def case103_qianbase():
    try:
        #获取配置文件的相应参数
        qianbase = backup_restore.Base_bk().returnpara()
        dbname = qianbase['dbname']
        user = qianbase['user']
        password = qianbase['sshpassword']
        host = qianbase['host']
        dbport = qianbase['dbport']
        sshport = qianbase['sshport']
        bindir = qianbase['bindir']
        gm = qianbase['gm']
        nodeid = qianbase['nodeid']
        backdir = qianbase['backdir']

        locality = backup_restore.Base_bk().locality
        localall = []
        for i in locality:
            localall.append(i.split(',')[0].split('=')[-1])
        localall = list(set(localall))

        if gm == 'gm':
            with_para_bk = "with gm_encryption"
            with_para_rt = "with gm_encryption"
        else:
            with_para_bk = ""
            with_para_rt = ""
        
        #集群初始化
        backup_restore.instbk()
        
        newdb = 'bankdb'
        tabname = 'bmsql_warehouse'       
        idxname = 'idx_city'        

        excommand = 'drop  DATABASE if exists %s cascade;CREATE DATABASE IF NOT EXISTS %s;' % (newdb,newdb)
        
        createcmd = 'create table %s (w_id integer not null,w_ytd  decimal(12,2),w_tax decimal(4,4),w_name varchar(10),w_street_1  varchar(20),w_street_2  varchar(20),w_city varchar(20),w_state char(2),w_zip char(9),index %s(w_city));' %(tabname,idxname)
        print(createcmd) 
        s = 'alter index %s@%s partition by list(w_city)(' %(tabname,idxname)
        s1 = ''
        c = 0
        for i in localall:
            s += "PARTITION %s VALUES in (('%s%d'))," %(i,i,c)
            s1 += "ALTER PARTITION %s OF index %s@%s CONFIGURE ZONE USING constraints = '[+region=%s]';" %(i,tabname,idxname,i)
            c += 1
        s = s.strip(',') + ');'
        print(s)
        print(s1)
        ssharg = [host, sshport,user, password]
        
        execsql.dealwithstr(ssh.myssh(execsql.execcmd(excommand,host,dbport),ssharg))

        insertcmd = "insert into %s  values(1,14.2,0.123,'q','q','q','q','q','q');" %(tabname)        
        print(insertcmd)
        cmd = 'use %s;%s%s;%s;%s' %(newdb,createcmd,s,s1,insertcmd)
        execsql.dealwithstr(ssh.myssh(execsql.execcmd(cmd,host,dbport),ssharg))

        #进行备份
        bakcommand = "BACKUP table %s.%s INTO 'nodelocal://%s/%s'  %s;" % (newdb,tabname,nodeid, backdir,with_para_bk)
        ssh.myssh(execsql.execcmd(bakcommand,host,dbport),ssharg)
        #等待备份完成
        execsql.judgecmd("BACKUP",ssharg,3)

        #查备份文件
        backuppath,backfile = execsql.showbackupcmd(nodeid, backdir,ssharg)

        exp = execsql.tablestructure(ssharg,newdb,tabname)
        #备份的数据
        expdata = execsql.tabledata(ssharg,newdb,tabname)

        #改名表
        renamecmd = 'use %s;alter table %s rename to new%s' %(newdb,tabname,tabname)
        ssh.myssh(execsql.execcmd(renamecmd,host,dbport),ssharg)
        #进行恢复
        backuppath = eval(backuppath)
        rescommand = "RESTORE table %s.%s FROM '%s%s' %s;" % (newdb,tabname,backuppath, backfile,with_para_rt)
        ssh.myssh(execsql.execcmd(rescommand,host,dbport),ssharg)

        #等待恢复完成
        execsql.judgecmd("RESTORE", ssharg, 3)
        
        #查恢复后的数据、表结构
        des = execsql.tablestructure(ssharg,newdb,tabname)
        desdata = execsql.tabledata(ssharg,newdb,tabname)

        #对比表结构、数据
        write_logger(logfile).info('\nexp:%s \ndes:%s' %(exp,des))
        assert exp == des,'表结构不匹配'
        write_logger(logfile).info('\nexpdata:%s \ndesdata:%s' %(expdata,desdata))
        assert expdata == desdata,'数据不匹配'

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
    case103_qianbase()




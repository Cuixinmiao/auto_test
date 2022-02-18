# -*- coding:utf8 -*-
#################################
# date        : 2021-11-12
# func        : backup and restore
# author      : caihailong
# copyright   : esgyn
# date file   : 
# description : 集群备份集群恢复，单database单table集群备份无with参数，拷贝重装恢复无with参数，inverted index 包括array jsonb类型 
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

def case105_qianbase():
    try:
        basepath = os.getcwd()
        prepath = os.path.abspath(os.path.join(basepath, "qianbasecode/backup_restore/PrepareTheData/"))
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
        
        ssharg = [host, sshport,user, password]
        
        newdb = 'bankdb'
        tabname = 'accounts'       
        tabname2 = 'accounts2'        

        excommand = 'drop  DATABASE if exists %s cascade;\nCREATE DATABASE IF NOT EXISTS %s;\nuse %s;\n' % (newdb,newdb,newdb)
        
        createcmd = 'create table %s (a string,b string);\n' %(tabname)
        
        insertcmd = "insert into %s values('1','2'),('a','b');\n" % tabname 

        creatcmd2 = 'create table %s as select concat(a,b) from %s;' %(tabname2,tabname)
        
        exfile = prepath + '/tmp.txt'
        if os.path.exists(exfile):
            os.remove(exfile)
        os.makedirs(os.path.dirname(exfile), exist_ok=True)
        with open(exfile,"w+") as f:
            f.write(excommand)
            f.write(createcmd)
            f.write(insertcmd)
            f.write(creatcmd2)
            f.close()

        #执行导入文件
        backup_restore.Base_bk().scp_file(exfile,prepath)
        t  = execsql.execdatafile(bindir,host,dbport,exfile)
        ssh.myssh(t[0],ssharg)
        #进行备份
        bakcommand = "BACKUP table %s.%s INTO 'nodelocal://%s/%s'  %s;" % (newdb,tabname2,nodeid, backdir,with_para_bk)
        ssh.myssh(execsql.execcmd(bakcommand,host,dbport),ssharg)
        #等待备份完成
        execsql.judgecmd("BACKUP",ssharg,3)

        #查备份文件
        backuppath,backfile = execsql.showbackupcmd(nodeid, backdir,ssharg)

        exp = execsql.tablestructure(ssharg,newdb,tabname2)
        #备份的数据
        expdata = execsql.tabledata(ssharg,newdb,tabname2)

        #改表名
        rename = 'use %s;alter table %s rename to new%s' %(newdb,tabname2,tabname2)
        ssh.myssh(execsql.execcmd(rename,host,dbport),ssharg)
        #进行恢复
        backuppath = eval(backuppath)
        rescommand = "RESTORE table %s.%s FROM '%s%s' %s;" % (newdb,tabname2,backuppath, backfile,with_para_rt)
        ssh.myssh(execsql.execcmd(rescommand,host,dbport),ssharg)

        #等待恢复完成
        execsql.judgecmd("RESTORE", ssharg, 3)
        
        #查恢复后的数据、表结构
        des = execsql.tablestructure(ssharg,newdb,tabname2)
        desdata = execsql.tabledata(ssharg,newdb,tabname2)

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
    case105_qianbase()




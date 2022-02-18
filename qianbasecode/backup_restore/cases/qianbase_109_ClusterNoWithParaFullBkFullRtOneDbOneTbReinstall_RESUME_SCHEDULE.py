# -*- coding:utf8 -*-
#################################
# date        : 2021-11-12
# func        : backup and restore
# author      : caihailong
# copyright   : esgyn
# date file   : schedule 
# description : 备份调度,生成
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
def case1_qianbase():
    try:
        #获取配置文件的相应参数
        qianbase = backup_restore.Base_bk().returnpara()
        user = qianbase['user']
        password = qianbase['sshpassword']
        host = qianbase['host']
        dbport = qianbase['dbport']
        sshport = qianbase['sshport']
        gm = qianbase['gm']
        nodeid = qianbase['nodeid']
        backdir = qianbase['backdir']

        if gm == 'gm':
            with_para_bk = "with gm_encryption,revision_history,detached"
            with_para_rt = "with gm_encryption"
        else:
            with_para_bk = "with revision_history,detached"
            with_para_rt = ""

        ssharg = [host, sshport,user, password]
       
        #集群初始化
        backup_restore.instbk()

        schename = 'sch_cluster_backup'
        incretime = 1
        fulltime = 1
        
        #进行备份调度
        ssh.myssh(execsql.execcmd(execsql.schcreate(schename,nodeid, backdir,with_para_bk,incretime,fulltime),host,dbport),ssharg)
        c = execsql.judgesch(schename, ssharg, incretime * 60,point='ACTIVE')
        write_logger(logfile).info('\nexp ACTIVE nums:%s \ndes ACTIVE nums:%d' %(c,2))
        assert c == 2,'schedule did not generate success'
        
        ssh.myssh(execsql.execcmd(execsql.schoper(schename,'PAUSE'),host,dbport),ssharg)
        c = execsql.judgesch(schename, ssharg, incretime * 5,'PAUSE')
        write_logger(logfile).info('\nexp PAUSE nums:%s \ndes PAUSE nums:%d' %(c,2))
        assert c == 2,'schedule did not pause success'

        ssh.myssh(execsql.execcmd(execsql.schoper(schename,'RESUME'),host,dbport),ssharg)
        c = execsql.judgesch(schename, ssharg, incretime * 10,'ACTIVE')
        write_logger(logfile).info('\nexp RESUME nums:%s \ndes RESUME nums:%d' %(c,2))
        assert c == 2,'schedule did not pause success'

        
        backup_restore.instbk()
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
    case1_qianbase()




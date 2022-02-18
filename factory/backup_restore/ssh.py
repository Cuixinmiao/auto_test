# -*- coding:utf8 -*-
#################################
# date      : 2021-11-12
# func      :
# author    : caihailong
# copyright : esygn
#################################
# !/usr/bin/python


import paramiko
import sys
import os

"""解决qianbasecode 单独执行模块导入异常的问题"""
"""获取执行脚本的根路径"""
try:
    curdir = os.getcwd()
    syspath = curdir
    if "qianbasecode" in curdir:
        syspath = curdir.split("qianbasecode")[0]
    syspath = os.path.abspath(os.path.join(syspath, os.pardir))
except Exception as e:
    print("修改工作到根路径失败:errmsg:%s" % e)
    sys.exit()

try:
    from factory.collect import write_logger
    from factory.conf import *
except Exception as e:
    sys.path.append(syspath)
    from factory.collect import write_logger
    from factory.conf import *

def myssh(commands,*ssharg,flag=None):
    try:
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        # 建立连接
        #hostname, port, username, password
        try:
            print(*ssharg)
            ssh.connect(ssharg[0][0], ssharg[0][1], ssharg[0][2], ssharg[0][3], timeout=10)
            write_logger(logfile).info('connect %s:%s successfully' % (ssharg[0][0], ssharg[0][1]))
        except Exception as e:
            ssh.close()
            write_logger(logfile).error(u'%s' %(e))
            return None
        stdin, stdout, stderr = ssh.exec_command(commands)
        # # 获取结果
        reterr = stderr.read()
        if reterr:
            write_logger(logfile).error("exec command '%s' failed" % (commands))
            write_logger(logfile).error("%s " % ssharg[0][0] + str(reterr, encoding="utf-8"))
            if flag:
                return reterr
            else:
                sys.exit()
        ret = stdout.read()
        rets = ''
        if ret:
            write_logger(logfile).info("exec '%s' succeed" % (commands))
            for line in str(ret, encoding="utf-8").split("\n"):
                rets += line + '\n'
        else:
            write_logger(logfile).info('The "%s" execution result is empty' %(commands))
        ssh.close()
        return rets
    except Exception as e:
        ssh.close()
        write_logger(logfile).error("exec command '%s' failed errmsg:%s" % (commands,e))




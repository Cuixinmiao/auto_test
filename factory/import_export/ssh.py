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
    from factory.import_export import import_export
except Exception as e:
    sys.path.append(syspath)
    from factory.collect import write_logger
    from factory.conf import *
    from factory.import_export import import_export


def myssh(commands,*ssharg,flag=None):
    try:
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        # 建立连接
        #hostname, port, username, password
        try:
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


def myssh2(command,*ssharg):
    # 创建一个ssh的客户端
    ssh = paramiko.SSHClient()
    # 创建一个ssh的白名单
    know_host = paramiko.AutoAddPolicy()
    # 加载创建的白名单
    ssh.set_missing_host_key_policy(know_host)
    # 连接服务器
    ssh.connect(ssharg[0][0], ssharg[0][1], ssharg[0][2], ssharg[0][3], timeout=10)
    shell = ssh.invoke_shell()
    shell.settimeout(1)
    shell.send(command  + "\n")
    re = ''
    while True:
        try:
            recv = shell.recv(4096).decode()
            if recv:
                re += recv + '\n'
            else:
                continue
        except Exception as e:
            ssh.close()
            write_logger(logfile).info("%s" % (re))
            return re

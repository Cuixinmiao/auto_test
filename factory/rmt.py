# -*- coding:utf8 -*-
#################################
#date :2021-09-14
#func  :rmt.py exec remote command 
#function remote login exec cmd
#author :Xinmiao Cui
#copyright : esygn
#################################
#!/usr/bin/python

import os
import sys
import pexpect
from factory.conf import *
from factory.collect import *
from factory.util_ha.inst331 import Startup 

obj = Startup()

RMT_DEBUG_LOG=True

def rmt_open(path,mode):
    fout = open(path,mode)
    try:
        os.chmod(path,stat.S_IRWXU|stat.S_IXGRP|stat.S_IRGRP|stat.S_IROTH|stat.S_IXOTH)
    except:
        pass
    return fout


def rmt_login(login_str,pwd,timeout=30,prompt='\$'):
    handler = pexpect.spawn(login_str,timeout=timeout)
    if prompt == '#':
        pass
    else:
        prompt = r'[$>[ ]*(.*\[.*m.*]?$'
    prompt = r'[$#>]'

    if RMT_DEBUG_LOG:
        fout = rmt_open("rmt.log","ab+")
        handler.logfile_read = fout
    i = -1
    while True:
        handler.ignorecase = True
        i = handler.expect([prompt,'continue connecting','password:',"Password:",pexpect.EOF,pexpect.TIMEOUT],timeout=timeout)
        if i == 0:
            break
        elif i == 1:
            handler.sendline('yes')
            continue
        elif i == 2 or i == 3:
            handler.sendline(pwd)
        elif i == 5:
            errmsg = "remote operation is timeout"
            handler.close()
            return [-2,errmsg]
    return [0,handler]

def exec_cmd(cmd,ip,timeout=30):
    try:
        login_str = "ssh -p %s %s "%(obj.sshport,ip)
        ret = rmt_login(login_str,obj.password,timeout=timeout)
        handler = None
        if ret[0] == 0:
            handler = ret[1]
        if handler:
            write_logger(logfile).debug("exec rmt_cmd %s start "%cmd)
            ret1 = rmt_cmd(handler,cmd)
            if ret1 == 0:
                #write_logger(logfile).debug("exec rmt_cmd %s success "%cmd)
                for line in str(handler.before,encoding="utf-8").split("\n"):
                    write_logger(logfile).debug("exec rmt_cmd info %s "%line)
            else:
                write_logger(logfile).error("exec rmt_cmd %s failed!!\n errmsg:%s"%(cmd,handler.before))
        else:
            write_logger(logfile).error("exec rmt_cmd %s failed!! clause: get remote fd failed"%(ret[1]))
        write_logger(logfile).debug("exec rmt_cmd %s end "%cmd)
        #print(handler.buffer)
        #print(handler.before)
        #print(handler.after)
        return True
    except Exception as e:
        write_logger(logfile).error("exec rmt_cmd %s failed!! clause: %s"%(e))
        return None
    finally:
        if handler:
            handler.close()


    

def rmt_cmd(handler,cmd,timeout=60,prompt='\$'):
    handler.sendline(cmd)
    prompt = '#'

    if RMT_DEBUG_LOG:
        fout = rmt_open("rmt.log","ab+")
        handler.logfile_read = fout
    i = handler.expect([prompt,pexpect.EOF,pexpect.TIMEOUT],timeout=timeout)
    if i == 1:
        return -1
    elif i == 2:
        return -2
    else:
        return 0


def rmt_close(handler):
    handler.close()
    return 0


def rmt_exec(rmt_cmd,pwd,timeout=200):
    handler = pexpect.spawn(rmt_cmd,timeout=timeout)

    if RMT_DEBUG_LOG:
        fout = rmt_open("rmt.log","ab+")
        handler.logfile_read = fout

    i = -1
    while True:
        handler.ignorecase = True
        i = handler.expect(['continue connectiong','password','Password',pexpect.EOF,pexpect.TIMEOUT],timeout=timeout)

        if i == 0:
            handler.sendline('yes')
        elif i == 1 or i == 2:
            handler.sendline(pwd)
        elif i == 3:
            handler.close()
            return 0
        elif i == 4:
            handler.close()
            return -2


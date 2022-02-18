# -*- coding:utf8 -*-
# author cuixinmiao
#date 2021-09-29

import os
import sys
import time
import paramiko
import configparser

"""解决qianbasecode 单独执行模块导入异常的问题"""
"""获取执行脚本的根路径"""
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
    from factory.conf import *
    from factory import testcase
    from factory import sshapp
    from factory.collect import write_logger
    from factory.testcase import Testcase
except Exception as e:
    sys.path.append(syspath)
    from factory.conf import *
    from factory import sshapp
    from factory import testcase
    from factory.collect import write_logger
    from factory.testcase import Testcase

#全局变量
config = configparser.ConfigParser()
basepath=os.getcwd()
confpath=os.path.join(basepath,"conf")
typeinfo = os.environ.get("typeinfo")
if typeinfo == None:
    print("%s get typeinfo failed"%__file__)
    sys.exit()
conffile = os.path.join(confpath,"config%s.txt"%typeinfo)
config.read(conffile)
sshpassword=config.get(typeinfo,"password").strip()
sshuser=config.get(typeinfo,"user").strip()
sshport=int(config.get(typeinfo,"sshport").strip())
timeout=30

###远程连接的baseclass
class SSHApp():

    #构造方法
    def __init__(self,confname=None,info={}):
        config = configparser.ConfigParser()
        basepath=os.getcwd()
        confpath=os.path.join(basepath,"conf")
        toolspath=os.path.join(basepath,"tools")
        self.confname = confname
        conffile = os.path.join(confpath,"config.txt")
        if self.confname:
            conffile = os.path.join(confpath,self.confname)
        config.read(conffile)
        self.binname = config.get("startbase","binname").strip()
        self.user = config.get("startbase","user").strip()
        self.password = config.get("startbase","password").strip()
        self.host = info.get("host")
        self.port = int(config.get("startbase","sshport").strip())
        if info.get("port"):
            self.port = int(info.get("port"))
        self.transport = self.Get_handler()
        if not self.transport:
            write_logger(logfile).error("创建远程连接失败")
            write_logger(logfile).error("获取 host: %s 句柄失败 sys.exit() 退出"%self.host)
            sys.exit()
        self.sftp = paramiko.SFTPClient.from_transport(self.transport)

    #获取服务器的句柄
    def Get_handler(self):
        host = self.host
        port = self.port
        password = self.password
        user = self.user

        try:
            transport = paramiko.Transport((host,port))
            transport.connect(username=user,password=password)
            self.ssh = paramiko.SSHClient()
            self.ssh._transport = transport
        except Exception as e:
            write_logger(logfile).error("获取服务器连接句柄失败 errmsg:%s"%e)
            transport = None
        return transport


    #执行linux cmd
    def cmd(self,command):
        if not self.transport:
            return None
        try:
            stdin,stdout,stderr = self.ssh.exec_command(command,timeout=timeout)
            if stderr:
                result = stdout.read()
                ret = str(result,encoding="utf-8")
                write_logger(logfile).debug("exec cmd %s result start"%command)
                for i in ret.split("\n"):
                    write_logger(logfile).debug("%s \n"%i)
                write_logger(logfile).debug("exec cmd %s result end"%command)
                return ret
            else:
                write_logger(logfile).error("exec cmd %s failed errret %s"%(command,str(stderr,encoding="utf-8")))
                return None
        except Exception as e:
            write_logger(logfile).error("exec cmd %s failed errmsg:%s"%(command,e))
            return None
        finally:
            pass
    
    #执行upload
    #第一个参数,
    def upload(self,loacal_path,target_path):
        self.sftp.put(local_path,target_path)


    #执行download
    def download(self,remote_path,local_path):
        self.sftp.get(remote_path,local_path)

    
    #析构函数
    def __del__(self):
        pass

#本地上传到服务器
def upload(local,remote,host,port=None,user=None,password=None):
    flag = False
    if not port:
        port = sshport
    if not user:
        user = sshuser
    if not password:
        password = sshpassword
    try:
            transport = paramiko.Transport((host,port))
            transport.connect(username=user,password=password)
            flag = True
            sftp = paramiko.SFTPClient.from_transport(transport)
            if not os.path.exists(local):
                write_logger(logfile).error("sftp please check local %s file is exists ??"%local)
                return None
            sftp.put(local,remote)
            return True
    except Exception as e:
        write_logger(logfile).error("sftp local %s to remote  %s:%s errmsg:%s"%(local,host,remote,e))
        return None
    finally:
        if flag:
            transport.close()


#本地上传到服务器
def download(remote,local,host,port=None,user=None,password=None):
    flag = False
    if not port:
        port = sshport
    if not user:
        user = sshuser
    if not password:
        password = sshpassword
    try:
            transport = paramiko.Transport((host,port))
            transport.connect(username=user,password=password)
            flag = True
            sftp = paramiko.SFTPClient.from_transport(transport)
            if os.path.exists(local):
                write_logger(logfile).warning("sftp please check local %s file is exists ."%local)
            sftp.get(remote,local)
            return True
    except Exception as e:
        write_logger(logfile).error("sftp local %s to remote  %s:%s errmsg:%s"%(local,host,remote,e))
        return None
    finally:
        if flag:
            transport.close()


#执行远程命令param1 ： cmd ,param2： ip
def cmd(cmd,host,port=None,user=None,password=None,timeout=60):
    flag=False
    if not port:
        port = sshport
    if not user:
        user = sshuser
    if not password:
        password = sshpassword
    try:
            transport = paramiko.Transport((host,port))
            transport.connect(username=user,password=password)
            flag=True
            ssh = paramiko.SSHClient()
            ssh._transport = transport
            write_logger(logfile).debug("exec command %s starting"%cmd)
            time.sleep(0.1)
            if timeout:
                stdin,stdout,stderr = ssh.exec_command(cmd,timeout)
            else:
                stdin,stdout,stderr = ssh.exec_command(cmd)
            time.sleep(0.1)
            reterr = stderr.read()
            ret = stdout.read()
            if reterr:
                print("%s "%host + str(reterr,encoding="utf-8"))
                return None
            if ret:
                write_logger(logfile).debug("host %s output command %s ret start"%(host,cmd))
                res = str(ret,encoding="utf-8").split("\n")
                for line in res:
                    write_logger(logfile).debug(line)
                write_logger(logfile).debug("host %s output command %s ret end"%(host,cmd))
                
            return ret
            #return str(stdout,encoding="utf-8")

    except Exception as e:
        write_logger(logfile).error("exec command %s failed errmsg:%s"%(cmd,e))
        write_logger(logfile).error("server info host:%s port:%d user:%s password:%s"%(host,port,user,password))
        return None
    finally:
        if flag:
            time.sleep(0.1)
            transport.close()


#执行远程唤醒命令
def exec_cmd(cmd,host,serverport):
    info = {"host":host}
    ssh = SSHApp(info=info)
    binname = ssh.binname
    execcmd = cmd%(binname,host,serverport)
    print(execcmd)
    ssh.cmd(execcmd)


if __name__ == "__main__":
    ssh = SSHApp()
    print(ssh.host)
    print(ssh.cmd("ls"))

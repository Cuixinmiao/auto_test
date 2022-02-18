# -*- coding:utf8 -*-
#################################
#date :2021-09-14
#function 安装qianbase数据库
#author :Xinmiao Cui
#copyright : esygn
#################################
#!/usr/bin/python

import os
import sys
import time
import configparser
import  psutil
from factory import rmt
from factory.collect import write_logger
from factory.conf import *
from factory import common

class Startup():

    config = configparser.ConfigParser()
    basepath=os.getcwd()
    confpath=os.path.join(basepath,"conf")
    toolspath=os.path.join(basepath,"tools")
    conffile = os.path.join(confpath,"config.txt")
    config.read(conffile)
    binname = config.get("startbase","binname").strip()
    securemode = config.get("startbase","securemod").strip()
    store = config.get("startbase","store").strip().split(",")
    locality = config.get("startbase","locality").strip().split("-")
    #locality=''
    advertiseaddr = config.get("startbase","advertise-addr").strip().split(",")
    listenaddr = config.get("startbase","listen-addr").strip().split(",")
    httpaddr = config.get("startbase","http-addr").strip().split(",")
    cache = config.get("startbase","cache").strip()
    init_ip = config.get("startbase","init_ip").strip()
    init_port = config.get("startbase","init_port").strip()
    maxsqlmemory = config.get("startbase","max-sql-memory").strip()
    join=""
    sep=","
    user = config.get("startbase","user").strip()
    password = config.get("startbase","password").strip()
    for index in range(len(advertiseaddr)):
        if index == len(advertiseaddr)-1:
            join=join+advertiseaddr[index]+":"+listenaddr[index]
        else:
            join=join+advertiseaddr[index]+":"+listenaddr[index]+sep
    execbin = os.path.join(toolspath,binname) 
    flag = False

    def __init__(self,binname=binname,securemode=securemode,store=store,locality=locality,advertiseaddr=advertiseaddr,listenaddr=listenaddr,httpaddr=httpaddr,cache=cache,maxsqlmemory=maxsqlmemory,join=join,execbin=execbin,user=user,password=password,init_ip=init_ip,init_port=init_port,fd={}):
        self.binname = binname
        config = configparser.ConfigParser()
        basepath=os.getcwd()
        confpath=os.path.join(basepath,"conf")
        toolspath=os.path.join(basepath,"tools")
        conffile = os.path.join(confpath,"config.txt")
        config.read(conffile)
        self.binname = config.get("startbase","binname").strip()
        if fd.get("binname"):
            self.binname = fd.get("binname")
        self.securemode = securemode
        if fd.get("securemode"):
            self.securemode = fd.get("securemode")
        self.store = store
        if fd.get("store"):
            self.store = fd.get("store")
        self.locality = locality
        if fd.get("locality"):
            self.locality = fd.get("locality")
        self.advertiseaddr = advertiseaddr
        if fd.get("advertiseaddr"):
            self.advertiseaddr = fd.get("advertiseaddr")
        self.listenaddr = listenaddr
        if fd.get("listenaddr"):
            self.listenaddr = fd.get("listenaddr")
        self.httpaddr = httpaddr
        if fd.get("httpaddr"):
            self.httpaddr = fd.get("httpaddr")
        self.cache = cache
        if fd.get("cache"):
            self.cache = fd.get("cache")
        self.maxsqlmemory = maxsqlmemory
        if fd.get("maxsqlmemory"):
            self.maxsqlmemory = fd.get("maxsqlmemory")
        sep = ","
        jointmp = ""
        self.join = join
        if fd.get("listenaddr") and fd.get("advertiseaddr"):
            for index in range(len(fd.get("advertiseaddr"))):
                if index == len(fd.get("advertiseaddr"))-1:
                    jointmp=jointmp+fd.get("advertiseaddr")[index]+":"+fd.get("listenaddr")[index]
                else:
                    jointmp=jointmp+fd.get("advertiseaddr")[index]+":"+fd.get("listenaddr")[index]+sep
            self.join = jointmp
        self.execbin = execbin
        if fd.get("binname"):
            self.execbin = os.path.join(Startup.toolspath,self.binname)
        self.user = user
        if fd.get("user"):
            self.user = fd.get("user")
        self.password = password
        if fd.get("password"):
            self.password = fd.get("password")
        self.init_ip = init_ip
        if fd.get("init_ip"):
            self.init_ip = fd.get("init_ip")
        self.init_port = init_port
        if fd.get("init_port"):
            self.init_port = fd.get("init_port")
        self.pids = psutil.pids()
        self.handlerp = psutil.Process
        self.piddict=[]

    def run(self,hatype=None):
        i=0
        #tmpjoin = ""
        #join1 = ",".join(self.join.split(",")[0:3])
        #join2 = ",".join(self.join.split(",")[3:-1])
        #join3 = self.join.split(",")[-1]
        #print("join1 : %s"%join1,"join2 : %s"%join2,"join3 : %s"%join3)
        self.teardown()
        if not Startup.flag:
            self.scp_qianbase()
        Startup.flag = True

        tmplen = len(self.join)
        for ip in self.advertiseaddr:
            login_str = "ssh %s@%s"%(self.user,ip)
            tmp=rmt.rmt_login(login_str,self.password)
            if tmp[0] == 0:
                self.handler=tmp[1]
            if len(self.store[i].split("-")) == 1:
                cmd = """%s start --%s --store=%s --advertise-addr=%s --listen-addr=:%s --http-addr=:%s --locality=%s --join=%s --cache=%s --max-sql-memory=%s --background"""%(self.binname,self.securemode,self.store[i],self.advertiseaddr[i],self.listenaddr[i],self.httpaddr[i],self.locality[i],self.join,self.cache,self.maxsqlmemory)
                #cmd = """%s start --%s --store=%s --advertise-addr=%s --listen-addr=:%s --http-addr=:%s --join=%s --cache=%s --max-sql-memory=%s --background"""%(self.binname,self.securemode,self.store[i],self.advertiseaddr[i],self.listenaddr[i],self.httpaddr[i],self.join,self.cache,self.maxsqlmemory)
                print(cmd)
            else:
                pass
            rett=rmt.rmt_cmd(self.handler,"rm -fr %s"%(self.store[i]))
            if rett == 0:
                write_logger(logfile).info("del dir %s success"%self.store[i])
            else:
                write_logger(filerport).error("del dir %s failed"%self.store[i])
                
            ret=rmt.rmt_cmd(self.handler,cmd)
            if ret == 0:
                write_logger(logfile).info("exec cmd %s success"%cmd)
            else:
                write_logger(logfile).error("exec cmd %s failed"%cmd)
            i+=1
            cmd=""
        #初始化实例
        init_cmd = "%s init --%s --host=%s:%s"%(self.binname,self.securemode,self.init_ip,self.init_port)
        ret1 = rmt.rmt_cmd(self.handler,init_cmd)
        if ret1 == 0:
            write_logger(logfile).info("exec init %s success"%init_cmd)
        else:
            write_logger(logfile).error("exec init %s failed"%init_cmd)
        #查看集群的状态
        check_stat = "%s node status --%s --host=%s:%s"%(self.binname,self.securemode,self.init_ip,self.init_port)
        time.sleep(3)
        rmt.rmt_cmd(self.handler,check_stat)
        ret2 = rmt.rmt_cmd(self.handler,check_stat)
        isablity=str(self.handler.before,encoding="utf-8").split("\n")
        for line in isablity:
            print(line+"\n")
        #lst=[]
        #for index in range(2,len(isablity)-2):
        #    if index == 2:
        #        continue
        #    print("%s\n"%isablity[index])
        #    lst.append(isablity[index].split()[-3])
        #for m in range(1,len(lst)):
        #    if not lst[m]:
        #        write_logger(logfile).error("chekc %s:%s service failed!!"%(self.advertiseaddr[m-1],self.listenaddr[m-1]))
        if ret2 == 0:
            write_logger(logfile).info("exec db status %s success"%check_stat)
            for line in isablity:
                write_logger(logfile).info("%s"%line)
        else:
            write_logger(logfile).error("exec db status %s failed"%check_stat)
        #查看数据库版本
        check_version = "%s version"%(self.binname)
        time.sleep(1)
        rmt.rmt_cmd(self.handler,check_version)
        ret3 = rmt.rmt_cmd(self.handler,check_version)
        isablity0=str(self.handler.before,encoding="utf-8").split("\n")
        for line in isablity0:
            print(line+"\n")

        if ret3 == 0:
            write_logger(logfile).info("check version %s success"%check_version)
        else:
            write_logger(logfile).error("check version %s failed"%check_version)

        rmt.rmt_close(self.handler)

        #注册license的语句
        try:
            ret = common.get_license()
            if ret:
                write_logger(logfile).info("Register license success")
            else:
                write_logger(logfile).error("Register license failed")

        except Exception as e:
            write_logger(logfile).error("Register license failed   %s failed errmsg: %s"%e)
            sys.exit()

    def init_instance(self,host):
        """初始化实例"""
        init_cmd = "%s init --%s --host=%s"%(self.binname,self.securemode,host)
        print(init_cmd)
        ret1 = rmt.rmt_cmd(self.handler,init_cmd)
        if ret1 == 0:
            write_logger(logfile).info("exec init %s success"%init_cmd)
        else:
            write_logger(logfile).error("exec init %s failed"%init_cmd)
        """查看集群的状态"""
        check_stat = "%s node status --%s --host=%s"%(self.binname,self.securemode,host)
        time.sleep(10)
        rmt.rmt_cmd(self.handler,check_stat)
        ret2 = rmt.rmt_cmd(self.handler,check_stat)
        isablity=str(self.handler.before,encoding="utf-8").split("\n")
        for line in isablity:
            print(line+"\n")
        if ret2 == 0:
            write_logger(logfile).info("exec db status %s success"%check_stat)
            for line in isablity:
                write_logger(logfile).info("%s"%line)
        else:
            write_logger(logfile).error("exec db status %s failed"%check_stat)

        rmt.rmt_close(self.handler)
        #查看数据库版本
        check_version = "%s version"%(self.binname)
        time.sleep(1)
        rmt.rmt_cmd(handler,check_version)
        ret3 = rmt.rmt_cmd(handler,check_version)
        isablity0=str(handler.before,encoding="utf-8").split("\n")
        for line in isablity0:
            print(line+"\n")

        if ret3 == 0:
            write_logger(logfile).info("check version %s success"%check_version)
        else:
            write_logger(logfile).error("check version %s failed"%check_version)

        rmt.rmt_close(handler)


        #注册license的语句
        try:
            ret = common.get_license()
            if ret:
                write_logger(logfile).info("Register license success")
            else:
                write_logger(logfile).error("Register license failed")

        except Exception as e:
            write_logger(logfile).error("Register license failed   %s failed errmsg: %s"%e)
            sys.exit()



    def scp_qianbase(self):
        listip = list(set(self.advertiseaddr))
        for ip in listip:
            rmt_cmd = "scp %s %s@%s:/usr/bin/"%(self.execbin,self.user,ip)
            ret = rmt.rmt_exec(rmt_cmd,self.password)
            if ret == 0:
                write_logger(logfile).info("scp %s to %s include /usr/bin/ success!!"%(self.execbin,ip))
            else:
                write_logger(logfile).error("scp %s to %s include /usr/bin/ failed!!"%(self.execbin,ip))

    def upload_scp(self,localpath,remotepath):
        listip = list(set(self.advertiseaddr))
        for ip in listip:
            rmt_cmd = "scp %s %s@%s:%s"%(localpath,self.user,ip,remotepath)
            ret = rmt.rmt_exec(rmt_cmd,self.password)
            if ret == 0:
                write_logger(logfile).info("scp %s to %s include /usr/bin/ success!!"%(localpath,ip))
            else:
                write_logger(logfile).error("scp %s to %s include /usr/bin/ failed!!"%(localpath,ip))
    
    def teardown(self,cmd=None):
        killcmd="ps -fe|grep -v grep|grep %s|awk '{print $8,$2}'|grep ^%s |awk '{print $2}'| while read line;do kill -9 $line; done"%(self.binname,self.binname)
        print(killcmd)
        listip1 = list(set(self.advertiseaddr))
        for ip in listip1:
            login_str = "ssh %s@%s"%(self.user,ip)
            tmp=rmt.rmt_login(login_str,self.password)
            if tmp[0] == 0:
                handler=tmp[1]
            ret=rmt.rmt_cmd(handler,killcmd)
            if ret == 0:
                write_logger(logfile).info("kill qianbase process success!!")
            else:
                write_logger(logfile).error("kill qianbase process failed!!")
            if cmd:
                ret=rmt.rmt_cmd(handler,cmd)
                if ret == 0:
                    write_logger(logfile).info("server exec %s success!!"%cmd)
                else:
                    write_logger(logfile).error("server exec %s failed!!"%cmd)


    def get_esgyn_pid(self):
        for pid in self.pids:
            pidname = self.handlerp(pid).name()
            if pidname == self.binname:
                self.piddict.append((self.binname,pid))
        return self.piddict

def inst_xtp(fd={}):
    try:
        st = Startup(fd)
        st.run()
    except Exception as e:
        write_logger(logfile).error("inst qianbase db failed err:%s"%e)

if __name__ == '__main__':
    pass

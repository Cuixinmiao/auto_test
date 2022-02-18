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
from factory import sshapp
from factory import common

class Startup():

    def __init__(self,fd={}):

        try:
            self.hainfo = fd.get("hatype")
            if not self.hainfo:
                self.hainfo = os.environ.get("typeinfo")
            config = configparser.ConfigParser()
            self.basepath=os.getcwd()
            self.confpath=os.path.join(self.basepath,"conf")
            self.toolspath=os.path.join(self.basepath,"tools")
            self.instpath = os.path.join(self.toolspath,"%s"%self.hainfo)
            self.initsqlpath = os.path.join(self.basepath,"initsql")
            sqlfile="%s.sql"%self.hainfo
            self.remotepath="/tmp"
            self.remotefile=os.path.join(self.remotepath,sqlfile)
            self.sqlfilepath = os.path.join(self.initsqlpath,sqlfile)
            self.libgeos = os.path.join(self.instpath,"libgeos.so")
            self.libgeos_c = os.path.join(self.instpath,"libgeos_c.so")
            conffile = os.path.join(self.confpath,"config%s.txt"%self.hainfo)
            config.read(conffile)
            #ha331 init primary and uprimary 原生 0; 1 rid=1 for primary room ;2 rid=2 for primary 3 rid=3 for primary
            self.init = config.get(self.hainfo,"init").strip()
            self.chaosblade = "chaosblade_"+config.get(self.hainfo,"chaosblade").strip()
            self.chaosbladepath = os.path.join(self.toolspath,self.chaosblade)
            self.sshport = config.get(self.hainfo,"sshport").strip()
            self._binname = config.get(self.hainfo,"binname").strip()
            self._bindir = config.get(self.hainfo,"bindir").strip()
            self.binname = os.path.join(self._bindir,self._binname)
            self.securemode = config.get(self.hainfo,"securemod").strip()
            if self.securemode == "secure":
                secdir = os.path.join(config.get("certs","basecerts").strip(),config.get("certs","certs").strip())
                self.securemode = "certs-dir=%s"%secdir
            self.store = config.get(self.hainfo,"store").strip()
            self.locality = config.get(self.hainfo,"locality").strip().split("-")
            self.advertiseaddr1 = config.get(self.hainfo,"advertise-addr").strip().split(",")
            tmplst=[]
            self.startnum = self.advertiseaddr1
            if "-" in self.advertiseaddr1[0]:
                for i in self.advertiseaddr1:
                    tmplst.append(i.split("-")[0])
                if tmplst:
                    self.advertiseaddr = tmplst
            else:
                self.advertiseaddr = self.advertiseaddr1
            self.listenaddr = config.get(self.hainfo,"listen-addr").strip()
            self.httpaddr = config.get(self.hainfo,"http-addr").strip()
            self.cache = config.get(self.hainfo,"cache").strip()
            self.init_ip = config.get(self.hainfo,"init_ip").strip()
            self.init_port = config.get(self.hainfo,"init_port").strip()
            self.timezone = config.get(self.hainfo,"timezone").strip()
            self.locksize = config.get(self.hainfo,"locksize").strip()
            self.maxsqlmemory = config.get(self.hainfo,"max-sql-memory").strip()
            self.join=""
            self.join1=""
            sep=","
            self.user = config.get(self.hainfo,"user").strip()
            self.password = config.get(self.hainfo,"password").strip()
            for index in range(len(self.advertiseaddr)):
                if index == len(self.advertiseaddr)-1:
                    self.join1=self.join1+self.advertiseaddr[index]+":"+self.listenaddr
                else:
                    self.join1=self.join1+self.advertiseaddr[index]+":"+self.listenaddr+sep

            if "-" not in self.advertiseaddr1[0]:
                for index in range(len(self.advertiseaddr)):
                    if index == len(self.advertiseaddr)-1:
                        self.join=self.join+self.advertiseaddr[index]+":"+self.listenaddr
                    else:
                        self.join=self.join+self.advertiseaddr[index]+":"+self.listenaddr+sep
            else:
                for tmpidx in range(len(self.advertiseaddr1)):
                    num = (self.advertiseaddr1[tmpidx]).split("-")[0]
                    num = (self.advertiseaddr1[tmpidx]).split("-")[1]
                    if tmpidx == len(self.advertiseaddr) - 1:
                        for index in range(0,int(num)):
                            if index == int(num) - 1:
                                self.join=self.join+self.advertiseaddr[tmpidx]+ ":" + str(int(self.listenaddr) + index)
                            else:
                                self.join=self.join+self.advertiseaddr[tmpidx] + ":" + str(int(self.listenaddr)+index) + sep
                    else:
                        for index in range(0,int(num)):
                            self.join=self.join + self.advertiseaddr[tmpidx] + ":" + str(int(self.listenaddr) + index) + sep
            self.execbin = os.path.join(self.instpath,self._binname) 

            
            #haproxy config info ip and port
            self.client_ip = config.get(self.hainfo,"client_ip").strip()
            self.client_port = config.get(self.hainfo,"client_port").strip()

            flag = False

            if fd.get("binname"):
                self.binname = fd.get("binname")
            if fd.get("securemode"):
                self.securemode = fd.get("securemode")
            if fd.get("store"):
                self.store = fd.get("store")
            if fd.get("locality"):
                self.locality = fd.get("locality")

            if fd.get("advertiseaddr"):
                self.advertiseaddr = fd.get("advertiseaddr")
            if fd.get("listenaddr"):
                self.listenaddr = fd.get("listenaddr")
            if fd.get("httpaddr"):
                self.httpaddr = fd.get("httpaddr")
            if fd.get("cache"):
                self.cache = fd.get("cache")
            if fd.get("maxsqlmemory"):
                self.maxsqlmemory = fd.get("maxsqlmemory")
            sep = ","
            jointmp = ""
            if fd.get("listenaddr") and fd.get("advertiseaddr"):
                for index in range(len(fd.get("advertiseaddr"))):
                    if index == len(fd.get("advertiseaddr"))-1:
                        jointmp=jointmp+fd.get("advertiseaddr")[index]+":"+fd.get("listenaddr")[index]
                    else:
                        jointmp=jointmp+fd.get("advertiseaddr")[index]+":"+fd.get("listenaddr")[index]+sep
                self.join = jointmp
            if fd.get("binname"):
                self.execbin = os.path.join(self.instspath,self.binname)
            if fd.get("user"):
                self.user = fd.get("user")
            if fd.get("password"):
                self.password = fd.get("password")
            if fd.get("init_ip"):
                self.init_ip = fd.get("init_ip")
            if fd.get("init_port"):
                self.init_port = fd.get("init_port")
            self.pids = psutil.pids()
            self.handlerp = psutil.Process
            self.piddict=[]
        except Exception as e:
            write_logger(logfile).error("Startup class __init__ set parameters failed errmsg:%s"%e)
            print("please check startup init method!!!")
            sys.exit()

    def run(self,hatype=None):
        #清理环境
        self.teardown()
        #主备初始化环境
        self.pre_env()
        ##gen certs ca.key
        #if self.securemode != "insecure":
        #    self.set_certs()
        ##scp_qianbase 
        #retcode = self.scp_qianbase()
        #if not retcode:
        #    write_logger(logfile).error("please place execbin to tools path %s"%self.execbin)
        #    sys.exit()
        ##scp 远程到/usr/lib64/的静态库
        #self.upload_scp(self.libgeos,"/usr/lib64")
        #self.upload_scp(self.libgeos_c,"/usr/lib64")
        #sftp local to remote sqlfile
        try:
            sshapp.upload(self.sqlfilepath,self.remotefile,self.init_ip)
        except Exception as e:
            write_logger(logfile).error("sshapp.upload local %s to remote %s failed errmsg:%s "%(self.sqlfilepath,self.remotefile,e))
            return None
        #基数
        i=0
        tmplen = len(self.join)
        for ip_num in self.startnum:
            ip = ip_num
            num=1
            if "-" in ip_num:
                ip = ip_num.split("-")[0]
                num = ip_num.split("-")[1]
            tempqianbase="/data1/qianbase_temp"
            sshapp.cmd("rm -fr %s;mkdir -p %s"%(tempqianbase,tempqianbase),ip)
            login_str = "ssh %s@%s"%(self.user,ip)
            tmp=rmt.rmt_login(login_str,self.password)
            if tmp[0] == 0:
                self.handler=tmp[1]
            for j in range(0,int(num)):
                datadir = self.store.format(str(j+1))
                if j >= 4:
                    locality = self.locality[i].format(str(2))
                else:
                    locality = self.locality[i].format(str(1))
                if j >=4:
                    m=j%4
                    cmd = """numactl --cpunodebind=%s --membind=%s  %s start  --%s --accept-sql-without-tls  --store=%s --temp-dir=%s --timezone=%s --lock-table-size=%s --advertise-addr=%s --listen-addr=:%s --http-addr=:%s --locality=%s --join=%s --cache=%s --max-sql-memory=%s --background"""\
                        %(m,m,self.binname,self.securemode,datadir,os.path.join(tempqianbase,str(int(self.listenaddr)+j)),self.timezone,self.locksize,ip,str(int(self.listenaddr)+j),str(int(self.httpaddr)+j),locality,self.join1,self.cache,self.maxsqlmemory)
                else:
                    cmd = """numactl --cpunodebind=%s --membind=%s  %s start  --%s --accept-sql-without-tls  --store=%s --temp-dir=%s  --timezone=%s --lock-table-size=%s --advertise-addr=%s --listen-addr=:%s --http-addr=:%s --locality=%s --join=%s --cache=%s --max-sql-memory=%s --background"""\
                        %(j,j,self.binname,self.securemode,datadir,os.path.join(tempqianbase,str(int(self.listenaddr)+j)),self.timezone,self.locksize,ip,str(int(self.listenaddr)+j),str(int(self.httpaddr)+j),locality,self.join1,self.cache,self.maxsqlmemory)
                sshapp.cmd("rm -fr {0};mkdir -p {0}".format(os.path.join(tempqianbase,str(int(self.listenaddr)+j))),ip)
                #print(cmd)
                #else:
                #    pass
                try:
                    # del instance dir
                    sshapp.cmd("rm -fr %s"%datadir,ip)
                    write_logger(logfile).info("del dir [ %s] success !!!"%datadir)
                    #startup instances 
                    ret = rmt.rmt_cmd(self.handler,cmd)
                    if ret == 0:
                        write_logger(logfile).info("exec command %s success !!"%cmd)
                    else:
                        write_logger(logfile).error("exec command %s failed errmsg %s"%(cmd,ret))
                except Exception as e:
                    write_logger(logfile).error("inst command %s failed %s"%(cmd,e))
            i+=1
            cmd=""

        rmt.rmt_close(self.handler)
        #初始化实例
        if self.init == "1" or self.init == "2" or self.init == "3":
            init_cmd = "%s init %s  --%s --host=%s:%s"%(self.binname,self.init,self.securemode,self.init_ip,self.init_port)
        else:
            init_cmd = "%s init  --%s --host=%s:%s"%(self.binname,self.securemode,self.init_ip,self.init_port)

        ret1 = sshapp.cmd(init_cmd,self.init_ip,timeout=30)
        if ret1:
            write_logger(logfile).info("exec init %s success"%init_cmd)
        else:
            write_logger(logfile).error("exec init %s failed"%init_cmd)
        
        #获取数据库的版本信息
        ipversion = self.advertiseaddr[0]
        sshapp.cmd("%s version"%self.binname,ipversion)
        #查看集群的状态
        check_stat = "%s node status --%s --host=%s:%s"%(self.binname,self.securemode,self.init_ip,self.init_port)
        login_str = "ssh %s@%s"%(self.user,self.init_ip)
        tmp=rmt.rmt_login(login_str,self.password)
        if tmp[0] == 0:
            handler = tmp[1]
            time.sleep(10)
            rmt.rmt_cmd(handler,check_stat)
            ret2 = rmt.rmt_cmd(handler,check_stat)
            isablity=str(handler.before,encoding="utf-8").split("\n")
            for line in isablity: 
                print(line+"\n")
            if ret2 == 0:
                write_logger(logfile).info("exec db status %s success"%check_stat)
                for line in isablity:
                    write_logger(logfile).info("%s"%line)
            else:
                write_logger(logfile).error("exec db status %s failed"%check_stat)
        else:
            retp = sshapp.cmd(check_stat,self.init_ip)
            isablity=str(ret,encoding="utf-8").split("\n")
            for line in isablity:
                print(line+"\n")
        handler.close()


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

        #执行初始化集群的sql文件
        if self.init == "1" or self.init == "2" or self.init == "3": 
            try:
                cmd = "%s sql --%s --host=%s:%s -f %s"%(self.binname,self.securemode,self.init_ip,self.init_port,self.remotefile)
                sshapp.cmd(cmd,self.init_ip)
                write_logger(logfile).info("init sql cmd %s success "%cmd)
            except Exception as e :
                write_logger(logfile).error("init sql cmd %s failed errmsg: %s"%(cmd,e))
                print("请查看log %s"%(os.path.join(os.getcwd(),logfile)))
                sys.exit()
            #check qianbase replicas
            try:
                ckrep = common.check_replicas()
                write_logger(logfile).info("exec check replicas success")
                if not ckrep:
                    write_logger(logfile).error("exec check replicas failed")
            except Exception as e:
                write_logger(logfile).error("exec check replicas failed errmsg:%s"%e)
                sys.exit()


    def pre_env(self):
        #gen certs ca.key
        if self.securemode != "insecure":
            self.set_certs()
        #scp_qianbase 
        retcode = self.scp_qianbase()
        if not retcode:
            write_logger(logfile).error("please place execbin to tools path %s"%self.execbin)
            sys.exit()
        #scp 远程到/usr/lib64/的静态库
        self.upload_scp(self.libgeos,"/usr/lib64")
        self.upload_scp(self.libgeos_c,"/usr/lib64")

    def start_run(self,startnum=None):
        #start_num 赋值为默认值
        if not startnum:
            startnum = self.startnum
        #基数
        try:
            i=0
            #tmplen = len(self.join)
            for ip_num in startnum:
                ip = ip_num
                num=1
                if "-" in ip_num:
                    ip = ip_num.split("-")[0]
                    num = ip_num.split("-")[1]
                login_str = "ssh %s@%s"%(self.user,ip)
                tmp=rmt.rmt_login(login_str,self.password)
                tempqianbase="/data1/qianbase_temp"
                sshapp.cmd("rm -fr %s;mkdir -p %s"%(tempqianbase,tempqianbase),ip)
                if tmp[0] == 0:
                    self.handler=tmp[1]
                for j in range(0,int(num)):
                    datadir = self.store.format(str(j+1))
                    if j >= 4:
                        locality = self.locality[i].format(str(2))
                    else:
                        locality = self.locality[i].format(str(1))
                    if j >=4:
                        m=j%4
                        cmd = """numactl --cpunodebind=%s --membind=%s  %s start   --%s --accept-sql-without-tls --store=%s --temp-dir=%s  --timezone=%s --lock-table-size=%s --advertise-addr=%s --listen-addr=:%s --http-addr=:%s --locality=%s --join=%s --cache=%s --max-sql-memory=%s  --background"""\
                            %(m,m,self.binname,self.securemode,datadir,os.path.join(tempqianbase,str(int(self.listenaddr)+j)),self.timezone,self.locksize,ip,str(int(self.listenaddr)+j),str(int(self.httpaddr)+j),locality,self.join1,self.cache,self.maxsqlmemory)
                    else:
                        cmd = """numactl --cpunodebind=%s --membind=%s  %s start   --%s --accept-sql-without-tls --store=%s  --temp-dir=%s  --timezone=%s --lock-table-size=%s --advertise-addr=%s --listen-addr=:%s --http-addr=:%s --locality=%s --join=%s --cache=%s --max-sql-memory=%s  -background"""\
                            %(j,j,self.binname,self.securemode,datadir,os.path.join(tempqianbase,str(int(self.listenaddr)+j)),self.timezone,self.locksize,ip,str(int(self.listenaddr)+j),str(int(self.httpaddr)+j),locality,self.join1,self.cache,self.maxsqlmemory)
                    print(cmd)
                    #else:
                    #    pass
                    try:
                    #    rett=rmt.rmt_cmd(self.handler,"rm -fr %s"%datadir)
                    #    if rett == 0:
                    #        write_logger(logfile).info("del dir %s success"%datadir)
                    #    else:
                    #        write_logger(filerport).error("del dir %s failed"%datadir)
                    #        
                        ret=rmt.rmt_cmd(self.handler,cmd)
                        if ret == 0:
                            write_logger(logfile).info("exec cmd %s success"%cmd)
                        else:
                            write_logger(logfile).error("exec cmd %s failed"%cmd)
                    except Exception as e:
                        write_logger(logfile).error("inst command %s failed %s"%(cmd,e))
                i+=1
                cmd=""
        except Exception as e:
            write_logger(logfile).error("startup instance  %s failed"%e)
            pass

        finally:
            rmt.rmt_close(self.handler)

    #设置证书的操作
    def set_certs(self):
        #判断文件是否存在
        if not os.path.exists(self.execbin):
            write_logger(logfile).error("please place execbin to tools path %s"%self.execbin)
            print("please place execbin to tools path %s"%self.execbin)

        #clear client local env and gen lic cert 
        common.gen_client()
        
        # gen user lic default root
        common.gen_user_cli()  

        #send node.crt,node.key to node server 
        for host in set(self.advertiseaddr):
            common.gen_server(host)



    def stop_run(self):
        self.teardown()

    #scp qianbase 的二进制文件,此文件放置在tools/qianbase
    def scp_qianbase(self):
        try:
            listip = list(set(self.advertiseaddr))
            if os.path.exists(self.execbin):
                for ip in listip:

                    rmt_cmd = "scp -r -P %s %s %s@%s:/usr/bin/"%(self.sshport,self.execbin,self.user,ip)
                    ret = rmt.rmt_exec(rmt_cmd,self.password,timeout=300)
                    if ret == 0:
                        write_logger(logfile).debug("scp %s to %s include /usr/bin/ success %s!!"%(self.execbin,ip,rmt_cmd))
                    else:
                        write_logger(logfile).error("scp %s to %s include /usr/bin/ failed!! %s"%(self.execbin,ip,rmt_cmd))
                        return False
                return True
            else:
                write_logger(logfile).error("scp %s is not exists !!!"%self.execbin)
                return False
        except Exception as e:
            write_logger(logfile).error("scp %s failed"%self.execbin)
            return False
        finally:
            pass

    def upload_scp(self,localpath,remotepath):
        
        listip = list(set(self.advertiseaddr))
        try:
            if os.path.exists(localpath):
                for ip in listip:
                    rmt_cmd = "scp -r -P %s %s %s@%s:%s"%(self.sshport,localpath,self.user,ip,remotepath)
                    ret = rmt.rmt_exec(rmt_cmd,self.password)
                    if ret == 0:
                        write_logger(logfile).debug("scp %s to %s include /usr/bin/ success!! %s"%(localpath,ip,rmt_cmd))
                    else:
                        write_logger(logfile).error("scp %s to %s include /usr/bin/ failed!! %s"%(localpath,ip,rmt_cmd))
                        return False
                return True
            else:
                write_logger(logfile).error("check localpath %s is or not exists!!! %s"%rmt_cmd)
                return False
        except Exception as e:
            write_logger(logfile).error("class Startup upload_scp  local to remote scp cmd failed errmsg:%s"%e)
            return False
        finally:
            pass
    

    #请洗开始执行的环境,kill掉数据库的服务
    def teardown(self,prefix=None,cmd=None):
        try:
            killcmd="ps -fe|grep -v grep|grep %s|awk '{print $2}'|while read line;do kill -9 $line; done"%self.binname
            if prefix:
                killcmd="ps -fe|grep -v grep|grep %s|awk '{print $2}'|while read line;do kill -9 $line; done"%prefix
            #killcmd="kill -9 `pidof %s`"%self.binname
            listip1 = list(set(self.advertiseaddr))
            for ip in listip1:
                login_str = "ssh %s@%s -p %s"%(self.user,ip,self.sshport)
                write_logger(logfile).debug("stop server %s  ip : %s start !!!"%(self.binname,ip))
                tmp=rmt.rmt_login(login_str,self.password)
                if tmp[0] == 0:
                    handler=tmp[1]
                ret=rmt.rmt_cmd(handler,killcmd)
                if ret == 0:
                    write_logger(logfile).debug("kill qianbase process success!!")
                else:
                    write_logger(logfile).error("kill qianbase process failed!!")
                if cmd:
                    ret=rmt.rmt_cmd(handler,cmd)
                    if ret == 0:
                        write_logger(logfile).info("server exec %s success!!"%cmd)
                    else:
                        write_logger(logfile).error("server exec %s failed!!"%cmd)
                write_logger(logfile).info("stop server %s  ip : %s end !!!"%(self.binname,ip))
            return True


        except Exception as e:
            write_logger(logfile).error("stop server %s  ip : %s failed errmsg:%s !!!"%(self.binname,ip,e))
            return False
        finally:
            write_logger(logfile).info("stop all server end !!!")
            rmt.rmt_close(handler)


    def get_esgyn_pid(self):
        for pid in self.pids:
            pidname = self.handlerp(pid).name()
            if pidname == self.binname:
                self.piddict.append((self.binname,pid))
        return self.piddict


#请洗开始执行的环境,kill掉数据库的服务
def teardown(cmd,hatype=os.environ["typeinfo"]):
    info = {"hatype":hatype}
    obj = Startup(info)
    try:
        listip1 = list(set(obj.advertiseaddr))
        for ip in listip1:
            login_str = "ssh %s@%s -p %s"%(obj.user,ip,obj.sshport)
            write_logger(logfile).debug("exec  %s  ip : %s start !!!"%(cmd,ip))
            tmp=rmt.rmt_login(login_str,obj.password)
            if tmp[0] == 0:
                handler=tmp[1]
                ret=rmt.rmt_cmd(handler,cmd)
                if ret == 0:
                    write_logger(logfile).debug("server exec %s success!!"%cmd)
                else:
                    write_logger(logfile).error("server exec %s failed!!"%cmd)
            write_logger(logfile).info("exec  %s  ip : %s end !!!"%(cmd,ip))
        return True
    except Exception as e:
        write_logger(logfile).error("exec  %s  ip : %s failed errmsg:%s!!!"%(cmd,ip,e))
        return False
    finally:
        pass

#本地目录拷贝到远程文件夹下,文件也 support
def upload_scp(localpath=None,remotepath="/etc/",host=None,hatype="ha331"):
     
    info = {"hatype":hatype}
    obj = Startup(info)
    if not localpath:
        localpath = obj.chaosbladepath
    if not host:
        listip = list(set(obj.advertiseaddr))
        try:
            if os.path.exists(localpath):
                for ip in listip:
                    rmt_cmd = "scp -r -P %s %s %s@%s:%s"%(obj.sshport,localpath,obj.user,ip,remotepath)
                    ret = rmt.rmt_exec(rmt_cmd,obj.password)
                    if ret == 0:
                        write_logger(logfile).info("scp %s to %s success!! %s"%(localpath,ip,rmt_cmd))
                    else:
                        write_logger(logfile).error("scp %s to %s  failed!! %s"%(localpath,ip,rmt_cmd))
                        return False
                return True
            else:
                write_logger(logfile).error("check localpath %s is or not exists!!!"%localpath)
                return False

        except Exception as e:
            write_logger(logfile).error("inst331 func upload_scp  local to remote scp cmd failed errmsg:%s"%e)
            return False

        finally:
            pass
    else:
        try:
            if os.path.exists(localpath):
                rmt_cmd = "scp -r -P %s %s %s@%s:%s"%(obj.sshport,localpath,obj.user,host,remotepath)
                ret = rmt.rmt_exec(rmt_cmd,obj.password)
                if ret == 0:
                    write_logger(logfile).debug("scp %s to %s success!! %s"%(localpath,host,rmt_cmd))
                    return True
                else:
                    write_logger(logfile).error("scp %s to %s  failed! ! %s"%(localpath,host,rmt_cmd))
                    return False

        except Exception as e:
            write_logger(logfile).error("inst331 func upload_scp  local to remote scp cmd failed errmsg:%s"%e)
            return False

        finally:
            pass



def inst_xtp(fd={}):
    try:
        st = Startup(fd)
        st.run()
    except Exception as e:
        write_logger(logfile).error("inst qianbase db failed err:%s"%e)

if __name__ == '__main__':
    pass

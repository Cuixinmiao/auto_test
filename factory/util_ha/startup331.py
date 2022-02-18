import os
import sys
import time
import configparser
import subprocess
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
    from factory import collect
    from factory import sshapp
    from factory.collect import write_logger
    from factory.testcase import Testcase
    from factory.util_ha.inst331 import Startup
    from factory.common import *
except Exception as e:
    sys.path.append(syspath)
    from factory.conf import *
    from factory import sshapp
    from factory import testcase
    from factory.collect import write_logger
    from factory.testcase import Testcase
    from factory.util_ha.inst331 import Startup
    from factory.common import *






"""获取基本信息"""
class BaseCls(Startup):

    def __init__(self):

        super().__init__()
        self.amount = config.get(self.hainfo,"amount").strip()
        self.rid1rep = config.get(self.hainfo,"rid1rep").strip()
        self.rid1 = self.rid1rep.split(",")[0]
        self.prep = self.rid1rep.split(",")[1]
        self.rid2rep = config.get(self.hainfo,"rid2rep").strip()
        self.rid2 = self.rid2rep.split(",")[0]
        self.brep = self.rid2rep.split(",")[1]
        self.rid3rep = config.get(self.hainfo,"rid3rep").strip()
        self.rid3 = self.rid3rep.split(",")[0]
        self.rrep = self.rid3rep.split(",")[1]
        self.totrep = int(self.prep) + int(self.brep) + int(self.rrep)
        self.sqlname = os.path.join(self.initsqlpath,"setckpt.sql")
        self.debug = config.get(self.hainfo,"debug").strip()
        self.instances = None
        count_len = 0
        if "-" in self.advertiseaddr1[0]:
            for i in self.advertiseaddr1:
                count_len = count_len + int(i.split("-")[1])
            if count_len:
                self.instances = count_len
        else:
            self.instances = len(self.advertiseaddr1)

        self.args = []
        if 'backip' in config.options(self.hainfo):
            self.backip = config.get(self.hainfo,"backip").strip().split("-")
            for ipnumregion in self.backip:
                j=0
                ip = ipnumregion.strip().split("@")[0]
                self.join2 = self.join1 +","+ip+":"+str(self.listenaddr)
                num = ipnumregion.strip().split("@")[1]
                locality = ipnumregion.strip().split("@")[2]
                for n in range(0,int(num)):
                    datadir = self.store.format(str(j+1))
                    self.cmd = """%s start --%s --store=%s --timezone=%s --lock-table-size=%s --advertise-addr=%s --listen-addr=:%s --http-addr=:%s --locality=%s --join=%s --cache=%s --max-sql-memory=%s --background"""%(self.binname,self.securemode,datadir,self.timezone,self.locksize,ip,str(int(self.listenaddr)+j),str(int(self.httpaddr)+j),locality,self.join2,self.cache,self.maxsqlmemory)
                    self.args.append((ip,datadir,self.cmd))
                    j=j+1
        self.remoteargs = []
        self.expansion_ip = []
        if 'remoteip' in config.options(self.hainfo):
            self.remoteip = config.get(self.hainfo,"remoteip").strip().split("-")
            for ipnumregion in self.remoteip:
                j=0
                ip = ipnumregion.strip().split("@")[0]
                self.join3 = self.join1 +","+ip+":"+str(self.listenaddr)
                num = ipnumregion.strip().split("@")[1]
                locality = ipnumregion.strip().split("@")[2]
                for n in range(0,int(num)):
                    self.expansion_ip.append("%s:%s"%(ip,str(int(self.listenaddr)+j)))
                    datadir = self.store.format(str(j+1))
                    cmd = """%s start --%s --store=%s --timezone=%s --lock-table-size=%s --advertise-addr=%s --listen-addr=:%s --http-addr=:%s --locality=%s --join=%s --cache=%s --max-sql-memory=%s --background"""%(self.binname,self.securemode,datadir,self.timezone,self.locksize,ip,str(int(self.listenaddr)+j),str(int(self.httpaddr)+j),locality,self.join2,self.cache,self.maxsqlmemory)
                    self.remoteargs.append((ip,datadir,cmd))
                    j=j+1
        
    """set cltuster setting ckpt"""
    def set_ckpt(self):
        try:
            exec_sql_file(self.init_ip,self.init_port,self.sqlname)
            write_logger(logfile).info("exec set custer setting ckpt success ")
            time.sleep(30)
            #self.check_replicas()
            return True
        except Exception as e:
            write_logger(logfile).error("exec set cluster setting ckpt failed errmsg %s"%e)
            return None


    """exec tpcc work load data"""
    def exec_tpcc(self,timeout=600):
        try:
            exec_tpcc_workload(self.client_ip,self.client_port,self.amount,timeout)
            write_logger(logfile).info("exec tpcc workload end")
            time.sleep(30)
            #self.check_replicas()
            return True
        except Exception as e:
            write_logger(logfile).error("exec tpcc workload failed errmsg :%s"%e)




    """default run time 3min and warehouses equal workers"""
    def exec_tpcc_business(self,client_ip=None,client_port=None,duration=3,worker=None):
        if not worker:
            worker = self.amount
        if client_ip and client_port:
            cmd = tpccworkload_run.format(self.amount,worker,duration,client_ip,client_port)
            write_logger(logfile).info("exec tpcc run %s"%cmd)
        else:
            cmd = tpccworkload_run.format(self.amount,worker,duration,self.client_ip,self.client_port)
            write_logger(logfile).info("exec tpcc run %s"%cmd)
        p = subprocess.Popen(cmd,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        return p 

    #install ha331 qianbasedb
    def instha(self,cmd=None):
        try:
            #执行安装
            self.run(self.hainfo)
            write_logger(logfile).info("ha cluster type %s install success"%self.hainfo)
        except Exception as e:
            write_logger(logfile).error("ha cluster type %s install failed errmsg:%s"%(self.hainfo,e))
            print("ha cluster type %s install failed errmsg:%s"%(self.hatype,e))
            sys.exit()
        finally:
            pass


#get param info 
obj = BaseCls()
confpath = obj.confpath
securemode = obj.securemode
typeinfo = os.environ.get("typeinfo")
config = configparser.ConfigParser()
config.read("%s/config%s.txt"%(confpath,typeinfo))
bindir = config.get(typeinfo,"bindir").strip()
binname = config.get(typeinfo,"binname").strip()
toolsinstpath = obj.toolspathinst
from factory import multithread


def get_wakeraft_unprimary(unrid,ipport=None,timeout=40):
    if ipport:
        nodestatuscmd = "%s/%s node status --ranges --%s --host=%s|grep rid|grep -v rid=%s|awk '{sum=sum+$13+$14}END{print sum}'"%(toolsinstpath,binname,securemode,ipport,unrid)
        sqlcmd = "%s/%s sql --%s --host=%s -e '%s'"%(toolsinstpath,binname,securemode,ipport,lease_preference)
    else:
        nodestatuscmd = "%s/%s node status --ranges --%s --host=%s:%s|grep rid|grep -v rid=%s|awk '{sum=sum+$13+$14}END{print sum}'"%(toolsinstpath,binname,securemode,obj.init_ip,obj.init_port,unrid)
        sqlcmd = '''%s/%s sql  --%s --host=%s:%s -e "%s"'''%(toolsinstpath,binname,securemode,obj.init_ip,obj.init_port,lease_preference)
    if int(unrid) == 1:
        execsql = sqlcmd.format(obj.rid1)
    elif int(unrid) == 2:
        execsql = sqlcmd.format(obj.rid2)
    elif int(unrid) == 3:
        execsql = sqlcmd.format(obj.rid3)
    else:
        pass


    count=0
    flag=1
    while True:
        ret = subprocess.getstatusoutput(nodestatuscmd)
        if ret[0] == 0:
            if ret[1] == '0':
                break
            else:
                if "ERROR" not in ret[1].upper():
                    time.sleep(5)
                    if flag:
                        retsql = subprocess.getstatusoutput(execsql)
                        write_logger(logfile).info("exec sql %s "%execsql)
                        write_logger(logfile).info("exec sql  result %s "%retsql[1])
                        flag=0
                else:
                    write_logger(logfile).error("exec cmd %s failed"%nodestatuscmd)
                    break
        else:
            break
        if count > timeout:
            write_logger(logfile).error("get unprimary room leaseholder failed")
            break
        count=count+1



#安装331集群
def instha():
    try:
        bc = BaseCls()
        bc.instha()
        ipport=bc.client_ip + ":" + bc.client_port
        if bc.instances:
            multithread.get_status(ipport,bc.instances)
            write_logger(logfile).info("check startup instance and will startup instances consistent")
    except Exception as e:
        write_logger(logfile).error("call method install cluster faielld errmsg: %s"%e)

def teardown(cmd=None):
    bc = BaseCls()
    bc.teardown(cmd)
def init_remote(localpath,remotepath):
    bc = BaseCls()
    bc.st.upload_scp(localpath,remotepath)

def get():
    bc = BaseCls()
    return bc.join

#获取所有机房的ip和端口信息
def get_engine_room():
    timeout=30
    count=0
    try:
        while True:
            try:
                infoall = test_args()
                break
            except Exception as e:
                count=count+1
                time.sleep(5)
            if count > timeout:
                break

        rid1info = infoall[0]
        infoprimary = [x for x in rid1info]

        #本机房的ip和端口信息
        rid2info = infoall[1]
        backlocal = [x for x in rid2info] 

        #异备机房的ip和端口信息
        rid3info = infoall[2]
        backremote = [x for x in rid3info]
        return [infoprimary,backlocal,backremote]
    except Exception as e:
        write_logger(logfile).error("Get primary back remote_back romm failed errmsg:%s"%e)
        return False
    finally:
        pass

"""1->0 步骤"""
#解除leaseholder限制
def set_local_normal():
    infoall = test_args()
    iplst = []
    for i in infoall:
        for j in i:
            iplst.append(j)
    for hs in iplst: 
        ip = hs.split(":")[0]
        serverport = hs.split(":")[1]
        cmd = "%s/%s primary-region set-local 0 --"%(bindir,binname) + securemod + " --host=%s:%s"%(ip,serverport)
        sshapp.cmd(cmd,ip)



#唤醒 all romm raft协议 rid=0  是去掉主机房 rid=1 ,rid=2 唤醒主机房的信息
def wake_allroom_raft(rid=0):
    try:
        i=0
        write_logger(logfile).info("wakeraft all server action start")
        ret = get_engine_room()
        for engroom in ret:
            for server in engroom:
                cmd = "%s/%s primary-region set-local "%(bindir,binname) +  str(rid) + "  wakeraft --"+securemod +" --host=%s"%server
                sshapp.cmd(cmd,server.split(":")[0])
            if i == 0:
                time.sleep(10)
            i=i+1
        write_logger(logfile).info("wakeraft all server action end")
        return True
    except Exception as e:
        write_logger(logfile).info("wakeraft all server action failed errmsg:%s"%e)
        return False
    finally:
        pass

# 1->0 method
def set_one2zero(rid=0):
    set_local_normal()
    wake_allroom_raft(rid)
    time.sleep(10)
"""1->0 步骤结束"""



"""0->2的步骤"""
#告诉所有的实例rid=1,rid=2,rid=3的为主机房
def set_all_primary(rid=1):
    try:
        ret = get_engine_room()
        for engroom in ret:
            for server in engroom:
                cmd = "%s/%s primary-region set-local "%(bindir,binname) + str(rid) + " --"+securemod+ " --host=%s"%(server)
                sshapp.cmd(cmd,server.split(":")[0])
    except Exception as e:
        pass
    finally:
        pass

#移除非主机房的Leader
def move_otherlease_room(rid=1):
    try:
        write_logger(logfile).info("movelease unprimary_root server message start")
        index = int(rid)-1
        rettmp = get_engine_room()
        rettmp.pop(index)
        ret = rettmp 
        for engroom in ret:
            for server in engroom:
                cmd = "%s/%s primary-region set-local "%(bindir,binname) +  str(rid) +"  movelease --" + securemod + " --host=%s"%(server)
                sshapp.cmd(cmd,server.split(":")[0])
        write_logger(logfile).info("movelease unprimary_room server message end")
        return True
    except Exception as e:
        write_logger(logfile).error("movelease unprimary_room server failed errmsg:%s"%e)
        return False
    finally:
        pass


# 0->2 method
def swith_one2two(rid=2,ipport=None):
    set_all_primary(rid)
    move_otherlease_room(rid)
    if ipport:
        get_wakeraft_unprimary(rid,ipport)
    else:
        get_wakeraft_unprimary(rid)
    wake_allroom_raft(rid)

"""0->2 结束"""


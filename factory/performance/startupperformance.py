import os
import sys
import time
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
    from factory import collect
    from factory import sshapp
    from factory.collect import write_logger
    from factory.testcase import Testcase
    from factory.performance.instperformance import Startup
    from factory.common import *
except Exception as e:
    sys.path.append(syspath)
    from factory.conf import *
    from factory import sshapp
    from factory import testcase
    from factory.collect import write_logger
    from factory.testcase import Testcase
    from factory.performance.instperformance import Startup
    from factory.common import *







"""获取基本信息"""
class BaseCls(Startup):

    def __init__(self):
        super().__init__()

    
    #install ha331 qianbasedb
    def instha(self,cmd=None):
        try:
            #执行安装
            self.run(self.hainfo)
            write_logger(logfile).info("ha cluster type %s install success"%self.hainfo)
        except Exception as e:
            write_logger(logfile).error("ha cluster type %s install failed errmsg:%s"%(self.hainfo,e))
            print("ha cluster type %s install failed errmsg:%s"%(self.hainfo,e))
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

#安装331集群
def instha():
    try:
        bc = BaseCls()
        bc.instha()
    except Exception as e:
        write_logger(logfile).error("call method install cluster faielld errmsg: %s"%e)

def teardown(cmd=None):
    bc = BaseCls()
    bc.teardown(cmd)
def init_remote(localpath,remotepath):
    bc = BaseCls()
    bc.st.upload_scp(localpath,remotepath)

#获取数据库的ip和端口信息
def get():
    bc = BaseCls()
    return bc.join

#获取所有机房的ip和端口信息
def get_engine_room():
    try:
        infoall = test_args()
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
def swith_one2two(rid=2):
    set_all_primary(rid)
    move_otherlease_room(rid)
    wake_allroom_raft(rid)

"""0->2 结束"""






##获取所有的实例的主机房信息返回rid
#def get_all_primary():
#    try:
#        ret = get_engine_room()
#        for engroom in ret:
#            for server in engroom:
#                cmd = "%s primary-region get-local --"+securemod+" --host=%s:%s"
#                sshapp.exec_cmd(cmd=cmd,host=server[0],serverport=server[1])
#        return True
#    except Exception as e:
#        write_logger(logfile).error("get primary room message failed errmsg :%s"%e)
#        return False
#
#    finally:
#        pass
#
#
##唤醒raft协议
#def wake_allback_raft(rid=2):
#    try:
#        write_logger(logfile).info("wakeraft all server action start")
#        ret = get_engine_room()[1:]
#        for engroom in ret:
#            for server in engroom:
#                cmd = "%s primary-region set-local " +  str(rid) + "  wakeraft --"+securemod +" --host=%s:%s"
#                sshapp.exec_cmd(cmd=cmd,host=server[0],serverport=server[1])
#        write_logger(logfile).info("wakeraft all server action end")
#        return True
#    except Exception as e:
#        write_logger(logfile).info("wakeraft all server action failed errmsg:%s"%e)
#        return False
#    finally:
#        pass
#
#
##解除leaseholder限制
#def del_all_leaseholder():
#    try:
#        ret = get_engine_room()
#        for engroom in ret:
#            for server in engroom:
#                cmd = "%s primary-region set-local 0 --"+ securemod +" --host=%s:%s"
#                sshapp.exec_cmd(cmd=cmd,host=server[0],serverport=server[1])
#        return True
#    except Exception as e:
#        write_logger(logfile).error("move leaseholder room message failed errmsg :%s"%e)
#        return False
#
#    finally:
#        pass
#
##唤醒主机房的raft协议
#def wakeraft_primary_room(index=0):
#    try:
#        ret = get_engine_room()[index]
#        for hs in ret:
#            cmd = "%s primary-region set-local 0 wakeraft  --"+securemod+" --host=%s:%s"
#            sshapp.exec_cmd(cmd=cmd,host=hs[0],serverport=hs[1])
#        return True
#    except Exception as e:
#        write_logger(logfile).error("wakeraft primary room raft protocal errmsg:%s!!!"%e)
#        return False
#    finally:
#        pass
#
#
##唤醒非主机房的raft协议
#def wakeraft_back_room(index=1):
#    try:
#        idx = int(index) - 1
#        rettmp = get_engine_room()
#        rettmp.pop(idx)
#        ret = rettmp
#        #ret = get_engine_room()[index:]
#        for hs in ret:
#            for subhs in hs:
#                cmd = "%s primary-region set-local 0 wakeraft  --"+securemod + " --host=%s:%s"
#                sshapp.exec_cmd(cmd=cmd,host=subhs[0],serverport=subhs[1])
#        return True
#    except Exception as e:
#        write_logger(logfile).error("wakeraft primary room raft protocal!!!")
#        return False
#    finally:
#        pass


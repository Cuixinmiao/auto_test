import os
import re
import sys
import time
import pytest
import configparser

scriptpath = os.path.split(__file__)[0]
sys.path.append(scriptpath)
typeinfo = os.environ.get("typeinfo")
if typeinfo == None:
    if "331" in __file__:
        os.environ["typeinfo"] = "ha331"

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
    from factory import testcase
    from factory.testcase import Testcase
    from factory import util,run_sql
    from factory import sshapp
    from factory import common
    from factory.collect import *
    from factory.util_ha import startup331 as startup_ha 
    from factory.util_ha import inst331 as inst 
    from factory.util_ha.inst331 import Startup
except Exception as e:
    sys.path.append(syspath)
    from factory import testcase
    from factory.testcase import Testcase
    from factory import util,run_sql
    from factory import sshapp
    from factory import common
    from factory.collect import *
    from factory.util_ha import startup331 as startup_ha 
    from factory.util_ha import inst331 as inst
    from factory.util_ha.inst331 import Startup


"""set ckpt sql relational variables"""
basepath = os.getcwd()
sqlpath = os.path.join(basepath,"initsql")
sqlsetckpt = "setckpt.sql"
sqlfilepath = os.path.join(sqlpath,sqlsetckpt)
init_ip = Startup().init_ip
init_port = Startup().init_port
client_ip = Startup().client_ip
client_port = Startup().client_port



"""primary room switch init 1 to init 0 的状态"""
def room_switch_init():
        startup_ha.del_all_leaseholder()
        startup_ha.wakeraft_primary_room(index=0)
        #缺少检测主机房raft wake的机制，先暂定停30s
        time.sleep(30)
        startup_ha.wakeraft_back_room(index=1)


    
"""init 0 到状态 rid = 1"""
def set_primary_room(rid=1):
        startup_ha.set_all_primary(rid=rid)
        startup_ha.move_otherlease_room(rid=rid)
        #缺少检测机制,先暂定30s
        time.sleep(30)
        startup_ha.wake_allroom_raft(rid=rid)


"""set cluster setting ckpt"""
def set_ckpt(host,port,sqlname):
    try:
        common.exec_sql_file(host,port,sqlname)
        write_logger(logfile).info("exec set custer setting ckpt success ")
        return True
    except Exception as e:
        write_logger(logfile).error("exec set cluster setting ckpt failed errmsg %s"%e)
        return None

"""exec tpcc work load data"""
def exec_tpcc(host,serverport,amount,timeout=300):
    try:
        common.exec_tpcc_workload(host,serverport,amount,timeout)
        write_logger(logfile).info("exec tpcc workload end")
        return True
    except Exception as e:
        write_logger(logfile).error("exec tpcc workload failed errmsg :%s"%e)
        return None









"""exec func module's class !!!!!"""
class Qianbasetestfunc():
    def single_delay_fault_localback_qianbase(self):
        # install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        # set cluster setting checkpoint time 
        set_ckpt(init_ip,init_port,sqlfilepath)

        # exec tpcc workload data
        exec_tpcc(init_ip,init_port,10,100)
       
        #exec tpcc work business
        p = common.exec_tpcc_business(client_ip, client_port, 10, 10, 3)


        #get rid=3 room info
        rid2info = common.test_args()[1]
        ipuuid=[]
        ipport = list(rid2info.keys())[0]
        ip = ipport.split(":")[0]
        ret = common.setting_delay(ip,"500")
        ipuuid.append(ret)

        res = common.monitor_tpcc_res(p)
        if res == True:
            for ip_uuid in ipuuid:
                ip = ip_uuid[0]
                uuid = ip_uuid[1]
                common.destroy_delay(ip,uuid)
            assert res == True
        else:
            for ip_uuid in ipuuid:
                ip = ip_uuid[0]
                uuid = ip_uuid[1]
                common.destroy_delay(ip,uuid)
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        





if __name__ == '__main__':
    #exec tpcc work business
    try:
        p = common.exec_tpcc_business(client_ip, client_port, 10, 10, 2)


        #get rid=3 room info
        rid3info = common.test_args()[2]
        rid3single = list(rid3info.keys())[0]
        ipport = rid3single
        ip = ipport.split(":")[0]
        port = ipport.split(":")[1]
        common.stop(ip,port)
        res = common.monitor_tpcc_res(p)
        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]

    except Exception as e:
        print(e)
    


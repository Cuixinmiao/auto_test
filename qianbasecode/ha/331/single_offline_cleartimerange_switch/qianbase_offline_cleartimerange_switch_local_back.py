import os
import re
import sys
import time
import pytest
import configparser
import random

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
    def cluster_fault_switch_localback_qianbase(self):
        # install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        # set cluster setting checkpoint time 
        set_ckpt(init_ip,init_port,sqlfilepath)

        # exec tpcc workload data
        p = common.exec_tpcc_load(client_ip,client_port,500,500)
       
        #timeout =300
        rid1info = common.test_args()[0]
        rid2info = common.test_args()[1]
        rid3info = common.test_args()[2]
        rid1info.update(rid3info)
        rid2key = list(rid2info.keys())
        singleip = rid2key[0]
        otherip = rid2key[1:]
        timeout=300
        retrytimes=1
        starttime=int(time.time())
        while True:
            if retrytimes > timeout:
                p.kill()
                write_logger(logfile).error("exec tpcc workload data failed timeout %s s"%timeout)
                res = p.communicate()[1]
                write_logger(logfile).error("exec tpcc workload data errmsg %s"%res)
                break
            if p.poll() == 0:
                write_logger(logfile).debug("exec tpcc workload data success")
                ret = p.communicate()[1].split("\n")
                for line in ret:
                    write_logger(logfile).info("exec tpcc workload res %s"%line)
                break
            if int(time.time()) - starttime == 40:
                    singleipport=singleip
                    write_logger(logfile).info("singleipport:%s"%singleipport)
                    ip = singleipport.split(":")[0]
                    port = singleipport.split(":")[1]
                    common.stop(ip,port)
            if int(time.time()) - starttime == 140:
                for key in otherip:
                    oipport=key
                    write_logger(logfile).info("ipport:%s"%oipport)
                    oip = oipport.split(":")[0]
                    oport = oipport.split(":")[1]
                    common.stop(oip,oport)
            time.sleep(1)
            retrytimes = retrytimes + 1
            #line = str(p.stdout.readline(),encoding='utf-8')
            #if line:
            #    write_logger(logfile).info("exec tpcc workload data %s"%line)
        write_logger(logfile).info("exec tpcc workload data end")

        #get rid=2 room fault info
        write_logger(logfile).info(rid1info)
        for key in list(rid1info.keys()):
            ipport=key
            write_logger(logfile).info("ipport:%s"%ipport)
            ip = ipport.split(":")[0]
            port = ipport.split(":")[1]
            common.stop(ip,port)

        #res = common.monitor_tpcc_res(p)
        #if res == True:
        #    assert res == True
        #else:
        #    assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]


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
    


import os
import sys
import time
import pytest
import configparser

scriptpath = os.path.split(__file__)[0]
sys.path.append(scriptpath)
typeinfo = os.environ.get("typeinfo")
if typeinfo == None:
    if "performance" in __file__:
        os.environ["typeinfo"] = "performance"
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
    from factory.performance import startupperformance as startup_ha 
    from factory.performance import instperformance as inst 
    from factory.performance.instperformance import Startup
except Exception as e:
    sys.path.append(syspath)
    from factory import testcase
    from factory.testcase import Testcase
    from factory import util,run_sql
    from factory import sshapp
    from factory import common
    from factory.collect import *
    from factory.performance import startupperformance as startup_ha 
    from factory.performance import instperformance as inst
    from factory.performance.instperformance import Startup


"""set ckpt sql relational variables"""
basepath = os.getcwd()
sqlpath = os.path.join(basepath,"initsql")
sqlsetckpt = "setckpt.sql"
sqlfilepath = os.path.join(sqlpath,sqlsetckpt)
init_ip = Startup().init_ip
init_port = Startup().init_port

"""exec func module's class !!!!!"""
class Qianbasetestfunc():
    def func_qianbase(self):
        print("安装数据库")


"""network partiton"""
def net_partion():
        iplst = list(set(Startup().advertiseaddr))
        back=",".join(iplst[3:])
        primary=",".join(iplst[:3])
        print("back+"+back)
        print("primary+"+primary)
        i=1
        for ip in iplst:
            if i <= 3: 
                if ip.split(".")[-1] == "54":
                    sshapp.cmd("blade create network loss --percent 100 --interface enp125s0f0 --destination-ip %s --timeout 600"%back,ip)
                    print("blade create network loss --percent 100 --interface enp125s0f0 --destination-ip %s --timeout 300"%back,ip)
                else:
                    sshapp.cmd("blade create network loss --percent 100 --interface enp3s0 --destination-ip %s --timeout 600"%back,ip)
                    print("blade create network loss --percent 100 --interface enp3s0 --destination-ip %s --timeout 600"%back,ip)
            else:
                sshapp.cmd("blade create network loss --percent 100 --interface enp125s0f0 --destination-ip %s --timeout 600"%primary,ip)
                print("blade create network loss --percent 100 --interface enp125s0f0 --destination-ip %s --timeout 300"%primary,ip)
            i=i+1
            

"""network partiton"""
def net_partion_src():
        iplst = list(set(Startup().advertiseaddr))
        back=",".join(iplst[2:])
        primary=",".join(iplst[:2])
        print("back+"+back)
        print("primary+"+primary)
        i=1
        for ip in iplst:
            if ip.split(".")[-1] == "54":
                sshapp.cmd("blade create network loss --percent 100 --interface enp125s0f0 --destination-ip %s --timeout 100"%primary,ip)
                print("blade create network loss --percent 100 --interface enp125s0f0 --destination-ip %s --timeout 100"%primary,ip)
            else:
                sshapp.cmd("blade create network loss --percent 100 --interface enp3s0 --destination-ip %s --timeout 100"%back,ip)
                print("blade create network loss --percent 100 --interface enp3s0 --destination-ip %s --timeout 100"%back,ip)



"""kill primary room process"""
def server_pri_kill():
    iplst = list(set(Startup().advertiseaddr))[0]
    killcmd="ps -fe|grep -v grep|grep qianbase|awk '{print $2}'|while read line;do kill -9 $line; done"
    for ip in iplst:
        sshapp.cmd(killcmd,ip)


"""kill back room process"""
def server_back_kill():
    iplst = Startup().advertiseaddr[3:6]
    killcmd="ps -fe|grep -v grep|grep qianbase|awk '{print $2}'|while read line;do kill -9 $line; done"
    for ip in iplst:
        sshapp.cmd(killcmd,ip)



"""kill remote back room process"""
def server_remote_kill():
    iplst = Startup().advertiseaddr[6:]
    killcmd="ps -fe|grep -v grep|grep qianbase|awk '{print $2}'|while read line;do kill -9 $line; done"
    for ip in iplst:
        sshapp.cmd(killcmd,ip)
        

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

if __name__ == '__main__':
    if len(sys.argv) == 3:
        localpath=sys.argv[1]
        remotepath=sys.argv[2]
        startup_ha.init_remote(localpath,remotepath)
    elif len(sys.argv) == 2:
        if sys.argv[1] == "start":
            Startup().start_run()
        elif sys.argv[1] == "stop":
            Startup().stop_run()
            inst.teardown("echo 3 >/proc/sys/vm/drop_caches")
        else:
            pass
    else:
        # install qianbase ,set replicas 7 and register license
        Startup().teardown()
        Startup().pre_env()
        startup_ha.instha()
        #set cluster setting checkpoint time 
        #set_ckpt(init_ip,init_port,sqlfilepath)
        #exec tpcc workload data
        #exec_tpcc(init_ip,init_port,100,1000)
        # kill primary room
        #server_pri_kill()
        #kill back room
        #server_back_kill()
        # kill remote room
        #server_remote_kill()

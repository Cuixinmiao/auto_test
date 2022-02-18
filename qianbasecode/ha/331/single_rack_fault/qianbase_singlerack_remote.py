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
    def single_rack_fault_remote_qianbase(self):
        # install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        # set cluster setting checkpoint time 
        set_ckpt(init_ip,init_port,sqlfilepath)

        # exec tpcc workload data
        exec_tpcc(init_ip,init_port,10,100)
       
        #exec tpcc work business
        p = common.exec_tpcc_business(client_ip, client_port, 10, 10, 3)


        #get rid=3 room info
        #rack=random.randint(1,3) 
        rack="rack=1"
        rid3info = common.test_args()[2]
        for key in list(rid3info.keys()):
            ipport=key
            tmprack=rid3info[key][0][1]
            if rack == tmprack:
                ip = ipport.split(":")[0]
                port = ipport.split(":")[1]
                common.stop(ip,port)

        res = common.monitor_tpcc_res(p)
        if res == True:
            assert res == True
        else:
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
        #sum1=0
        #step=12
        #start=1
        #j=0
        #delayduration=0
        #res=""
        #while True:
        #    if p.poll() == 0:
        #        stdout,stderr = p.communicate()
        #        #assert "error" not in  str(stderr,encoding='utf-8').lower() == True and "sqlstat" not in  str(stderr,encoding='utf-8').lower() == True,"errmsg :%s"%str(stderr,encoding='utf-8')
        #        for m in stderr:
        #            print(m)
        #        break
        #    if p.poll() is None:
        #        line = str(p.stdout.readline(),encoding='utf-8').strip()
        #        print(line)
        #        if re.match("^([1-9][0-9]*)+(.0)",line):
        #            lstcount = line.split()
        #            timecount = int(lstcount[0].split(".")[0])
        #            if delayduration >=3:
        #                p.kill()
        #                stdout,stderr = p.communicate()
        #                assert delayduration == 0,"delayduration great than 24s \n errmsg:%s"%str(stderr,encoding='utf-8')
        #                break
        #            if timecount == start:
        #                sum1 = sum1 + int(lstcount[2].split(".")[0])
        #                j=j+1
        #                if j == 5:
        #                    if sum1 == 0:
        #                        delayduration = delayduration + 1
        #            elif timecount - start == step:
        #                sum1 = sum1 + int(lstcount[2].split(".")[0])
        #                j=j+1
        #                if j == 5:
        #                    start = timecount
        #                    if sum1 == 0:
        #                        delayduration = delayduration + 1
        #            else:
        #                j=0
        #                sum1=0
            #lineerr = str(p.stderr.readline(),encoding='utf-8').strip()
            #print(lineerr)
            #if  lineerr:
            #    print("line errmsg :"+ lineerr)
            #    p.kill()
            #    break

    except Exception as e:
        print(e)
    


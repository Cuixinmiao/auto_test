import os
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

# get ckpt job gateway node sql
ckptinfosql = "select coordinator_id,status,error from dbms_internal.jobs where job_type = 'CHECKPOINT'"
#get jobs node ip address
getckptip = "select address from dbms_internal.kv_node_status where node_id = %s"

def kill_ckptgateway():
    #try:
    conn = common.get_conn()
    if not conn:
        with pytest.raises(SystemExit):
            assert conn !=None,"get connect db failed"
    cur = conn.cursor()
    cur.execute(ckptinfosql)
    ret = cur.fetchone()
    coordinator_id = ret[0]
    status = ret[1]
    errorinfo = ret[2]
    if not status == "running":
        write_logger(logfile).error("coordinator_id is %s ckpt status is %s,errmsg:%s"%(coordinator_id,status,errorinfo))
        assert status == "running"
    getckptipsql = getckptip%(str(coordinator_id))
    cur.execute(getckptipsql)
    ret2 = cur.fetchone()
    ip = ret2[0].split(":")[0]
    port = ret2[0].split(":")[1]
    write_logger(logfile).info("stop gateway %s ckpt job start"%ip)
    common.stop(ip,port)
    write_logger(logfile).info("stop gateway %s ckpt job end"%ip)
    conn.close()
    cur.close()


    common.ckpt_job_switch(coordinator_id)
    m = 0;
    while True:
        conn1 = common.get_conn()
        if not conn1:
            with pytest.raises(SystemExit):
                assert conn1 !=None,"get connect db failed"
        cur1 = conn1.cursor()
        cur1.execute(ckptinfosql)
        ret3 = cur1.fetchone()
        ret3id = ret3[0]
        ret3status = ret3[1]
        ret3error = ret3[2]
        #print(ret3,ret3id,ret3status,m)
        if ret3error:
            assert ("running",'') == (ret3status,ret3error)
            break
        else:
            time.sleep(1)
        if m > 300:
            assert ("running",'') == (ret3status,ret3error)
            break
        m=m+1

    #except Exception as e:
    #    write_logger(logfile).error(e)
    #    with pytest.raises(SystemExit):
    #        common.gen_raise()
    #finally:
    #    if conn:
    #        conn.close()
    #        cur.close()
    







"""exec func module's class !!!!!"""
class Qianbasetestfunc():
    def ckpt_job_switch_withdata_qianbase(self):
        # install qianbase ,set replicas 7 and register license
        startup_ha.instha()
        # set cluster setting checkpoint time 
        set_ckpt(init_ip,init_port,sqlfilepath)
        # exec tpcc workload data
        exec_tpcc(init_ip,init_port,10,100)
        # exec rid=1 to rid=0 switch
        startup_ha.set_one2zero(rid=0)

        #switch success time.sleep(20)
        time.sleep(10)

        #exec rid=0 to rid=2 switch
        startup_ha.swith_one2two(rid=2)
        #ckpt switch job operation
        kill_ckptgateway()


if __name__ == '__main__':
    pass

import os
import re
import sys
import time
import pytest
import configparser
import pysnooper

scriptpath = os.path.split(__file__)[0]
sys.path.append(scriptpath)
typeinfo = os.environ.get("typeinfo")
print(typeinfo)
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
    from factory import rmt
    from factory import multithread 
    from factory.multithread import *
    from factory.collect import *
    from factory.util_ha import startup331 as startup_ha 
    from factory.util_ha.startup331 import BaseCls
    from factory.util_ha import inst331 as inst 
    from factory.util_ha.inst331 import Startup
except Exception as e:
    sys.path.append(syspath)
    from factory import testcase
    from factory.testcase import Testcase
    from factory import util,run_sql
    from factory import sshapp
    from factory import common
    from factory import rmt
    from factory import multithread 
    from factory.multithread import *
    from factory.collect import *
    from factory.util_ha import startup331 as startup_ha 
    from factory.util_ha.startup331 import BaseCls
    from factory.util_ha import inst331 as inst
    from factory.util_ha.inst331 import Startup


"""set ckpt sql relational variables"""
obj331 = BaseCls()





"""exec func module's class !!!!!  singnode fault operation kill method kill -9"""
class Qianbasetest_applylayout():
    def setup_class(self):
        obj331.teardown()
        obj331.pre_env()

    def teardown_class(self):
        #obj331.teardown()
        pass

    #@pysnooper.snoop("/home/cxm/qianbase-xtp-test/snoop.log")
    def primaryroom_offline_recovery__qianbase(self):

        # rid = 1 primary recovery new cluster
        rid = 1
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()
        time.sleep(10)
        ##get all room info
        info = common.test_args()
        #get init time primary room info
        rid1info = info[0]
        rid2info = info[1].copy()
        rid3info = info[2].copy()
        rid2info.update(rid3info)

        ##----
        ipport = list(rid1info.keys())[0]

        restat = multithread.get_status(ipport)
        if restat != []:
            #write_logger(logfile).error("node down info %s"%str(restat))
            assert restat == [],"check node info failed"



        # exec tpcc workload data
        obj331.exec_tpcc()
        # gen server certs
        backip = obj331.backip
        for ipnumregion in backip:
            addr = ipnumregion.split("@")[0]
            sshapp.cmd("pkill -9 %s"%obj331._binname,addr)
            sshapp.upload(obj331.execbin,obj331.binname,addr)
            common.gen_server(addr)

        time.sleep(10)


        

        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],"%s_%s"%(m_name,"test_k"))
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]

        #获取某个时间段的最小的ckpt
        tsinfo = multithread.exec_last_checkpoint(rid1info)
        if tsinfo != None:
            mints = tsinfo[0]
            #tuple 1 : ip 2 : store 3: desc_nodeid.lst 4:node_id 5:ipport
            storelist = tsinfo[1]
        else:
            write_logger(logfile).error("get offline recovery before ckpt ts fault")
            assert 1 == 0,"get offline recovery before kpt ts fault"
        
        #check cluster status
        restat = multithread.get_status(ipport)
        if restat != []:
            #write_logger(logfile).error("node down info %s"%str(restat))
            assert restat == [],"check node info "

        #check cluster ckpt status
        ckptret = common.check_ckpt(ipport)
        if ckptret == None:
            write_logger(logfile).error("get ckpt status failed")
        #ckptret != None,"get ckpt status failed"

        args = obj331.args
        #prefix = list(rid1info.keys())[0]
        #preip = prefix.split(":")[0]
        #for key in rid1info.keys():
        #    if key.startswith(prefix):
        #        args.append((rid1info[key][1],rid1info[key][3]))

        write_logger(logfile).info("%s"%str(args))
        for arg in args:
            ip = arg[0]
            datadir = arg[1]
            cmd = arg[2]
            rmt.exec_cmd("rm -fr %s"%datadir,ip)
            rmt.exec_cmd(cmd,ip)
            write_logger(logfile).info("capacity expansion ip:%s cmd:%s success"%(ip,cmd))

        write_logger(logfile).info("capacity expansion success")
        checkrep = common.check_replicas()
        if checkrep == None:
            assert 1 == 0,"capacity expansion after replicas failed"
        write_logger(logfile).info("check capacity expansion info start")
        timeout=50
        to = 1
        while True:
            tmprid1=common.test_args()
            tmprid1info = tmprid1[0]
            if to > timeout:
                write_logger(logfile).info("check capacity expansion info %sth 5s "%str(to))
                break
            elif len(tmprid1info) == len(rid1info) + len(args):
                write_logger(logfile).info("check capacity expansion  info success")
                break
            write_logger(logfile).info("check capacity expansion info before instances "%str(len(rid1info)))
            write_logger(logfile).info("check capacity expansion info before instances "%str(len(tmprid1info)))
            time.sleep(5)
            to = to + 1
        write_logger(logfile).info("check capacity expansion info end!!")


        # check record instance timestamp
        check_record_ts(tmprid1[0])



        time.sleep(10)

        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],"%s_test_k_2"%m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]

        allrid = common.test_args()
        ridone = allrid[0].copy()
        ridtwo = allrid[1].copy()
        ridthree = allrid[2].copy()
        ridone.update(ridtwo)
        ridone.update(ridthree)
        write_logger(logfile).info("%s"%str(ridone))

        #stop cmd
        stopthreads = []
        for key,value in ridone.items():
            ip = key.split(":")[0]
            port = key.split(":")[1]
            stopthreads.append(Teststop(ip,port))
        
        for stopthread in stopthreads:
            stopthread.start()

        for stopthread in stopthreads:
            stopthread.join()

        time.sleep(10)

        st = exec_apply_layout(rid1info,1,check=("spec",mints,storelist))
        if st == None:
            write_logger(logfile).error("apply-layout failed detail description please chech regression.log!!")
            sys.exit()

        #staortup cmd
        startthreads = []
        for key,value in rid1info.items():
            ip = key.split(":")[0]
            cmd = value[1]
            startthreads.append(Test(cmd,ip,rmt.exec_cmd))
            
        for startthread in startthreads:
            startthread.start()

        for startthread in startthreads:
            startthread.join()

        time.sleep(30)

        ##get primary room recovery decommission node
        #rridinfo = common.test_args()
        #bridinfo = rridinfo[1].copy()
        #bridinfo.update(rridinfo[2])

        nodeidlst = ""
        for key,value in rid2info.items():
            nodeidlst = nodeidlst +str(value[2])+" "
        common.decommission_node(ipport,nodeidlst)
        exec_replicas_sql(ipport,rid)
        checkrep = common.check_replicas(obj331.prep,ipport)
        if checkrep == None:
            assert 1 == 0,"recovery success but check recovery replicas failed"

        
        ##check cluster status
        #restat = multithread.get_status(ipport)
        #if restat != []:
        #    #write_logger(logfile).error("node down info %s"%str(restat))
        #    assert restat == [],"check node info "

        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]
        
        #restat = multithread.get_status(ipport)
        ##write_logger(logfile).error("node down info %s"%str(restat))
        #assert restat == [],"check node info "
        ckptret = common.check_ckpt(ipport)
        if ckptret == None:
            write_logger(logfile).error("get ckpt status failed")
        ckptret != None,"get ckpt status failed"

    #@pysnooper.snoop("/home/cxm/qianbase-xtp-test/snoop_add.log")
    #@pytest.mark.skip("add instance before ckpt timestamp after spec timestamp recovery")
    def primaryroom_offline_recovery_add_qianbase(self):

        # rid = 1 primary recovery new cluster
        rid = 1
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()
        time.sleep(30)
        ##get all room info
        info = common.test_args()
        #get init time primary room info
        rid1info = info[0]
        rid2info = info[1].copy()
        rid3info = info[2].copy()
        rid2info.update(rid3info)

        ## ----
        ipport = list(rid1info.keys())[0]
        restat = multithread.get_status(ipport)
        if restat != []:
            #write_logger(logfile).error("node down info %s"%str(restat))
            assert restat == [],"check node info failed"



        # exec tpcc workload data
        obj331.exec_tpcc()
        # gen server certs
        backip = obj331.backip
        for ipnumregion in backip:
            addr = ipnumregion.split("@")[0]
            sshapp.cmd("pkill -9 %s"%obj331._binname,addr)
            sshapp.upload(obj331.execbin,obj331.binname,addr)
            common.gen_server(addr)

        time.sleep(30)
        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],"%s_%s"%(m_name,"test_k"))
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]

        #获取某个时间段的最小的ckpt
        tsinfo = multithread.exec_last_checkpoint(rid1info)
        if tsinfo != None:
            mints = tsinfo[0]
            #tuple 1 : ip 2 : store 3: desc_nodeid.lst 4:node_id 5:ipport
            storelist = tsinfo[1]
        else:
            write_logger(logfile).error("get offline recovery before ckpt ts fault")
            assert 1 == 0,"get offline recovery before kpt ts fault"
        
        #check cluster status
        restat = multithread.get_status(ipport)
        if restat != []:
            #write_logger(logfile).error("node down info %s"%str(restat))
            assert restat == [],"check node info "

        #check cluster status
        ckptret = common.check_ckpt(ipport)
        if ckptret == None:
            write_logger(logfile).error("get ckpt status failed")
        #ckptret != None,"get ckpt status failed"

        args = obj331.args
        #prefix = list(rid1info.keys())[0]
        #preip = prefix.split(":")[0]
        #for key in rid1info.keys():
        #    if key.startswith(prefix):
        #        args.append((rid1info[key][1],rid1info[key][3]))

        write_logger(logfile).info("%s"%str(args))
        for arg in args:
            ip = arg[0]
            datadir = arg[1]
            cmd = arg[2]
            rmt.exec_cmd("rm -fr %s"%datadir,ip)
            rmt.exec_cmd(cmd,ip)
            write_logger(logfile).info("kuo rong ip:%s cmd:%s success"%(ip,cmd))

        write_logger(logfile).info("kuo rong success")
        checkrep = common.check_replicas()
        if checkrep == None:
            assert 1 == 0,"kuo rong after replicas failed"
        write_logger(logfile).info("check kup rong info start")
        timeout=50
        to = 1
        while True:
            tmprid1=common.test_args()
            tmprid1info = tmprid1[0]
            if to > timeout:
                write_logger(logfile).info("check kup rong info %sth 5s "%str(to))
                break
            elif len(tmprid1info) == len(rid1info) + len(args):
                write_logger(logfile).info("check kup rong info success")
                break
            write_logger(logfile).info("check kup rong info before instances "%str(len(rid1info)))
            write_logger(logfile).info("check kup rong info before instances "%str(len(tmprid1info)))
            time.sleep(5)
            to = to + 1
        write_logger(logfile).info("check kup rong info end!!")


        # check record instance timestamp
        check_record_ts(tmprid1[0])



        time.sleep(10)

        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],"%s_test_k_2"%m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]

        allrid = common.test_args()
        ridone = allrid[0].copy()
        ridtwo = allrid[1].copy()
        ridthree = allrid[2].copy()
        ridone.update(ridtwo)
        ridone.update(ridthree)
        write_logger(logfile).info("%s"%str(ridone))

        #stop cmd
        stopthreads = []
        for key,value in ridone.items():
            ip = key.split(":")[0]
            port = key.split(":")[1]
            stopthreads.append(Teststop(ip,port))
        
        for stopthread in stopthreads:
            stopthread.start()

        for stopthread in stopthreads:
            stopthread.join()

        time.sleep(10)

        st = exec_apply_layout(allrid[0],1,check=("spec",mints,storelist))
        if st == None:
            write_logger(logfile).error("apply-layout failed detail description please chech regression.log!!")
            sys.exit()

        #staortup cmd
        startthreads = []
        for key,value in allrid[0].items():
            ip = key.split(":")[0]
            cmd = value[1]
            startthreads.append(Test(cmd,ip,rmt.exec_cmd))
            
        for startthread in startthreads:
            startthread.start()

        for startthread in startthreads:
            startthread.join()

        time.sleep(120)

        ##get primary room recovery decommission node
        rridinfo = common.test_args()
        bridinfo = rridinfo[1].copy()
        bridinfo.update(rridinfo[2])

        nodeidlst = ""
        for key,value in bridinfo.items():
            nodeidlst = nodeidlst +str(value[2])+" "
        common.decommission_node(ipport,nodeidlst)
        exec_replicas_sql(ipport,rid)
        checkrep = common.check_replicas(obj331.prep,ipport)
        if checkrep == None:
            assert 1 == 0,"recovery success but check recovery replicas failed"

        
        ##check cluster status
        #restat = multithread.get_status(ipport)
        #if restat != []:
        #    #write_logger(logfile).error("node down info %s"%str(restat))
        #    assert restat == [],"check node info "

        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]
        
        #restat = multithread.get_status(ipport)
        ##write_logger(logfile).error("node down info %s"%str(restat))
        #assert restat == [],"check node info "
        ckptret = common.check_ckpt(ipport)
        if ckptret == None:
            write_logger(logfile).error("get ckpt status failed")
        ckptret != None,"get ckpt status failed"

if __name__ == '__main__':
   pass 


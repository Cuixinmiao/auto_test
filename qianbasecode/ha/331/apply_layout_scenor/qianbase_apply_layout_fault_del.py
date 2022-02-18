import os
import re
import sys
import time
import pytest
import configparser

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
    from factory.collect import *
    from factory.util_ha import startup331 as startup_ha 
    from factory.util_ha.startup331 import BaseCls
    from factory.util_ha import inst331 as inst
    from factory.util_ha.inst331 import Startup


"""set ckpt sql relational variables"""
obj331 = BaseCls()





"""exec func module's class !!!!!  singnode fault operation kill method kill -9"""
class Qianbasetest_fault_applylayout_fault_del():
    def setup_class(self):
        obj331.teardown()
        obj331.pre_env()

    def teardown_class(self):
        #obj331.teardown()
        pass

    def backroom_offline_recovery_fault_del_qianbase(self):

        # rid = 2 local backroom recovery cluster
        rid = 2
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()


        ##get all room info
        info = common.test_args()

        # exec tpcc workload data
        obj331.exec_tpcc()

        time.sleep(30)
        caseinfo = None
        delinfo = None
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)

        #exec switch room op
        ret = multithread.multi_thread_2(info,rid,fault=1,fn=fn)
        if ret[0] == None:
            assert 1 == 0 ,"apply layout failed"
        elif ret[0] == "1":
            assert 1 == 0,"delay greater than 24s,errmsg:%s"%str(ret[1])
        elif ret[0] == "repck_rc":
            assert 1 == 0,"recovery cluster check replicas failed"
        elif ret[0] == True:
            caseinfo = ret[1]
            delinfo = ret[2]
        else:
            assert 1 == 0,"exec other method failed "

       
        ipport = list(caseinfo.keys())[0]
        multithread.startup_cmd(delinfo)
        time.sleep(10)
        multithread.exec_replicas_sql(ipport,9)
        obj331.check_replicas()


        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        fn=os.path.join(os.path.split(__file__)[0],"%s_%s"%(m_name,str(rid)))
        allinfo = common.test_args()
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        restat = multithread.get_status(ipport)
        if restat != []:
            #write_logger(logfile).error("node down info %s"%str(restat))
            assert restat == [],"check node info "
        #check cluster ckpt status
        ckptret = common.check_ckpt(ipport)
        if ckptret == None:
            write_logger(logfile).error("get ckpt status failed")



    def primaryroom_offline_recovery_fault_qianbase(self):

        # rid = 1 primary recovery new cluster
        rid = 1
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()


        ##get all room info
        info = common.test_args()

        # exec tpcc workload data
        obj331.exec_tpcc()

        time.sleep(30)
        caseinfo = None
        delinfo = None
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)

        #exec switch room op
        ret = multithread.multi_thread_2(info,rid,fault=1,fn=fn)
        if ret[0] == None:
            assert 1 == 0 ,"apply layout failed"
        elif ret[0] == "1":
            assert 1 == 0,"delay greater than 24s,errmsg:%s"%str(ret[1])
        elif ret[0] == "repck_rc":
            assert 1 == 0,"recovery cluster check replicas failed"
        elif ret[0] == True:
            caseinfo = ret[1]
            delinfo = ret[2]
        else:
            assert 1 == 0,"exec other method failed "

       
        ipport = list(caseinfo.keys())[0]
        multithread.startup_cmd(delinfo)
        time.sleep(10)
        multithread.exec_replicas_sql(ipport,9)
        obj331.check_replicas()


        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        fn=os.path.join(os.path.split(__file__)[0],"%s_%s"%(m_name,str(rid)))
        allinfo = common.test_args()
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        restat = multithread.get_status(ipport)
        if restat != []:
            #write_logger(logfile).error("node down info %s"%str(restat))
            assert restat == [],"check node info "
        #check cluster ckpt status
        ckptret = common.check_ckpt(ipport)
        if ckptret == None:
            write_logger(logfile).error("get ckpt status failed")

    def allbackroom_offline_recovery_fault_qianbase(self):

        #rid = 4 allbackroom to do recovery
        rid = 4
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()


        ##get all room info
        info = common.test_args()

        # exec tpcc workload data
        obj331.exec_tpcc()

        time.sleep(30)
        caseinfo = None
        delinfo = None
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)

        #exec switch room op
        ret = multithread.multi_thread_2(info,rid,fault=1,fn=fn)
        if ret[0] == None:
            assert 1 == 0 ,"apply layout failed"
        elif ret[0] == "1":
            assert 1 == 0,"delay greater than 24s,errmsg:%s"%str(ret[1])
        elif ret[0] == "repck_rc":
            assert 1 == 0,"recovery cluster check replicas failed"
        elif ret[0] == True:
            caseinfo = ret[1]
            delinfo = ret[2]
        else:
            assert 1 == 0,"exec other method failed "

       
        ipport = list(caseinfo.keys())[0]
        multithread.startup_cmd(delinfo)
        time.sleep(10)
        multithread.exec_replicas_sql(ipport,9)
        obj331.check_replicas()


        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        fn=os.path.join(os.path.split(__file__)[0],"%s_%s"%(m_name,str(rid)))
        allinfo = common.test_args()
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        restat = multithread.get_status(ipport)
        if restat != []:
            #write_logger(logfile).error("node down info %s"%str(restat))
            assert restat == [],"check node info "

        #check cluster ckpt status
        ckptret = common.check_ckpt(ipport)
        if ckptret == None:
            write_logger(logfile).error("get ckpt status failed")

if __name__ == '__main__':
   pass 


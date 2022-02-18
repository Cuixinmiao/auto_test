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
    from factory.collect import *
    from factory.util_ha import startup331 as startup_ha 
    from factory.util_ha.startup331 import BaseCls
    from factory.util_ha import inst331 as inst
    from factory.util_ha.inst331 import Startup


"""set ckpt sql relational variables"""
obj331 = BaseCls()
ft="killall -9"




"""exec func module's class !!!!!  singnode fault operation kill method kill -9"""
class Qianbasetestfunc():
    def setup_class(self):
        obj331.teardown()
        obj331.pre_env()

    def teardown_class(self):
        obj331.teardown()

    def single_node_fault_killall_remote_qianbase(self):
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()


        ##get rid=3 room info
        rid3info = common.test_args()[2]
        rid3single = list(rid3info.keys())[0]

        # exec tpcc workload data
        obj331.exec_tpcc()
       
        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)


        ipport = rid3single
        ip = ipport.split(":")[0]
        port = ipport.split(":")[1]
        common.stop(ip,port,killtype=ft)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
    def single_node_fault_killall_localback_qianbase(self):
        # install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        # set cluster setting checkpoint time 
        obj331.set_ckpt()

        # exec tpcc workload data
        obj331.exec_tpcc()
       
        #exec tpcc work business
        p = obj331.exec_tpcc_business()


        #get rid=3 room info
        rid2info = common.test_args()[1]
        rid2single = list(rid2info.keys())[0]
        ipport = rid2single
        ip = ipport.split(":")[0]
        port = ipport.split(":")[1]
        common.stop(ip,port,killtype=ft)

        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        
    def single_node_fault_killall_primary_qianbase(self):
        # install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        # set cluster setting checkpoint time 
        obj331.set_ckpt()

        # exec tpcc workload data
        obj331.exec_tpcc()
       
        #exec tpcc work business
        p = obj331.exec_tpcc_business()


        #get rid=1 room info
        rid1info = common.test_args()[0]
        rid1single = list(rid1info.keys())[0]
        ipport = rid1single
        ip = ipport.split(":")[0]
        port = ipport.split(":")[1]
        common.stop(ip,port,killtype=ft)

        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        
        
    def single_node_fault_killall_runtime_primary_qianbase(self):
        # install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        # set cluster setting checkpoint time 
        obj331.set_ckpt()

        # exec tpcc workload data
        obj331.exec_tpcc()
       
        #exec tpcc work business
        p = obj331.exec_tpcc_business()


        #get rid=1 room info
        rid1info = common.test_args()[0]
        rid1single = list(rid1info.keys())[0]

        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_runtime(p,fn=fn,ipport=rid1single,killtype=ft)
        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        


    def single_node_fault_killall_runtime_localback_qianbase(self):
        # install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        # set cluster setting checkpoint time 
        obj331.set_ckpt()

        # exec tpcc workload data
        obj331.exec_tpcc()
       
        #exec tpcc work business
        p = obj331.exec_tpcc_business()


        #get rid=3 room info
        rid2info = common.test_args()[1]
        rid2single = list(rid2info.keys())[0]

        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_runtime(p,fn=fn,ipport=rid2single,killtype=ft)
        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]

    def single_node_fault_killall_runtime_remote_qianbase(self):
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()

        ##get rid=3 room info
        rid3info = common.test_args()[2]
        rid3single = list(rid3info.keys())[0]

        # exec tpcc workload data
        obj331.exec_tpcc()
       
        #exec tpcc work business
        p = obj331.exec_tpcc_business()


        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_runtime(p,fn=fn,ipport=rid3single,killtype=ft)
        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]


if __name__ == '__main__':
   pass 


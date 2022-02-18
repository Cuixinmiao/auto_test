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
    from factory import set_iptables
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
    from factory import set_iptables
    from factory.collect import *
    from factory.util_ha import startup331 as startup_ha 
    from factory.util_ha.startup331 import BaseCls
    from factory.util_ha import inst331 as inst
    from factory.util_ha.inst331 import Startup


"""set ckpt sql relational variables"""
obj331 = BaseCls()




"""exec func module's class !!!!!  singnode fault operation kill method kill -9"""
class Qianbasetestha331():
    def setup_class(self):
        obj331.teardown()
        obj331.pre_env()

    def teardown_class(self):
        #obj331.teardown()
        pass

    def iptables_drop_runtime_localback_qianbase(self):
        # install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        # set cluster setting checkpoint time 
        obj331.set_ckpt()

        # exec tpcc workload data
        obj331.exec_tpcc()
       
        #exec tpcc work business
        p = obj331.exec_tpcc_business()


        #get rid=3 room info
        rid1info = common.test_args()[0]
        rid1tmp=[]
        for key1 in rid1info:
            rid1tmp.append(key1.split(":")[0])
        rid1 = list(set(rid1tmp))    

        rid2info = common.test_args()[1]
        rid2tmp=[]
        for key2 in rid2info:
            rid2tmp.append(key2.split(":")[0])
        rid2 = list(set(rid2tmp))    

        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_runtime_netpatition(p,rid1,rid2,fn=fn)
        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]

    def iptables_reject_runtime_localback_qianbase(self):
        # install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        # set cluster setting checkpoint time 
        obj331.set_ckpt()

        # exec tpcc workload data
        obj331.exec_tpcc()
       
        #exec tpcc work business
        p = obj331.exec_tpcc_business()


        #get rid=3 room info
        rid1info = common.test_args()[0]
        rid1tmp=[]
        for key1 in rid1info:
            rid1tmp.append(key1.split(":")[0])
        rid1 = list(set(rid1tmp))    

        rid2info = common.test_args()[1]
        rid2tmp=[]
        for key2 in rid2info:
            rid2tmp.append(key2.split(":")[0])
        rid2 = list(set(rid2tmp))    

        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_runtime_netpatition(p,rid1,rid2,fn=fn,flag="reject")
        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
    def iptables_drop_localback_qianbase(self):
        try:
            rid1=None
            # install qianbase ,set replicas 7 and register license
            startup_ha.instha()

            # set cluster setting checkpoint time 
            obj331.set_ckpt()

            # exec tpcc workload data
            obj331.exec_tpcc()
       
            #exec tpcc work business
            p = obj331.exec_tpcc_business()


            #get rid=3 room info
            rid1info = common.test_args()[0]
            rid1tmp=[]
            for key1 in rid1info:
                rid1tmp.append(key1.split(":")[0])
            rid1 = list(set(rid1tmp))    

            rid2info = common.test_args()[1]
            rid2tmp=[]
            for key2 in rid2info:
                rid2tmp.append(key2.split(":")[0])
            rid2 = list(set(rid2tmp))    
            for ip in rid1:
                set_iptables.set_iptables_policy(ip,rid2)

            m_name = sys._getframe().f_code.co_name
            fn=os.path.join(os.path.split(__file__)[0],m_name)
            res = common.monitor_tpcc_res(p,fn=fn)
            if res == True:
                assert res == True
            else:
                assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        except Exception as e:
            write_logger(logfile).error("errmsg:%s"%e)
        finally:
            if rid1:
                for ip in rid1:
                    set_iptables.del_iptables_policy(ip,rid2)

    def iptables_reject_localback_qianbase(self):
        try:
            rid1=None
            # install qianbase ,set replicas 7 and register license
            startup_ha.instha()

            # set cluster setting checkpoint time 
            obj331.set_ckpt()

            # exec tpcc workload data
            obj331.exec_tpcc()
       
            #exec tpcc work business
            p = obj331.exec_tpcc_business()


            #get rid=3 room info
            rid1info = common.test_args()[0]
            rid1tmp=[]
            for key1 in rid1info:
                rid1tmp.append(key1.split(":")[0])
            rid1 = list(set(rid1tmp))    

            rid2info = common.test_args()[1]
            rid2tmp=[]
            for key2 in rid2info:
                rid2tmp.append(key2.split(":")[0])
            rid2 = list(set(rid2tmp))    
            for ip in rid1:
                set_iptables.set_iptables_reject_policy(ip,rid2)

            m_name = sys._getframe().f_code.co_name
            fn=os.path.join(os.path.split(__file__)[0],m_name)
            res = common.monitor_tpcc_res(p,fn=fn)
            if res == True:
                assert res == True
            else:
                assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        except Exception as e:
            write_logger(logfile).error("errmsg:%s"%e)
        finally:
            if rid1:
                for ip in rid1:
                    set_iptables.del_iptables_policy(ip,rid2)


if __name__ == '__main__':
   pass 


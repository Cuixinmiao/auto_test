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
    from factory import multithread
    from factory import conf
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
    from factory import multithread
    from factory import conf
    from factory.collect import *
    from factory.util_ha import startup331 as startup_ha 
    from factory.util_ha.startup331 import BaseCls
    from factory.util_ha import inst331 as inst
    from factory.util_ha.inst331 import Startup


"""set ckpt sql relational variables"""
obj331 = BaseCls()





"""exec func module's class !!!!!  singnode fault operation kill method kill -9"""
class Qianbasetestfunc():
    def setup_class(self):
        obj331.teardown()
        obj331.pre_env()

    def teardown_class(self):
        #obj331.teardown()
        pass
    # decommission_remote with data
    def decommission_remote_qianbase(self):
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()
        #primary room replicas 
        prep = obj331.prep
        #local back room replicas 
        brep = obj331.brep
        #remote room replicas 
        rrep = obj331.rrep

        ##get room info
        allinfo = common.test_args()
        rid1info = allinfo[0]
        rid2info = allinfo[1]
        rid3info = allinfo[2]
        ipport = list(rid1info.keys())[0]

        #check db status
        retstat1 = multithread.get_status(ipport) 
        if retstat1:
            assert 1 == 0,"status exception node is %s"%str(retstat1)


        #check checkpoint status
        retckpt1 = common.check_ckpt(ipport)
        if retckpt1[0] == None:
            assert 1 == 0,"start jobs ckpt failed"
        elif retckpt1[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt1[1],retckpt1[2])



        # exec tpcc workload data
        obj331.exec_tpcc()

        #modify zone config and execute decommission node id operator
        zoneconfig_sql = conf.initrid12.format(prep,brep,str(int(prep)+int(brep)))
        common.exec_decommission(ipport,rid3info,zoneconfig_sql,timeout=600)

        #check replicas
        common.check_replicas(reps=str(int(prep)+int(brep)),ipport=ipport)


        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        #check checkpoint status
        retckpt2 = common.check_ckpt(ipport)
        if retckpt2[0] == None:
            assert 1 == 0,"exec business and ckpt jobs status failed"
        elif retckpt2[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt2[1],retckpt2[2])

        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]
        #retstat2 = multithread.get_status(ipport) 
        #if retstat2:
        #    assert 1 == 0,"status exception node is %s"%str(retstat2)

    # decommission_remote no data
    def decommission_remote_nodata_qianbase(self):
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()
        #primary room replicas 
        prep = obj331.prep
        #local back room replicas 
        brep = obj331.brep
        #remote room replicas 
        rrep = obj331.rrep

        ##get room info
        allinfo = common.test_args()
        rid1info = allinfo[0]
        rid2info = allinfo[1]
        rid3info = allinfo[2]
        ipport = list(rid1info.keys())[0]

        #check db status
        retstat1 = multithread.get_status(ipport) 
        if retstat1:
            assert 1 == 0,"status exception node is %s"%str(retstat1)


        #check checkpoint status
        retckpt1 = common.check_ckpt(ipport)
        if retckpt1[0] == None:
            assert 1 == 0,"start jobs ckpt failed"
        elif retckpt1[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt1[1],retckpt1[2])

        #modify zone config and execute decommission node id operator
        zoneconfig_sql = conf.initrid12.format(prep,brep,str(int(prep)+int(brep)))
        common.exec_decommission(ipport,rid3info,zoneconfig_sql,timeout=600)

        #check replicas
        common.check_replicas(reps=str(int(prep)+int(brep)),ipport=ipport)

        # exec tpcc workload data
        obj331.exec_tpcc()


        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        #check checkpoint status
        retckpt2 = common.check_ckpt(ipport)
        if retckpt2[0] == None:
            assert 1 == 0,"exec business and ckpt jobs status failed"
        elif retckpt2[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt2[1],retckpt2[2])

        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]
        #retstat2 = multithread.get_status(ipport) 
        #if retstat2:
        #    assert 1 == 0,"status exception node is %s"%str(retstat2)

    # decommission_remote single node data
    def decommission_remote_singleinstance_qianbase(self):
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()
        #primary room replicas 
        prep = obj331.prep
        #local back room replicas 
        brep = obj331.brep
        #remote room replicas 
        rrep = obj331.rrep

        ##get room info
        allinfo = common.test_args()
        rid1info = allinfo[0]
        rid2info = allinfo[1]
        rid3info = allinfo[2]
        if len(rid3info) <= 1:
            assert 1 == 1,"test case need greater than 2 node instance"

        key = list(rid3info.keys())[0]
        # get del node info for rid3
        delnode = {}
        delnode[key] = rid3info[key]
        ipport = list(rid1info.keys())[0]

        # exec tpcc workload data
        obj331.exec_tpcc()

        #check db status
        retstat1 = multithread.get_status(ipport) 
        if retstat1:
            assert 1 == 0,"status exception node is %s"%str(retstat1)


        #check checkpoint status
        retckpt1 = common.check_ckpt(ipport)
        if retckpt1[0] == None:
            assert 1 == 0,"start jobs ckpt failed"
        elif retckpt1[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt1[1],retckpt1[2])

        #modify zone config and execute decommission node id operator
        #zoneconfig_sql = conf.initrid12.format(prep,brep,str(int(prep)+int(brep)))
        common.exec_decommission(ipport,delnode,sqlstat=None,timeout=600)

        #check replicas 7 
        common.check_replicas()



        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        #check checkpoint status
        retckpt2 = common.check_ckpt(ipport)
        if retckpt2[0] == None:
            assert 1 == 0,"exec business and ckpt jobs status failed"
        elif retckpt2[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt2[1],retckpt2[2])

        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]
        #retstat2 = multithread.get_status(ipport) 
        #if retstat2:
        #    assert 1 == 0,"status exception node is %s"%str(retstat2)

    # decommission_loacl with data
    def decommission_local_qianbase(self):
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()
        #primary room replicas 
        prep = obj331.prep
        #local back room replicas 
        brep = obj331.brep
        #remote room replicas 
        rrep = obj331.rrep

        ##get room info
        allinfo = common.test_args()
        rid1info = allinfo[0]
        rid2info = allinfo[1]
        rid3info = allinfo[2]
        ipport = list(rid1info.keys())[0]

        #check db status
        retstat1 = multithread.get_status(ipport) 
        if retstat1:
            assert 1 == 0,"status exception node is %s"%str(retstat1)


        #check checkpoint status
        retckpt1 = common.check_ckpt(ipport)
        if retckpt1[0] == None:
            assert 1 == 0,"start jobs ckpt failed"
        elif retckpt1[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt1[1],retckpt1[2])



        # exec tpcc workload data
        obj331.exec_tpcc()

        #modify zone config and execute decommission node id operator
        zoneconfig_sql = conf.initrid13.format(prep,rrep,str(int(prep)+int(rrep)))
        common.exec_decommission(ipport,rid2info,zoneconfig_sql,timeout=600)

        #check replicas
        common.check_replicas(reps=str(int(prep)+int(rrep)),ipport=ipport)


        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        #check checkpoint status
        retckpt2 = common.check_ckpt(ipport)
        if retckpt2[0] == None:
            assert 1 == 0,"exec business and ckpt jobs status failed"
        elif retckpt2[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt2[1],retckpt2[2])

        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]
        #retstat2 = multithread.get_status(ipport) 
        #if retstat2:
        #    assert 1 == 0,"status exception node is %s"%str(retstat2)


    # decommission_loacl single instance with data
    def decommission_local_singleinstance_qianbase(self):
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()
        #primary room replicas 
        prep = obj331.prep
        #local back room replicas 
        brep = obj331.brep
        #remote room replicas 
        rrep = obj331.rrep

        ##get room info
        allinfo = common.test_args()
        rid1info = allinfo[0]
        rid2info = allinfo[1]
        rid3info = allinfo[2]
        ipport = list(rid1info.keys())[0]

        #check db status
        retstat1 = multithread.get_status(ipport) 
        if retstat1:
            assert 1 == 0,"status exception node is %s"%str(retstat1)


        #check checkpoint status
        retckpt1 = common.check_ckpt(ipport)
        if retckpt1[0] == None:
            assert 1 == 0,"start jobs ckpt failed"
        elif retckpt1[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt1[1],retckpt1[2])



        # exec tpcc workload data
        obj331.exec_tpcc()

        #decommission instance info
        delnode = {}
        key=list(rid2info.keys())[0]
        delnode[key] = rid2info[key]
        #modify zone config and execute decommission node id operator
        #zoneconfig_sql = conf.initrid13.format(prep,rrep,str(int(prep)+int(rrep)))
        common.exec_decommission(ipport,delnode,sqlstat=None,timeout=600)

        #check replicas
        common.check_replicas()


        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        #check checkpoint status
        retckpt2 = common.check_ckpt(ipport)
        if retckpt2[0] == None:
            assert 1 == 0,"exec business and ckpt jobs status failed"
        elif retckpt2[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt2[1],retckpt2[2])

        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]
        #retstat2 = multithread.get_status(ipport) 
        #if retstat2:
        #    assert 1 == 0,"status exception node is %s"%str(retstat2)

    # decommission_primary single instance with data
    def decommission_primary_singleinstance_qianbase(self):
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()
        #primary room replicas 
        prep = obj331.prep
        #local back room replicas 
        brep = obj331.brep
        #remote room replicas 
        rrep = obj331.rrep

        ##get room info
        allinfo = common.test_args()
        rid1info = allinfo[0]
        rid2info = allinfo[1]
        rid3info = allinfo[2]
        ipport = list(rid1info.keys())[0]

        #check db status
        retstat1 = multithread.get_status(ipport) 
        if retstat1:
            assert 1 == 0,"status exception node is %s"%str(retstat1)


        #check checkpoint status
        retckpt1 = common.check_ckpt(ipport)
        if retckpt1[0] == None:
            assert 1 == 0,"start jobs ckpt failed"
        elif retckpt1[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt1[1],retckpt1[2])



        # exec tpcc workload data
        obj331.exec_tpcc()

        #decommission instance info
        delnode = {}
        key = list(rid1info.keys())[1]
        delnode[key] = rid1info[key]
        #modify zone config and execute decommission node id operator
        #zoneconfig_sql = conf.initrid13.format(prep,rrep,str(int(prep)+int(rrep)))
        common.exec_decommission(ipport,delnode,sqlstat=None,timeout=600)

        #check replicas
        common.check_replicas()


        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        #check checkpoint status
        retckpt2 = common.check_ckpt(ipport)
        if retckpt2[0] == None:
            assert 1 == 0,"exec business and ckpt jobs status failed"
        elif retckpt2[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt2[1],retckpt2[2])

        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]
        #retstat2 = multithread.get_status(ipport) 
        #if retstat2:
        #    assert 1 == 0,"status exception node is %s"%str(retstat2)

    # decommission_remote single and local single node data
    def decommission_remote_local_singleinstance_qianbase(self):
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()
        #primary room replicas 
        prep = obj331.prep
        #local back room replicas 
        brep = obj331.brep
        #remote room replicas 
        rrep = obj331.rrep

        ##get room info
        allinfo = common.test_args()
        rid1info = allinfo[0]
        rid2info = allinfo[1]
        rid3info = allinfo[2]
        if len(rid3info) <= 1:
            assert 1 == 1,"test case need greater than 2 node instance"

        key = list(rid3info.keys())[0]
        key2 = list(rid2info.keys())[1]
        # get del node info for rid3
        delnode = {}
        delnode[key] = rid3info[key]
        delnode[key2] = rid2info[key2]

        ipport = list(rid1info.keys())[0]

        # exec tpcc workload data
        obj331.exec_tpcc()

        #check db status
        retstat1 = multithread.get_status(ipport) 
        if retstat1:
            assert 1 == 0,"status exception node is %s"%str(retstat1)


        #check checkpoint status
        retckpt1 = common.check_ckpt(ipport)
        if retckpt1[0] == None:
            assert 1 == 0,"start jobs ckpt failed"
        elif retckpt1[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt1[1],retckpt1[2])

        #modify zone config and execute decommission node id operator
        #zoneconfig_sql = conf.initrid12.format(prep,brep,str(int(prep)+int(brep)))
        common.exec_decommission(ipport,delnode,sqlstat=None,timeout=600)

        #check replicas 7 
        common.check_replicas()



        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        #check checkpoint status
        retckpt2 = common.check_ckpt(ipport)
        if retckpt2[0] == None:
            assert 1 == 0,"exec business and ckpt jobs status failed"
        elif retckpt2[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt2[1],retckpt2[2])

        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]
        #retstat2 = multithread.get_status(ipport) 
        #if retstat2:
        #    assert 1 == 0,"status exception node is %s"%str(retstat2)

    # decommission_primary single,remote single and local single node data
    def decommission_primary_remote_local_singleinstance_qianbase(self):
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()
        #primary room replicas 
        prep = obj331.prep
        #local back room replicas 
        brep = obj331.brep
        #remote room replicas 
        rrep = obj331.rrep

        ##get room info
        allinfo = common.test_args()
        rid1info = allinfo[0]
        rid2info = allinfo[1]
        rid3info = allinfo[2]
        if len(rid3info) <= 1:
            assert 1 == 1,"test case need greater than 2 node instance"

        key = list(rid3info.keys())[0]
        key2 = list(rid2info.keys())[1]
        key3 = list(rid1info.keys())[1]
        # get del node info for rid3
        delnode = {}
        delnode[key] = rid3info[key]
        delnode[key2] = rid2info[key2]
        delnode[key3] = rid1info[key3]

        ipport = list(rid1info.keys())[0]

        # exec tpcc workload data
        obj331.exec_tpcc()

        #check db status
        retstat1 = multithread.get_status(ipport) 
        if retstat1:
            assert 1 == 0,"status exception node is %s"%str(retstat1)


        #check checkpoint status
        retckpt1 = common.check_ckpt(ipport)
        if retckpt1[0] == None:
            assert 1 == 0,"start jobs ckpt failed"
        elif retckpt1[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt1[1],retckpt1[2])

        #modify zone config and execute decommission node id operator
        #zoneconfig_sql = conf.initrid12.format(prep,brep,str(int(prep)+int(brep)))
        common.exec_decommission(ipport,delnode,sqlstat=None,timeout=600)

        #check replicas 7 
        common.check_replicas()



        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        #check checkpoint status
        retckpt2 = common.check_ckpt(ipport)
        if retckpt2[0] == None:
            assert 1 == 0,"exec business and ckpt jobs status failed"
        elif retckpt2[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt2[1],retckpt2[2])

        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]
        #retstat2 = multithread.get_status(ipport) 
        #if retstat2:
        #    assert 1 == 0,"status exception node is %s"%str(retstat2)

    # decommission_primary single and remote single node data
    def decommission_primary_remote_singleinstance_qianbase(self):
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()
        #primary room replicas 
        prep = obj331.prep
        #local back room replicas 
        brep = obj331.brep
        #remote room replicas 
        rrep = obj331.rrep

        ##get room info
        allinfo = common.test_args()
        rid1info = allinfo[0]
        rid2info = allinfo[1]
        rid3info = allinfo[2]
        if len(rid3info) <= 1:
            assert 1 == 1,"test case need greater than 2 node instance"

        key = list(rid3info.keys())[0]
        key2 = list(rid1info.keys())[1]
        # get del node info for rid3
        delnode = {}
        delnode[key] = rid3info[key]
        delnode[key2] = rid1info[key2]

        ipport = list(rid1info.keys())[0]

        # exec tpcc workload data
        obj331.exec_tpcc()

        #check db status
        retstat1 = multithread.get_status(ipport) 
        if retstat1:
            assert 1 == 0,"status exception node is %s"%str(retstat1)


        #check checkpoint status
        retckpt1 = common.check_ckpt(ipport)
        if retckpt1[0] == None:
            assert 1 == 0,"start jobs ckpt failed"
        elif retckpt1[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt1[1],retckpt1[2])

        #modify zone config and execute decommission node id operator
        #zoneconfig_sql = conf.initrid12.format(prep,brep,str(int(prep)+int(brep)))
        common.exec_decommission(ipport,delnode,sqlstat=None,timeout=600)

        #check replicas 7 
        common.check_replicas()



        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        #check checkpoint status
        retckpt2 = common.check_ckpt(ipport)
        if retckpt2[0] == None:
            assert 1 == 0,"exec business and ckpt jobs status failed"
        elif retckpt2[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt2[1],retckpt2[2])

        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]
        #retstat2 = multithread.get_status(ipport) 
        #if retstat2:
        #    assert 1 == 0,"status exception node is %s"%str(retstat2)

    # decommission_remote room and local room node data
    def decommission_remote_local_room_qianbase(self):
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()
        #primary room replicas 
        prep = obj331.prep
        #local back room replicas 
        brep = obj331.brep
        #remote room replicas 
        rrep = obj331.rrep

        ##get room info
        allinfo = common.test_args()
        rid1info = allinfo[0]
        rid2info = allinfo[1]
        rid3info = allinfo[2]
        if len(rid3info) <= 1:
            assert 1 == 1,"test case need greater than 2 node instance"

        key = list(rid3info.keys())[0]
        key2 = list(rid2info.keys())[1]
        # get del node info for rid3
        delnode = {}
        delnode.update(rid3info)
        delnode.update(rid2info)

        ipport = list(rid1info.keys())[0]

        # exec tpcc workload data
        obj331.exec_tpcc()

        #check db status
        retstat1 = multithread.get_status(ipport) 
        if retstat1:
            assert 1 == 0,"status exception node is %s"%str(retstat1)


        #check checkpoint status
        retckpt1 = common.check_ckpt(ipport)
        if retckpt1[0] == None:
            assert 1 == 0,"start jobs ckpt failed"
        elif retckpt1[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt1[1],retckpt1[2])

        #modify zone config and execute decommission node id operator
        zoneconfig_sql = conf.initrid1.format(prep,prep)
        common.exec_decommission(ipport,delnode,zoneconfig_sql,timeout=600)

        #check replicas 7 
        common.check_replicas(reps=prep,ipport=ipport)



        #exec tpcc work business
        p = obj331.exec_tpcc_business()
        #p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],m_name)
        res = common.monitor_tpcc_res(p,fn=fn)
        #check checkpoint status
        retckpt2 = common.check_ckpt(ipport)
        if retckpt2[0] == None:
            assert 1 == 0,"exec business and ckpt jobs status failed"
        elif retckpt2[0] != "running":
            assert 1 == 0,"ckpt jobs status %s failed,errmsg"%(retckpt2[1],retckpt2[2])

        if res == True:
            assert res == True
        else:
            assert res[0] == 0,"delay greater than 24s errmsg:%s"%res[1]
        #retstat2 = multithread.get_status(ipport) 
        #if retstat2:
        #    assert 1 == 0,"status exception node is %s"%str(retstat2)
if __name__ == '__main__':
   pass 


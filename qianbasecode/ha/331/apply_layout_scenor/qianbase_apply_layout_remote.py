#! --*-- coding:utf8 --*--
#           *** readme ***                 #
#  module for remote room offline recovery #
#*** 9 replicas 7  switch primary     *****#
#  *** 7 replicas switch primary ***       #

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
class Qianbasetest_applylayout_finished():
    def setup_class(self):
        obj331.teardown()
        obj331.pre_env()

    def teardown_class(self):
        #obj331.teardown()
        pass

    def remote_offline_singlereplicas_qianbase(self):

        #rid=3 remote back room recover new cluster
        rid = 3
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
        #exec switch room op
        ret = multithread.multi_thread(info,rid)
        if ret == None:
            assert 1 == 0 ,"apply layout failed"
        else:
            caseinfo = ret[1]
            delinfo = ret[2]


        ipport = list(caseinfo.keys())[0]
        ip = ipport.split(":")[0]
        port = ipport.split(":")[1]
        # gen server certs
        expansion_ipport = obj331.expansion_ip
        remoteip = obj331.remoteip
        for ipnumregion in remoteip:
            addr = ipnumregion.split("@")[0]
            sshapp.cmd("pkill -9 %s"%obj331._binname,addr)
            sshapp.upload(obj331.execbin,obj331.binname,addr)
            common.gen_server(addr)
    
        remoteargs = obj331.remoteargs
        if remoteargs:
            for ipdatacmd in remoteargs:
                ip = ipdatacmd[0]
                datadir = ipdatacmd[1]
                cmd = ipdatacmd[2]
                sshapp.cmd("rm -fr %s"%datadir,ip)
                rmt.exec_cmd(cmd,ip)
                write_logger(logfile).info("capacity expansion ip:%s cmd:%s success"%(ip,cmd))
        time.sleep(10)
        retstat = multithread.get_nodeid(ipport)
        if retstat[0] == True:
            retdict = retstat[1]
        else:
            write_logger(logfile).error("capactity expansion failed")
            assert 0 == 1,"capactity expansion failed"
        nodelst = " "
        for newipport in expansion_ipport:
            nodelst = nodelst + retdict[newipport] + " " 

        write_logger(logfile).info("capacity expansion success")
        time.sleep(10)
        obj = multithread.obj
        multithread.exec_replicas_sql(ipport,3)
        common.check_replicas(reps=obj.rrep,ipport=ipport)


                
        time.sleep(20)
        #exec other room recovery
        multithread.startup_cmd(delinfo)
        time.sleep(10)
        multithread.exec_replicas_sql(ipport,9)
        common.check_replicas()

        ##exec tpcc work business
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],"%s_1_%s"%(m_name,str(rid)))
        p = obj331.exec_tpcc_business()
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        restat = multithread.get_status(ipport)
        if restat != []:
            #write_logger(logfile).error("node down info %s"%str(restat))
            assert restat == [],"check node info "
        obj331.check_replicas()
        ##3-0-1
        startup_ha.set_one2zero()
        startup_ha.swith_one2two(rid=1)


        time.sleep(10)
        #obj.rrep=1
        #multithread.exec_replicas_sql(ipport,9)
        #common.check_replicas_expansion()

        ##decommission node info
        retdec = common.decommission_node(ipport,nodelst)
        if not retdec:
            assert 1==0,"decommission node instances failed"


        time.sleep(10)

        ##exec tpcc work business
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],"%s_%s"%(m_name,str(rid)))
        p = obj331.exec_tpcc_business()
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        #restat = multithread.get_status(ipport)
        #if restat != []:
        #    #write_logger(logfile).error("node down info %s"%str(restat))
        #    assert restat == [],"check node info "
            
    #@pytest.mark.skip(reason="9 replicas modify for 7 replicas")
    def remote_offline_multireplicas_qianbase(self):

        #rid=3 remote back room recover new cluster
        rid = 3
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
        #exec switch room op
        ret = multithread.multi_thread(info,rid)
        if ret == None:
            assert 1 == 0 ,"apply layout failed"
        else:
            caseinfo = ret[1]
            delinfo = ret[2]


        ipport = list(caseinfo.keys())[0]
        ip = ipport.split(":")[0]
        port = ipport.split(":")[1]
        # gen server certs
        expansion_ipport = obj331.expansion_ip
        remoteip = obj331.remoteip
        for ipnumregion in remoteip:
            addr = ipnumregion.split("@")[0]
            sshapp.cmd("pkill -9 %s"%obj331._binname,addr)
            sshapp.upload(obj331.execbin,obj331.binname,addr)
            common.gen_server(addr)
    
        remoteargs = obj331.remoteargs
        if remoteargs:
            for ipdatacmd in remoteargs:
                ip = ipdatacmd[0]
                datadir = ipdatacmd[1]
                cmd = ipdatacmd[2]
                sshapp.cmd("rm -fr %s"%datadir,ip)
                rmt.exec_cmd(cmd,ip)
                write_logger(logfile).info("capacity expansion ip:%s cmd:%s success"%(ip,cmd))
        time.sleep(10)
        retstat = multithread.get_nodeid(ipport)
        if retstat[0] == True:
            retdict = retstat[1]
        else:
            write_logger(logfile).error("capactity expansion failed")
            assert 0 == 1,"capactity expansion failed"
        nodelst = " "
        for newipport in expansion_ipport:
            nodelst = nodelst + retdict[newipport] + " " 

        write_logger(logfile).info("capacity expansion success")
        time.sleep(10)
        obj = multithread.obj
        obj.rrep=3
        multithread.exec_replicas_sql(ipport,3)
        common.check_replicas(reps=obj.rrep,ipport=ipport)


                
        time.sleep(10)
        #exec tpcc work business
        p = obj331.exec_tpcc_business(client_ip=ip,client_port=port)
        ##p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)

        ##p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],"%s_%s"%(m_name,str(rid)))
        allinfo = common.test_args(host=ip,port=port)
        totl=0
        for l in allinfo:
            totl = totl + len(l)
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        restat = multithread.get_status(ipport)
        if restat != []:
            #write_logger(logfile).error("node down info %s"%str(restat))
            assert restat == [],"check node info "

        #exec other room recovery
        multithread.startup_cmd(delinfo)
        time.sleep(10)
        multithread.exec_replicas_sql(ipport,9)
        common.check_replicas()

        ##exec tpcc work business
        p = obj331.exec_tpcc_business()
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        restat = multithread.get_status(ipport)
        #if restat != []:
        #    #write_logger(logfile).error("node down info %s"%str(restat))
        #    assert restat == [],"check node info "
        obj331.check_replicas()
        ##3-0-1
        startup_ha.set_one2zero()
        startup_ha.swith_one2two(rid=1)
        time.sleep(10)
        obj.rrep=1
        multithread.exec_replicas_sql(ipport,9)
        common.check_replicas_expansion()

        ##decommission node info
        retdec = common.decommission_node(ipport,nodelst)
        if not retdec:
            assert 1==0,"decommission node instances failed"
    #@pytest.mark.skip(reason="9 replicas modify for 7 replicas")
    def remote_multioffline_multireplicas_qianbase(self):

        #rid=3 remote back room recover new cluster
        rid = 3
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
        #exec switch room op
        ret = multithread.multi_thread(info,rid)
        if ret == None:
            assert 1 == 0 ,"apply layout failed"
        else:
            caseinfo = ret[1]
            delinfo = ret[2]


        ipport = list(caseinfo.keys())[0]
        ip = ipport.split(":")[0]
        port = ipport.split(":")[1]
        # gen server certs
        expansion_ipport = obj331.expansion_ip
        remoteip = obj331.remoteip
        for ipnumregion in remoteip:
            addr = ipnumregion.split("@")[0]
            sshapp.cmd("pkill -9 %s"%obj331._binname,addr)
            sshapp.upload(obj331.execbin,obj331.binname,addr)
            common.gen_server(addr)
    
        remoteargs = obj331.remoteargs
        if remoteargs:
            for ipdatacmd in remoteargs:
                ip = ipdatacmd[0]
                datadir = ipdatacmd[1]
                cmd = ipdatacmd[2]
                sshapp.cmd("rm -fr %s"%datadir,ip)
                rmt.exec_cmd(cmd,ip)
                write_logger(logfile).info("capacity expansion ip:%s cmd:%s success"%(ip,cmd))
        time.sleep(10)
        retstat = multithread.get_nodeid(ipport)
        if retstat[0] == True:
            retdict = retstat[1]
        else:
            write_logger(logfile).error("capactity expansion failed")
            assert 0 == 1,"capactity expansion failed"
        nodelst = " "
        for newipport in expansion_ipport:
            nodelst = nodelst + retdict[newipport] + " " 

        write_logger(logfile).info("capacity expansion success")
        time.sleep(10)
        obj = multithread.obj
        obj.rrep=3
        multithread.exec_replicas_sql(ipport,3)
        common.check_replicas(reps=obj.rrep,ipport=ipport)
        ##multi fault
        ## remote room expect again fault
        inforid3 = common.test_args(host=ip,port=port)
        retrid3 = multithread.multi_thread(inforid3,rid)
        if retrid3 == None:
            assert 0 == 1,"apply layout failed"
        else:
            caseinforid3 = ret[1]
            delinforid3 = ret[2]

                
        time.sleep(10)

        ## set three replicas
        multithread.exec_replicas_sql(ipport,3)
        common.check_replicas(reps=obj.rrep,ipport=ipport)
        #exec tpcc work business
        p = obj331.exec_tpcc_business(client_ip=ip,client_port=port)
        ##p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)

        ##p = common.exec_tpcc_business(obj331.client_ip,obj331.client_port,obj331.amount,obj331.amount,1)
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],"%s_%s"%(m_name,str(rid)))
        allinfo = common.test_args(host=ip,port=port)
        totl=0
        for l in allinfo:
            totl = totl + len(l)
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        restat = multithread.get_status(ipport)
        if restat != []:
            #write_logger(logfile).error("node down info %s"%str(restat))
            assert restat == [],"check node info "

        #exec other room recovery
        multithread.startup_cmd(delinfo)
        time.sleep(10)
        multithread.exec_replicas_sql(ipport,9)
        common.check_replicas(reps=str(int(obj.prep)+int(obj.brep)+int(obj.rrep)),ipport=ipport)

        ##exec tpcc work business
        p = obj331.exec_tpcc_business()
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        restat = multithread.get_status(ipport)
        #if restat != []:
        #    #write_logger(logfile).error("node down info %s"%str(restat))
        #    assert restat == [],"check node info "
        obj331.check_replicas()
        ##3-0-1
        startup_ha.set_one2zero()
        startup_ha.swith_one2two(rid=1)
        time.sleep(10)
        obj.rrep=1
        multithread.exec_replicas_sql(ipport,9)
        common.check_replicas_expansion()

        ##decommission node info
        retdec = common.decommission_node(ipport,nodelst)
        if not retdec:
            assert 1==0,"decommission node instances failed"



if __name__ == '__main__':
   pass 


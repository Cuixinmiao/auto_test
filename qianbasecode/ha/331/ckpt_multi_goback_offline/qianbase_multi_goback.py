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
class Qianbasetest_applylayout_multigoback():
    def setup_class(self):
        obj331.teardown()
        obj331.pre_env()

    def teardown_class(self):
        #obj331.teardown()
        pass

    #@pytest.mark.skip(reason="multi_goback")
    def remote_offline_ckptgoback_qianbase(self):

        #rid=3 remote back room recover new cluster
        rid = 3
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()


        ##get all room info
        info = common.test_args()
        ##get rid=3 assocation info
        rid3dict = info[2].copy()

        # exec tpcc workload data
        obj331.exec_tpcc()

        time.sleep(30)
        caseinfo = None
        delinfo = None

        ## exec tpcc run business
        p = obj331.exec_tpcc_business()
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],"%s_1_%s"%(m_name,str(rid)))
        res = common.monitor_tpcc_res(p,fn=fn)

        mintslst= []
        obj331.teardown()
        mints = multithread.get_roominfo_ckpt_mints(rid3dict)
        write_logger(logfile).info("mints %s"%str(mints))
        if mints[0]:
            mints1 = mints[1]
            prefix=str(int(mints[1].split(".")[0]) - 5)
            prefix2=str(int(mints[1].split(".")[0]) - 10)
            prefix3=str(int(mints[1].split(".")[0]) - 60)
            subfix = mints[1].split(".")[1]
            mints2 = ".".join([prefix,subfix])
            mints3 = ".".join([prefix2,subfix])
            mints4 = ".".join([prefix3,subfix])
            write_logger(logfile).info("mints :src:%s interval_5: %s interval_10:%s  interval_60:%s"%(mints1,mints2,mints3,mints4))

        #mintslst.append(mints1)
        mintslst.append(mints2)
        mintslst.append(mints3)
        mintslst.append(mints4)


        count=1
        for mints in mintslst:
            check = ("spec",mints)
            if count == 1:
                #exec switch room op
                ret = multithread.multi_thread_goback(info,rid,check=check)
                if ret == None:
                    assert 1 == 0 ,"apply layout failed"
                else:
                    caseinfo = ret[1]
                    delinfo = ret[2]
                count=2
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
            else:
                #exec switch room op
                multithread.stop_room_instance(rid3dict)
                ret = multithread.exec_apply_layout(rid3dict,rid,check)
                multithread.start_room_instance(rid3dict)
                if ret == None:
                    assert 1 == 0 ,"apply layout failed"
                ipport = list(rid3dict.keys())[0]
                ip = ipport.split(":")[0]
                port = ipport.split(":")[1]



            time.sleep(10)
            obj = multithread.obj
            obj.rrep = 3
            multithread.exec_replicas_sql(ipport,3)
            common.check_replicas(reps=obj.rrep,ipport=ipport)
            ##exec tpcc work business
            m_name = sys._getframe().f_code.co_name
            fn=os.path.join(os.path.split(__file__)[0],"%s_1_%s"%(m_name,str(rid)))
            p = obj331.exec_tpcc_business(client_ip=ip,client_port=port)
            res = common.monitor_tpcc_res(p,fn=fn)
            if res != True:
                assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
            tmpinfo = common.test_args(host=ip,port=port)
            rid3dict = tmpinfo[2].copy()

                
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
        obj.rrep=1
        multithread.exec_replicas_sql(ipport,9)
        common.check_replicas_expansion()

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
            
    #@pytest.mark.skip(reason="multi_goback")
    def backroom_offline_ckptgoback_qianbase(self):

        #rid=3 remote back room recover new cluster
        rid = 2
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()


        ##get all room info
        info = common.test_args()
        ##get rid=3 assocation info
        rid2dict = info[1].copy()

        # exec tpcc workload data
        obj331.exec_tpcc()

        time.sleep(30)

        ## exec tpcc run business
        p = obj331.exec_tpcc_business()
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],"%s_1_%s"%(m_name,str(rid)))
        res = common.monitor_tpcc_res(p,fn=fn)

        caseinfo = None
        delinfo = None

        mintslst= []
        obj331.teardown()
        mints = multithread.get_roominfo_ckpt_mints(rid2dict)
        write_logger(logfile).info("mints %s"%str(mints))
        if mints[0]:
            mints1 = mints[1]
            prefix=str(int(mints[1].split(".")[0]) - 5)
            prefix2=str(int(mints[1].split(".")[0]) - 10)
            prefix3=str(int(mints[1].split(".")[0]) - 60)
            subfix = mints[1].split(".")[1]
            mints2 = ".".join([prefix,subfix])
            mints3 = ".".join([prefix2,subfix])
            mints4 = ".".join([prefix3,subfix])
            write_logger(logfile).info("mints :src:%s interval_5: %s interval_10:%s  interval_60:%s"%(mints1,mints2,mints3,mints4))

        #mintslst.append(mints1)
        mintslst.append(mints2)
        mintslst.append(mints3)
        mintslst.append(mints4)


        count=1
        for mints in mintslst:
            check = ("spec",mints)
            if count == 1:
                #exec switch room op
                ret = multithread.multi_thread_goback(info,rid,check=check)
                if ret == None:
                    assert 1 == 0 ,"apply layout failed"
                else:
                    caseinfo = ret[1]
                    delinfo = ret[2]
                count=2
                ipport = list(caseinfo.keys())[0]
                ip = ipport.split(":")[0]
                port = ipport.split(":")[1]
                time.sleep(10)
            else:
                #exec switch room op
                multithread.stop_room_instance(rid2dict)
                ret = multithread.exec_apply_layout(rid2dict,rid,check)
                multithread.start_room_instance(rid2dict)
                if ret == None:
                    assert 1 == 0 ,"apply layout failed"
                ipport = list(rid2dict.keys())[0]
                ip = ipport.split(":")[0]
                port = ipport.split(":")[1]

            #exec recovery business
            time.sleep(10)
            obj = multithread.obj
            multithread.exec_replicas_sql(ipport,2)
            common.check_replicas(reps=obj.brep,ipport=ipport)
            ##exec tpcc work business
            m_name = sys._getframe().f_code.co_name
            fn=os.path.join(os.path.split(__file__)[0],"%s_1_%s"%(m_name,str(rid)))
            p = obj331.exec_tpcc_business(client_ip=ip,client_port=port)
            res = common.monitor_tpcc_res(p,fn=fn)
            if res != True:
                assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
            tmpinfo = common.test_args(host=ip,port=port)
            rid2dict = tmpinfo[1].copy()

                
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
        ##2-0-1
        startup_ha.set_one2zero()
        startup_ha.swith_one2two(rid=1)


        time.sleep(10)



        ##exec tpcc work business
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],"%s_%s"%(m_name,str(rid)))
        p = obj331.exec_tpcc_business()
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
    #@pytest.mark.skip(reason="multi_goback")
    def primaryroom_offline_ckptgoback_qianbase(self):

        #rid=3 remote back room recover new cluster
        rid = 1
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()


        ##get all room info
        info = common.test_args()
        ##get rid=3 assocation info
        rid1dict = info[0].copy()

        # exec tpcc workload data
        p = obj331.exec_tpcc()

        time.sleep(30)

        ## exec tpcc run business
        p = obj331.exec_tpcc_business()
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],"%s_1_%s"%(m_name,str(rid)))
        res = common.monitor_tpcc_res(p,fn=fn)

        caseinfo = None
        delinfo = None

        mintslst= []
        obj331.teardown()
        mints = multithread.get_roominfo_ckpt_mints(rid1dict)
        write_logger(logfile).info("mints %s"%str(mints))
        if mints[0]:
            mints1 = mints[1]
            prefix=str(int(mints[1].split(".")[0]) - 5)
            prefix2=str(int(mints[1].split(".")[0]) - 10)
            prefix3=str(int(mints[1].split(".")[0]) - 60)
            subfix = mints[1].split(".")[1]
            mints2 = ".".join([prefix,subfix])
            mints3 = ".".join([prefix2,subfix])
            mints4 = ".".join([prefix3,subfix])
            write_logger(logfile).info("mints :src:%s interval_5: %s interval_10:%s  interval_60:%s"%(mints1,mints2,mints3,mints4))

        #mintslst.append(mints1)
        mintslst.append(mints2)
        mintslst.append(mints3)
        mintslst.append(mints4)


        count=1
        for mints in mintslst:
            check = ("spec",mints)
            if count == 1:
                #exec switch room op
                ret = multithread.multi_thread_goback(info,rid,check=check)
                if ret == None:
                    assert 1 == 0 ,"apply layout failed"
                else:
                    caseinfo = ret[1]
                    delinfo = ret[2]
                count=2
                ipport = list(caseinfo.keys())[0]
                ip = ipport.split(":")[0]
                port = ipport.split(":")[1]
                time.sleep(10)
            else:
                #exec switch room op
                multithread.stop_room_instance(rid1dict)
                ret = multithread.exec_apply_layout(rid1dict,rid,check)
                multithread.start_room_instance(rid1dict)
                if ret == None:
                    assert 1 == 0 ,"apply layout failed"
                ipport = list(rid1dict.keys())[0]
                ip = ipport.split(":")[0]
                port = ipport.split(":")[1]


            time.sleep(10)
            obj = multithread.obj
            multithread.exec_replicas_sql(ipport,1)
            common.check_replicas(reps=obj.prep,ipport=ipport)
            ##exec tpcc work business
            m_name = sys._getframe().f_code.co_name
            fn=os.path.join(os.path.split(__file__)[0],"%s_1_%s"%(m_name,str(rid)))
            p = obj331.exec_tpcc_business(client_ip=ip,client_port=port)
            res = common.monitor_tpcc_res(p,fn=fn)
            if res != True:
                assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
            tmpinfo = common.test_args(host=ip,port=port)
            rid1dict = tmpinfo[0].copy()

                
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

        """
        obj331.check_replicas()
        ##3-0-1
        startup_ha.set_one2zero()
        startup_ha.swith_one2two(rid=2)

        time.sleep(10)

        ##exec tpcc work business
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],"%s_%s"%(m_name,str(rid)))
        p = obj331.exec_tpcc_business()
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]
        """

    #@pytest.mark.skip(reason="multi_goback")
    def allbackroom_offline_ckptgoback_qianbase(self):

        #rid=3 remote back room recover new cluster
        rid = 4
        ## install qianbase ,set replicas 7 and register license
        startup_ha.instha()

        ## set cluster setting checkpoint time 
        obj331.set_ckpt()


        ##get all room info
        info = common.test_args()
        ##get rid=3 assocation info
        rid2dict = info[1].copy()
        rid3dict = info[2].copy()
        rid3dict.update(rid2dict)
        rid4dict = rid3dict.copy()

        # exec tpcc workload data
        p = obj331.exec_tpcc()

        time.sleep(30)

        ## exec tpcc run business
        p = obj331.exec_tpcc_business()
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],"%s_1_%s"%(m_name,str(rid)))
        res = common.monitor_tpcc_res(p,fn=fn)

        caseinfo = None
        delinfo = None

        mintslst= []
        obj331.teardown()
        mints = multithread.get_roominfo_ckpt_mints(rid4dict)
        write_logger(logfile).info("mints %s"%str(mints))
        if mints[0]:
            mints1 = mints[1]
            prefix=str(int(mints[1].split(".")[0]) - 5)
            prefix2=str(int(mints[1].split(".")[0]) - 10)
            prefix3=str(int(mints[1].split(".")[0]) - 60)
            subfix = mints[1].split(".")[1]
            mints2 = ".".join([prefix,subfix])
            mints3 = ".".join([prefix2,subfix])
            mints4 = ".".join([prefix3,subfix])
            write_logger(logfile).info("mints :src:%s interval_5: %s interval_10:%s  interval_60:%s"%(mints1,mints2,mints3,mints4))

        #mintslst.append(mints1)
        mintslst.append(mints2)
        mintslst.append(mints3)
        mintslst.append(mints4)


        count=1
        for mints in mintslst:
            check = ("spec",mints)
            if count == 1:
                #exec switch room op
                ret = multithread.multi_thread_goback(info,rid,check=check)
                if ret == None:
                    assert 1 == 0 ,"apply layout failed"
                else:
                    caseinfo = ret[1]
                    delinfo = ret[2]
                count=2
                ipport = list(caseinfo.keys())[0]
                ip = ipport.split(":")[0]
                port = ipport.split(":")[1]
                time.sleep(10)
            else:
                #exec switch room op
                multithread.stop_room_instance(rid4dict)
                ret = multithread.exec_apply_layout(rid4dict,rid,check)
                multithread.start_room_instance(rid4dict)
                if ret == None:
                    assert 1 == 0 ,"apply layout failed"
                ipport = list(rid4dict.keys())[0]
                ip = ipport.split(":")[0]
                port = ipport.split(":")[1]



            time.sleep(10)
            obj = multithread.obj
            multithread.exec_replicas_sql(ipport,4)
            common.check_replicas(reps=str(int(obj.brep)+int(obj.rrep)),ipport=ipport)
            ##exec tpcc work business
            m_name = sys._getframe().f_code.co_name
            fn=os.path.join(os.path.split(__file__)[0],"%s_1_%s"%(m_name,str(rid)))
            p = obj331.exec_tpcc_business(client_ip=ip,client_port=port)
            res = common.monitor_tpcc_res(p,fn=fn)
            if res != True:
                assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]

                
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
        ##2-0-1
        startup_ha.set_one2zero()
        startup_ha.swith_one2two(rid=1)

        time.sleep(10)

        ##exec tpcc work business
        m_name = sys._getframe().f_code.co_name
        fn=os.path.join(os.path.split(__file__)[0],"%s_%s"%(m_name,str(rid)))
        p = obj331.exec_tpcc_business()
        res = common.monitor_tpcc_res(p,fn=fn)
        if res != True:
            assert res[0] == 0,"delay greater than 26s errmsg:%s"%res[1]


if __name__ == '__main__':
   pass 


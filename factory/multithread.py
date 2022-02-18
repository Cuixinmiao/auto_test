#!/usr/bin/python
# -*- coding:utf8 -*-
#################################
#date :2021-12-16
#func  :threading method 
#author :Xinmiao Cui
################################

import os
import sys
import threading
import threading
import time
import subprocess
import pysnooper
import decimal
import pysnooper


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
    from factory.collect import *
    from factory.conf import *
    from factory import sshapp
    from factory import common
    from factory import rmt
    from factory.util_ha.startup331 import * 
    from factory.common import *
    from factory.conf import *
except Exception as e:
    sys.path.append(syspath)
    from factory.collect import *
    from factory.conf import *
    from factory import sshapp
    from factory import common
    from factory import rmt
    from factory.util_ha.startup331 import * 
    from factory.common import *
    from factory.conf import *


obj331 = BaseCls()
 
class Test(threading.Thread):
    
    def __init__(self,cmd,host,func=sshapp.cmd):
        super().__init__()
        self.mutex = threading.Lock()
        self.host = host
        self.cmd = cmd
        self.func = func
 
    def run(self):
        self.mutex.acquire()
        self.func(self.cmd,self.host)
        self.mutex.release()
 
class Teststop(threading.Thread):
    
    def __init__(self,host,port,func=common.stop):
        super().__init__()
        self.mutex = threading.Lock()
        self.host = host
        self.cmd = port
        self.func = func
 
    def run(self):
        self.mutex.acquire()
        self.func(self.host,self.cmd)
        self.mutex.release()



#exec sql and replicas
def exec_replicas_sql(ipport,rid):

    try:
        #initsqlfstr = "initrid%s"%str(rid)
        #if rid == 4:
        #    initsqlfstr = "initrid%s"%str(23)
        totrep = int(obj.prep)+int(obj.brep)+int(obj.rrep)
        if  rid == 1:
            initsql = initrid1.format(obj.prep,obj.prep)
        elif rid == 2:
            initsql = initrid2.format(obj.brep,obj.brep)
        elif rid == 3:
            initsql = initrid3.format(obj.rrep,obj.rrep)
        elif rid == 4:
            initsql = initrid23.format(obj.brep,obj.rrep,str(int(obj.brep)+int(obj.rrep)))
        else:
            initsql = initha331.format(obj.prep,obj.brep,obj.rrep,str(totrep))

        sqlcmd = "%s/%s"%(toolspath,binname) +  " sql --" + securemod + " --host=" + ipport + " -e " +'  "%s"'%initsql 
        write_logger(logfile).info("sqlcmd:%s"%sqlcmd)
        count=1
        timeout=30
        while True:
            sqlcode = subprocess.getstatusoutput(sqlcmd)
            if sqlcode[0] == 0:
                write_logger(logfile).debug("exec sqlcmd %s \nsuccess  detail info %s"%(sqlcmd,sqlcode[1]))
                return True
            else:
                time.sleep(5)
            if count > timeout:
                write_logger(logfile).error("exec sqlcmd %s \n failed detail info %s"%(sqlcmd,sqlcode[1]))
                return None
            count=count+1
                
    except Exception as e:
        write_logger(logfile).error("exec recovery cluster replicas setting failed ,errmsg:%s"%e)
        return None

def primary_region_last_checkpoint(ipport):
    try:
        appcmd = "%s/%s"%(toolspath,binname) +  " primary-region last-checkpoint --" + securemod + " --host=" + ipport 
        ret = subprocess.getstatusoutput(appcmd)
        if ret[0] == 0:
            return ret[1].split()[0][1:]
        else:
            return ret[1]
    except Exception as e:
        return None


#check all normal instance record ckpt timestamp
def check_record_ts(roominfo,timeout=60):
        to2 = 1
        write_logger(logfile).info("check all normal instance  ckpt ts start!!")
        while True:
            tmprid1info = roominfo 
            if to2 > timeout:
                write_logger(logfile).info("check kup rong timeout ")
                break
            if roominfo: 
                i = 0
                for key in tmprid1info:
                    ret = primary_region_last_checkpoint(key)
                    if "rror:" in ret.lower() and "connection refused" not in ret: 
                        write_logger(logfile).info("check kup rong info %sth 5s "%str(to2))
                        time.sleep(5)
                        continue
                    else:
                        i = i + 1
                if i == len(roominfo):
                    break
            to2 = to2 + 1
        write_logger(logfile).info("check all normal instance  ckpt ts end!!")

# exec get primary-region last-checkpoint interface
@pysnooper.snoop("/home/cxm/qianbase-xtp-test/exec_last_checkpoint.log")
def exec_last_checkpoint(roominfo,check=None):
    try:
        storelist = []
        min_ts = decimal.Decimal("9999999999")
        dirpath="/qianbase/autotest"
        mints = ""
        #get all record ckpt timestamp 's min timestamp
        if check == None:
            for key,value in roominfo.items():
                ip = key.split(":")[0]
                node_id = str(value[2])
                store = value[3]
                ret = primary_region_last_checkpoint(key) 
                if not ret:
                    continue
                #ts = int(ret.split(".")[0]) 
                ts = decimal.Decimal(ret.split(",")[0]) 
                if ts < min_ts:
                    min_ts = ts
                    mints = ret
                storelist.append((ip,store,"%s_%s/desc_%s.lst"%(dirpath,node_id,node_id),node_id,key))
        return (mints,storelist)
    except Exception as e:
        write_logger(logfile).error("get mints failed errmsg:%s"%e)
        return None

# startup instance cmd
def startup_cmd(caseinfo,rid=None):
    try:
        #staortup cmd
        startthreads = []
        for key,value in caseinfo.items():
            ip = key.split(":")[0]
            cmd = value[1]
            store = value[3]
            cmd = "rm -fr %s;"%store + cmd
            startthreads.append(Test(cmd,ip,rmt.exec_cmd))
        
        for startthread in startthreads:
            startthread.start()

        for startthread in startthreads:
            startthread.join()

        time.sleep(10)
        write_logger(logfile).info("startup instance success")
        return True
    except Exception as e:
        write_logger(logfile).error("startup instance failed errmsg:%s"%e)
        return None



#get cluster status info
def get_status(ipport,nodenum=None):
    try:

        #sql cmd
        sqlstat = "%s/%s"%(toolspath,binname) +  " sql --" + securemod + " --host=" + ipport + " -e " +'  "%s"'%sqllive

        #exec sqlstat cmd
        statinfo = subprocess.getstatusoutput(sqlstat)
        if statinfo[0] == 0:
            retinfo = statinfo[1].split("\n")
        else:
            write_logger(logfile).error("exec sql %s errmsg:%s"%(sqlstat,statinfo[1]))
            return None
        node=[]
        add=[]
        live=[]
        for line in retinfo:
            if line.startswith("node_id"):
                node_id = line.split("\t")[0]
                address = line.split("\t")[1]
                is_live = line.split("\t")[2]
            else:
                node.append(line.split("\t")[0])
                add.append(line.split("\t")[1])
                live.append(line.split("\t")[2])
        
        retdict={node_id:node,address:add,is_live:live}
        #return retdict
        retlst = []
        if nodenum:
            if len(node) != int(nodenum):
                write_logger(logfile).error("get cluster instances num  unconsistent failed ")
                return None
        for i in range(0,len(node)):
            if live[i] != 'true':
                retlst.append((node[i],add[i],live[i]))

        return retlst
    except Exception as e:
        write_logger(logfile).error("get cluster status failed errmsg:%s"%e)
        return None


#get cluster status info
def get_nodeid(ipport):
    try:

        #sql cmd
        sqlstat = "%s/%s"%(toolspath,binname) +  " sql --" + securemod + " --host=" + ipport + " -e " +'  "%s"'%sqllive

        #exec sqlstat cmd
        statinfo = subprocess.getstatusoutput(sqlstat)
        if statinfo[0] == 0:
            retinfo = statinfo[1].split("\n")
        else:
            write_logger(logfile).error("exec sql %s errmsg:%s"%(sqlstat,statinfo[1]))
            return None
        live=[]
        add = []
        retdict={}
        for line in retinfo:
            if line.startswith("node_id"):
                pass
            else:
                node_id = line.split("\t")[0]
                address = line.split("\t")[1]
                add.append(address)
                retdict[address] = node_id
                live.append(line.split("\t")[2])
        stats = []
        for live_check in live:
            if live_check != 'true':
                stats.append(add[live.index(live_check)])
        if stats:
            write_logger(logfile).error("add new instance startup failed %s!!!"%str(stats))
            return (None,stats)
        return (True,retdict)
    except Exception as e:
        write_logger(logfile).error("get cluster status failed errmsg:%s"%e)
        return (None,)

# slice list get checkpoint min ts
def slic_list(lst):
    try:
        retdict = {}
        bb = set(aa)
        for i in bb:
            ikey = i.split(".")[0]
            retdict[int(ikey)] = []

        for key in retdict:
            for val in aa:
                if val.startswith(str(key)+"."):
                    retdict[key].append(val)

        maxts = int(max(retdict.keys()))
        mints = int(min(retdict.keys()))
        print(maxts,mints)
        if maxts - mints <= 60:
            return (True,mints,retdict)

        multilease=len(retdict)/2 + 1
        for key,val in retdict.items():
            if len(val) >= multilease:
                return (True,val[0],retdict)
        tmplen = 0
        lstaa = list(retdict.keys())
        lstaa.reverse()
        for key in lstaa:
            tmplen = tmplen + len(retdict[key])
            if tmplen >= multilease:
                return (True,retdict[key][0],retdict)

        return (None,retdict)
    except Exception as e:
        write_logger(logfile).error("get min ckpt ts failed errmsg:%s"%e)
        return (None,"errmsg:%s"%(e))

# exec get min ckpt ts 
def get_ckpt_lst(roominfo):
    lst = []
    try:
       for key,value in roominfo.items():
           ip = key.split(":")[0]
           store = value[3]
           ret = offline_getmints(ip,store)
           if not ret:
               continue
           lst.append(ret)
    except Exception as e:
        write_logger(logfile).error("get ckpt ts failed errmsg:%s"%e)
        return None
    #get correct ckpt mins
    try:
        if lst:
            rettuple = slic_list(lst) 
            if rettuple[0] == None:
                write_logger(logfile).error("get ckpt min ts failed ckpt ts info%s"%(str(rettuple[1])))
                return (None,)
            elif rettuple[0] == True:
                write_logger(logfile).error("get ckpt min ts success ckpt ts info%s"%(str(rettuple[2])))
                return (True,rettuple[1])

        else:
            write_logger(logfile).error("get ckpt ts failed ckpt ts list empty!!")
            return (None,)
            

    except Exception as e:
        write_logger(logfile).error("get correct ckpt mins failed!!!!")
        return (None,)

# get roominfo ckpt mints
def get_roominfo_ckpt_mints(roominfo):
    try:
        min_ts = 9999999999
        mints = ""
        #get all record ckpt timestamp 's min timestamp
        for key,value in roominfo.items():
            ip = key.split(":")[0]
            node_id = str(value[2])
            store = value[3]
            ret = offline_getmints(ip,store)
            if not ret:
                continue
            ts = decimal.Decimal(ret.split(",")[0]) 
            if ts < min_ts:
                min_ts = ts
                mints = ret
        return (True,mints)
    except Exception as e:
        write_logger(logfile).error("get roominfo min ts failed errmsg:%s"%e)
        return (None,)

# get roominfo ckpt mints
def get_roominfo_ckpt_maxts(roominfo):
    try:
        max_ts = 0
        maxts = ""
        #get all record ckpt timestamp 's min timestamp
        for key,value in roominfo.items():
            ip = key.split(":")[0]
            node_id = str(value[2])
            store = value[3]
            ret = offline_getmints(ip,store)
            if not ret:
                continue
            ts = decimal.Decimal(ret.split(",")[0]) 
            if ts > max_ts:
                max_ts = ts
                maxts = ret
        return (True,maxts)
    except Exception as e:
        write_logger(logfile).error("get roominfo min ts failed errmsg:%s"%e)
        return (None,)
    
# exec debug clear-checkpoint interface
def exec_clear_checkpoint(roominfo,check=(None,)):
    try:
        dirpath = "/qianbase/autotest"
        storelist = []
        threads = []
        min_ts = 9999999999
        mints = ""
        #get all record ckpt timestamp 's min timestamp
        if check[0] == None:
            for key,value in roominfo.items():
                ip = key.split(":")[0]
                node_id = str(value[2])
                store = value[3]
                ret = offline_getmints(ip,store)
                if not ret:
                    continue
                ts = decimal.Decimal(ret.split(",")[0]) 
                if ts < min_ts:
                    min_ts = ts
                    mints = ret
                storelist.append((ip,store,"%s_%s/desc_%s.lst"%(dirpath,node_id,node_id),node_id))
        #直接获取最小时间错
        elif check[0] == "spec":
            mints = check[1]
            #storelist = check[2]
            for key,value in roominfo.items():
                ip = key.split(":")[0]
                node_id = str(value[2])
                store = value[3]
                ret = offline_getmints(ip,store)
                if not ret:
                    continue
                #ts = decimal.Decimal(ret.split(",")[0]) 
                #if ts >= min_ts:
                storelist.append((ip,store,"%s_%s/desc_%s.lst"%(dirpath,node_id,node_id),node_id))

        #get cacandidata timestamp 
        else:
            retinfo = get_ckpt_lst(roominfo)
            if retinfo[0] == True:
                mints = retinfo[1]
            else:
                return (None,"get ckpt mints failed!!!")

            min_ts = decimal.Decimal(mints)
            for key,value in roominfo.items():
                ip = key.split(":")[0]
                node_id = str(value[2])
                store = value[3]
                ret = offline_getmints(ip,store)
                if not ret:
                    continue
                ts = decimal.Decimal(ret.split(",")[0]) 
                if ts >= min_ts:
                    storelist.append((ip,store,"%s_%s/desc_%s.lst"%(dirpath,node_id,node_id),node_id))


        if not storelist:
            write_logger(logfile).error("debug clear-checkpoint no store ckpt timestamp")
            return None
        for ipstore in storelist:
            ip = ipstore[0]
            storetmp = ipstore[1]
            desclst = ipstore[2]
            node_id = ipstore[3]
            cmd="%s/%s"%(bindir,binname)+ " debug clear-checkpoint "  + storetmp + " " + mints +  " " + desclst
            if obj331.debug == "1":
                sshapp.cmd("rm -fr {0}_{1};cp -r {0} {0}_{1};".format(storetmp,"bk"),ip)
            sshapp.cmd("rm -fr {0}_{1};mkdir -p {0}_{1}".format(dirpath,node_id),ip)
            threads.append(Test(cmd,ip,rmt.exec_cmd))

        for t in threads:
            t.start()

        for t in threads:
            t.join()
        write_logger(logfile).debug("clear-checkpoint finished!!!!")
        return storelist
    except Exception as e:
        write_logger(logfile).error("clear-checkpoint failed errmsg:%s!!!!"%e)
        return None
    
# get range data re layout
def exec_region_range_layout(roominfo,rid=2,check=(None,)):

    try:
        ret = exec_clear_checkpoint(roominfo,check)
        if not ret:
            write_logger(logfile).error("region-range-layout failed local step depence clear-checkpoint")
            assert "clear-checkpoint" == "exec_region_range_layout"
        dirall = "/qianbase/alltest"
        os.system("rm -fr {0};mkdir -p {0}".format(dirall))

        write_logger(logfile).debug("exec_clear_checkpoint info %s"%ret)
        try:
            for ipstorefile in ret:
                try:
                    host = ipstorefile[0]
                    store = ipstorefile[1]
                    remotefile = ipstorefile[2]
                    sshapp.download(remotefile,"%s/%s"%(dirall,os.path.basename(remotefile)),host)
                except Exception as e:
                    write_logger(logfile).error("download host: %s filename %s failed,errmsg:%s"%(host,remotefile,e))
                    return None
        except Exception as e:
            write_logger(logfile).debug("download clear-checkpoint range strunct failed errmsg:%s"%e)
            return None
        write_logger(logfile).debug("exec_clear_checkpoint get range struct info end")

        
        if rid == 2:
            cmd = "%s/%s"%(toolspath,binname) +  " debug region-range-layout " + dirall +  " %s:%s"%(str(rid),str(obj331.brep)) + " 2"
        elif rid == 1:
            cmd = "%s/%s"%(toolspath,binname) +  " debug region-range-layout " + dirall +  " %s:%s"%(str(rid),str(obj331.prep)) + " 1"
        elif rid == 3:
            cmd = "%s/%s"%(toolspath,binname) +  " debug region-range-layout " + dirall +  " %s:%s"%(str(rid),str(obj331.rrep)) + " 3"
        elif rid == 4:
            cmd = "%s/%s"%(toolspath,binname) +  " debug region-range-layout " + dirall +  " 2:%s,3:%s"%(str(obj331.brep),str(obj331.rrep)) + " 2"
        write_logger(logfile).debug("range layout new struct start region-ragne-layout cmd %s"%cmd)
        ret1 = subprocess.getstatusoutput(cmd)
        write_logger(logfile).debug("range layout new struct return info \n%s"%str(ret1))
        write_logger(logfile).debug("range layout new struct end")
        if ret1[0] == 0:
            write_logger(logfile).debug("region_range_layout rid : %s  context : %s success"%(str(rid),ret1[1]))
            return (ret,"%s/%s"%(dirall,"desc.list")) 
        else:
            write_logger(logfile).error("region_range_layout rid : %s  failed : %s "%(str(rid),ret1[1]))
            return None
    except Exception as e:
        write_logger(logfile).error("region_range_layout failed errmsg:%s"%e)
        return None

    #print(str(ret,"encoding=utf-8"))

# apply range data re layout images 
def exec_apply_layout(romminfo,rid=2,check=(None,)):

    # apply range new struct
    write_logger(logfile).debug("apply-layout start!!")
    try:
        infotuple = exec_region_range_layout(romminfo,rid,check)
        if not infotuple:
            write_logger(logfile).error("exec_apply_layout failded local step depence region-range-layout")
            assert "region-range-layout" == "apply-layout"
        ipstorefile = infotuple[0]
        filedesc = infotuple[1]
        filename = os.path.basename(filedesc)
        filepath = os.path.split(filedesc)[0]
        applythreads = []
        debuginfo = []
        write_logger(logfile).info("apply info %s"%str(ipstorefile))
        for baseinfo in ipstorefile:
            host = baseinfo[0]
            store = baseinfo[1]
            debuginfo.append((host,store))
            sshapp.cmd("rm -fr {0};mkdir -p {0}".format(filepath),host)
            sshapp.upload(filedesc,filedesc,host)
            applycmd = "%s/%s"%(bindir,binname) +" debug apply-layout " + store +" "+ filedesc 
            #sshapp.cmd(applycmd,host)
            applythreads.append(Test(applycmd,host,rmt.exec_cmd))
        for appthread in applythreads:
            appthread.start()
        for appthread in applythreads:
            appthread.join()
        write_logger(logfile).info("apply info %s"%str(debuginfo))

    except Exception as e:
        write_logger(logfile).error("apply-layout failed errmsg:%s!!"%e)
        return None
    write_logger(logfile).debug("apply-layout end!!")

    # call reset region rid
    try:
        write_logger(logfile).debug("reset primary region start!!")
        resetpr = exec_reset_primary_region(ipstorefile,rid)
        if not resetpr:
            write_logger(logfile).debug("reset primary region failed ,detail description check regression.log")
            return None
        write_logger(logfile).debug("reset primary region end!!")
        return ipstorefile
    except Exception as e:
        write_logger(logfile).error("reset primary region failed errmsg:%s"%e)
        return None

# reset region rid
def exec_reset_primary_region(ipstore,rid=2):
    try:
        resetthreads = []
        for ip_store in ipstore:
            host = ip_store[0]
            store = ip_store[1]
            resetcmd = "%s/%s"%(bindir,binname) + " debug reset-primary-region  " + store  + " " + str(rid)
            if rid==4:
                resetcmd = "%s/%s"%(bindir,binname) + " debug reset-primary-region  " + store  + " " + str(2)
            resetthreads.append(Test(resetcmd,host))

        for resetthread in resetthreads:
            resetthread.start()

        for resetthread in resetthreads:
            resetthread.join()
        return True
    except Exception as e:
        write_logger(logfile).error("set local primary api exec failed errmsg:%s"%e)
        return None


#get offline min timestamp
def offline_getmints(host,store,timeout=60):
    try:
        offlinelckpt = "%s/%s"%(bindir,binname) + " debug last-checkpoint " + store
        ret = sshapp.cmd(offlinelckpt,host)
        if not ret:
            write_logger(logfile).error("get last-checkpoint failed!!!!")
            return None
        rettmp = str(ret,encoding="utf-8").split("\n")[1].split()[1]
        if "checkpoint:" in str(ret,encoding="utf-8"):
            return rettmp
        else:
            return None
    except Exception as e:
        write_logger(logfile).error("node :%s  exec cmd: %s store:%s last-checkpoint failed errmsg:%s"%(host,offlinelckpt,store,e))
        return None

# stop room instance and allinfo dict type
def stop_room_instance(allinfo):
        #stop cmd
        stopthreads = []
        for key,value in allinfo.items():
            ip = key.split(":")[0]
            port = key.split(":")[1]
            stopthreads.append(Teststop(ip,port))
        
        for stopthread in stopthreads:
            stopthread.start()

        for stopthread in stopthreads:
            stopthread.join()

        time.sleep(10)


# start room instance and allinfo dict type
def start_room_instance(allinfo):
        #staortup cmd
        startthreads = []
        for key,value in allinfo.items():
            ip = key.split(":")[0]
            cmd = value[1]
            startthreads.append(Test(cmd,ip,rmt.exec_cmd))
            
        for startthread in startthreads:
            startthread.start()

        for startthread in startthreads:
            startthread.join()

# flag = 1 rid=1  flag=2 rid=2 flag=3 rid=3 flag=4 rid=2 and rid=3
@pysnooper.snoop("/home/cxm/qianbase-xtp-test/multi_thread.log")
def multi_thread(info,flag,fault=None,fn=None,check=None):
    try:
        #dict info key = ipport values list 0 locality info list 1 startup param  string  2 node_id string 3 sore string
        #all romm info
        #if not type(info) is tuple:
        #    write_logger(logfile).error("get all room info failed errmsg：\n%s\n exit testcase"%info)
        #    assert 1 == 0
        #    return None
        #else:
        #    write_logger(logfile).debug("get all room info success msg:\n%s"%info)
        rid1info = info[0]
        # local back room info
        rid2info = info[1]
        print(rid2info)
        # remote back inof
        rid3info = info[2]
        #all back info
        rid4info=info[1].copy()
        rid4info.update(rid3info)
        # primary and local back room
        rid5info=info[1].copy()
        rid5info.update(rid1info)
        #primary and remote back room info
        rid6info = info[0].copy()
        rid6info.update(rid3info)

        #qianbase all instance info
        allinfo = info[0].copy()
        allinfo.update(rid4info) 


        #check all node record ckpt ts
        check_record_ts(allinfo)


        #all back room for recovery
        if flag == 4:
            caseinfo = rid4info
            delinfo = rid1info
            reps = int(obj331.brep) + int(obj331.rrep)
        #remote back room for recovery
        elif flag == 3:
            caseinfo = rid3info
            delinfo = rid5info
            reps = int(obj331.rrep)
        #local back room for recovery
        elif flag == 2:
            caseinfo = rid2info
            delinfo = rid6info
            reps = int(obj331.brep) 
        #primary room for recovery
        else:
            caseinfo = rid1info
            delinfo = rid4info
            reps =  int(obj331.prep)

        recoveryinfo = caseinfo.copy()
         
        #get fault node info
        if caseinfo:

            if len(caseinfo.keys()) > 1:
                ipport = list(caseinfo.keys())[1]
            else:
                return (None,"remote room single instance")
            #get_status(ipport)
            ret = get_status(ipport)
            if ret == None:
                write_logger(logfile).debug("check cluster status success")
            elif ret:
                write_logger(logfile).error("exec failed node info %s"%str(ret))
            else:
                write_logger(logfile).info("all  node info success")
            ckptret = common.check_ckpt(ipport)
            if ckptret[0] == "running":
                write_logger(logfile).info("get ckpt status success %s"%str(ckptret))
            else:
                write_logger(logfile).info("get ckpt status failed errmsg: %s"%str(ckptret))
                return (None,"get ckpt status failed")
        else:
            ipport = None
            return (None,)


        if fault == 1:
            #exec tpcc run
            p = obj331.exec_tpcc_business()
            if fn:
                ret8 = common.monitor_tpcc_runtime(p,fn=fn,ipport=ipport)
                if ret8 == True:
                    pass
                elif ret8 == None:
                    return (None,)
                else:
                    return ("1",ret8)
            else:
                ret9 = common.monitor_tpcc_runtime(p,fn="test.csv",ipport=ipport)
                if ret9 == True:
                    pass
                elif ret9 == None:
                    return (None,)
                else:
                    return ("1",ret9)

        elif fault == 2:
            pass

        #stop cmd
        stopthreads = []
        for key,value in allinfo.items():
            ip = key.split(":")[0]
            port = key.split(":")[1]
            stopthreads.append(Teststop(ip,port))
        
        for stopthread in stopthreads:
            stopthread.start()

        for stopthread in stopthreads:
            stopthread.join()

        time.sleep(10)


        #get ckpt ts requre recovery node
        tmpinfo={}
        if flag:
            if not check:
                st = exec_apply_layout(caseinfo,flag)
            elif isinstance(check,tuple):
                st = exec_apply_layout(caseinfo,flag,check)
            else:
                st = exec_apply_layout(caseinfo,flag)

            if st == None:
                write_logger(logfile).error("apply-layout failed detail description please chech regression.log!!")
                sys.exit()
            else:
                for j in st:
                    for key,value in caseinfo.items():
                        if value[3] == j[1]:
                            if key.startswith(j[0]):
                                tmpinfo[key]=value
        else:
            write_logger(logfile).error("please correct room info for recovery!!")
            sys.exit()


        if tmpinfo:
            for key in tmpinfo:
                caseinfo.pop(key)
        else:
            write_logger(logfile).error("exec room offline recovery failed,errmsg: all recovery instances not record ckpt timestamp")
            return (None,)

        if caseinfo:
            delinfo.update(caseinfo)
        
        #staortup cmd
        startthreads = []
        for key,value in tmpinfo.items():
            ip = key.split(":")[0]
            cmd = value[1]
            startthreads.append(Test(cmd,ip,rmt.exec_cmd))
            
        for startthread in startthreads:
            startthread.start()

        for startthread in startthreads:
            startthread.join()

        time.sleep(10)
        faultipport = ipport
        ipport = list(tmpinfo.keys())[0]
        nodeidlst = ""
        for key,value in delinfo.items():
            nodeidlst = nodeidlst +str(value[2])+" "
        
        try:
            ret = get_status(ipport)
            if ret == None:
                write_logger(logfile).debug("check cluster status success")
                return (None,)
            elif ret:
                write_logger(logfile).error("exec failed node info %s"%str(ret))
        except Exception as e:
                return (None,)
                write_logger(logfile).error("exec failed node info %s"%e)
        #common.decommission_node(ipport,nodeidlst)
        #exec decommission sql
        exec_replicas_sql(ipport,flag)
        retcheck = common.check_replicas(reps=reps,ipport=ipport)
        if retcheck == None:
            return ("repck_rc",)
        return (True,tmpinfo,delinfo,faultipport)


    except Exception as e:
        write_logger(logfile).error("exec room offline recovery failed,errmsg:%s"%e)
        return (None,)

# flag = 1 rid=1  flag=2 rid=2 flag=3 rid=3 flag=4 rid=2 and rid=3 for multi_goback
#@pysnooper.snoop("/home/cxm/qianbase-xtp-test/multi_thread.log")
def multi_thread_goback(info,flag,fault=None,fn=None,check=None):
    try:
        #dict info key = ipport values list 0 locality info list 1 startup param  string  2 node_id string 3 sore string
        #all romm info
        #if not type(info) is tuple:
        #    write_logger(logfile).error("get all room info failed errmsg：\n%s\n exit testcase"%info)
        #    assert 1 == 0
        #    return None
        #else:
        #    write_logger(logfile).debug("get all room info success msg:\n%s"%info)
        rid1info = info[0]
        # local back room info
        rid2info = info[1]
        # remote back inof
        rid3info = info[2]
        #all back info
        rid4info=info[1].copy()
        rid4info.update(rid3info)
        # primary and local back room
        rid5info=info[1].copy()
        rid5info.update(rid1info)
        #primary and remote back room info
        rid6info = info[0].copy()
        rid6info.update(rid3info)

        #qianbase all instance info
        allinfo = info[0].copy()
        allinfo.update(rid4info) 


        #check all node record ckpt ts
        check_record_ts(allinfo)


        #all back room for recovery
        if flag == 4:
            caseinfo = rid4info
            delinfo = rid1info
            reps = int(obj331.brep) + int(obj331.rrep)
        #remote back room for recovery
        elif flag == 3:
            caseinfo = rid3info
            delinfo = rid5info
            reps = int(obj331.rrep)
        #local back room for recovery
        elif flag == 2:
            caseinfo = rid2info
            delinfo = rid6info
            reps = int(obj331.brep) 
        #primary room for recovery
        else:
            caseinfo = rid1info
            delinfo = rid4info
            reps =  int(obj331.prep)

        recoveryinfo = caseinfo.copy()
         


        #get ckpt ts requre recovery node
        tmpinfo={}
        if flag:
            write_logger(logfile).info("exec recovery node info %s"%str(caseinfo))
            if not check:
                st = exec_apply_layout(caseinfo,flag)
            elif isinstance(check,tuple):
                st = exec_apply_layout(caseinfo,flag,check)
            else:
                st = exec_apply_layout(caseinfo,flag)

            if st == None:
                write_logger(logfile).error("apply-layout failed detail description please chech regression.log!!")
                sys.exit()
            else:
                for j in st:
                    for key,value in caseinfo.items():
                        if value[3] == j[1]:
                            if key.startswith(j[0]):
                                tmpinfo[key]=value
        else:
            write_logger(logfile).error("please correct room info for recovery!!")
            sys.exit()


        if tmpinfo:
            for key in tmpinfo:
                caseinfo.pop(key)
        else:
            write_logger(logfile).error("exec room offline recovery failed,errmsg: all recovery instances not record ckpt timestamp")
            return (None,)

        if caseinfo:
            delinfo.update(caseinfo)
        
        #staortup cmd
        startthreads = []
        for key,value in tmpinfo.items():
            ip = key.split(":")[0]
            cmd = value[1]
            startthreads.append(Test(cmd,ip,rmt.exec_cmd))
            
        for startthread in startthreads:
            startthread.start()

        for startthread in startthreads:
            startthread.join()

        time.sleep(10)
        ipport = list(tmpinfo.keys())[0]
        nodeidlst = ""
        for key,value in delinfo.items():
            nodeidlst = nodeidlst +str(value[2])+" "
        
        try:
            ret = get_status(ipport)
            if ret == None:
                write_logger(logfile).debug("check cluster status success")
                return (None,)
            elif ret:
                write_logger(logfile).error("exec failed node info %s"%str(ret))
        except Exception as e:
                return (None,)
                write_logger(logfile).error("exec failed node info %s"%e)
        #common.decommission_node(ipport,nodeidlst)
        #exec decommission sql
        exec_replicas_sql(ipport,flag)
        retcheck = common.check_replicas(reps=reps,ipport=ipport)
        if retcheck == None:
            return ("repck_rc",)
        return (True,tmpinfo,delinfo)


    except Exception as e:
        write_logger(logfile).error("exec room offline recovery failed,errmsg:%s"%e)
        return (None,)

# flag = 1 rid=1  flag=2 rid=2 flag=3 rid=3 flag=4 rid=2 and rid=3
# operation room info
#@pysnooper.snoop("/home/cxm/qianbase-xtp-test/multi_thread_2.log")
def multi_thread_2(info,flag,fault=None,fn=None):
    try:
        #dict info key = ipport values list 0 locality info list 1 startup param  string  2 node_id string 3 sore string
        #all romm info
        #if not type(info) is tuple:
        #    write_logger(logfile).error("get all room info failed errmsg：\n%s\n exit testcase"%info)
        #    assert 1 == 0
        #    return None
        #else:
        #    write_logger(logfile).debug("get all room info success msg:\n%s"%info)
        rid1info = info[0]
        # local back room info
        rid2info = info[1]
        print(rid2info)
        # remote back inof
        rid3info = info[2]
        #all back info
        rid4info=info[1].copy()
        rid4info.update(rid3info)
        # primary and local back room
        rid5info=info[1].copy()
        rid5info.update(rid1info)
        #primary and remote back room info
        rid6info = info[0].copy()
        rid6info.update(rid3info)

        #qianbase all instance info
        allinfo = info[0].copy()
        allinfo.update(rid4info) 
        

        check_record_ts(allinfo)


        #all back room for recovery
        if flag == 4:
            caseinfo = rid4info
            delinfo = rid1info
            reps = int(obj331.brep) + int(obj331.rrep)
        #remote back room for recovery
        elif flag == 3:
            caseinfo = rid3info
            delinfo = rid5info
            reps = int(obj331.rrep)
        #local back room for recovery
        elif flag == 2:
            caseinfo = rid2info
            delinfo = rid6info
            reps = int(obj331.brep) 
        #primary room for recovery
        else:
            caseinfo = rid1info
            delinfo = rid4info
            reps =  int(obj331.prep)

        recoveryinfo = caseinfo.copy()
         
        #get fault node info
        if caseinfo:
            if len(caseinfo.keys()) > 1:
                ipport = list(caseinfo.keys())[1]
                val = caseinfo.pop(ipport)
                delinfo[ipport] = val
            else:
                write_logger(logfile).error("remote room is only single instance")
                return (None,"remote room single instance")
            #get_status(ipport)
            ret = get_status(ipport)
            if ret == None:
                write_logger(logfile).debug("check cluster every instance status failed")
                return (None,)
            elif ret:
                write_logger(logfile).error("exec failed node info %s"%str(ret))
                return (None,"fault node %s"%str(ret))
            else:
                write_logger(logfile).info("all  node info success")
            ckptret = common.check_ckpt(ipport)
            if ckptret == None:
                write_logger(logfile).error("get ckpt status failed")
                return (None,)
            elif ckptret[0] == "running":
                write_logger(logfile).info("get ckpt status success %s"%str(ckptret))
            else:
                write_logger(logfile).info("get ckpt status failed errmsg: %s"%str(ckptret))
                return (None,)
        else:
            ipport = None
            write_logger(logfile).error("get normal recovery room info failed")
            return (None,)


        if fault == 1:
            #exec tpcc run
            p = obj331.exec_tpcc_business()
            if fn:
                ret8 = common.monitor_tpcc_runtime(p,fn=fn,ipport=ipport)
                if ret8 == True:
                    pass
                elif ret8 == None:
                    write_logger(logfile).error("exec tpcc workload business failed")
                    return (None,)
                else:
                    write_logger(logfile).error("exec tpcc workload business fault failed %s"%ret8[1])
                    return ("1",ret8[1])
                write_logger(logfile).debug("exec tpcc workload business success")
            else:
                ret9 = common.monitor_tpcc_runtime(p,fn="test.csv",ipport=ipport)
                if ret9 == True:
                    pass
                elif ret9 == None:
                    return (None,)
                else:
                    return ("1",ret9)
                write_logger(logfile).debug("exec tpcc workload business success")

        elif fault == 2:
            pass

        #stop cmd
        stopthreads = []
        for key,value in allinfo.items():
            ip = key.split(":")[0]
            port = key.split(":")[1]
            stopthreads.append(Teststop(ip,port))
        
        for stopthread in stopthreads:
            stopthread.start()

        for stopthread in stopthreads:
            stopthread.join()

        time.sleep(10)


        #get ckpt ts requre recovery node
        tmpinfo={}
        if flag:
            st = exec_apply_layout(caseinfo,flag)
            if st == None:
                write_logger(logfile).error("apply-layout failed detail description please chech regression.log!!")
                sys.exit()
            else:
                for j in st:
                    for key,value in caseinfo.items():
                        if value[3] == j[1]:
                            if key.startswith(j[0]):
                                tmpinfo[key]=value
        else:
            write_logger(logfile).error("please correct room info for recovery!!")
            sys.exit()


        if tmpinfo:
            for key in tmpinfo:
                caseinfo.pop(key)
        else:
            write_logger(logfile).error("exec room offline recovery failed,errmsg: all recovery instances not record ckpt timestamp")
            return (None,)

        if caseinfo:
            delinfo.update(caseinfo)
        
        #staortup cmd
        startthreads = []
        for key,value in tmpinfo.items():
            ip = key.split(":")[0]
            cmd = value[1]
            startthreads.append(Test(cmd,ip,rmt.exec_cmd))
            
        for startthread in startthreads:
            startthread.start()

        for startthread in startthreads:
            startthread.join()

        time.sleep(10)
        ipport = list(tmpinfo.keys())[0]
        nodeidlst = ""
        for key,value in delinfo.items():
            nodeidlst = nodeidlst +str(value[2])+" "
        
        ret = get_status(ipport)
        if ret == None:
            write_logger(logfile).debug("check cluster every instance status success")
            return (None,)
        elif ret:
            write_logger(logfile).error("exec failed node info %s"%str(ret))
        #common.decommission_node(ipport,nodeidlst)
        #exec decommission sql
        exec_replicas_sql(ipport,flag)
        retcheck = common.check_replicas(reps=reps,ipport=ipport)
        if retcheck == None:
            return ("repck_rc",)
        return (True,tmpinfo,delinfo)

    except Exception as e:
        write_logger(logfile).error("exec room offline recovery failed,errmsg:%s"%e)
        return (None,)
if __name__ == '__main__':
    test_args = common.test_args()
    multi_thread(test_args,2)

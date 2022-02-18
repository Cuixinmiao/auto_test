# -*- coding:utf8 -*-
#date 2021-09-14
#copyright  esgyn
#author cxm
#!/usr/bin/python
import os
import sys
import pexpect
import configparser
import re
import psycopg2
import subprocess
import time
import pytest
#import pysnooper
from factory import sshapp
from factory import rmt
from factory.collect import *
from factory.conf import *
from factory.dbconn import Conn
from factory import set_iptables

""""general 证书的相关操作"""
typeinfo = os.environ.get("typeinfo")
if typeinfo == None:
    print("%s get typeinfo failed"%__file__)
    sys.exit()
basepath=os.getcwd()
toolstmppath = os.path.join(basepath,"tools")
toolspath = os.path.join(toolstmppath,typeinfo)
confpath = os.path.join(basepath,"conf")
configinfo = os.path.join(confpath,"config%s.txt"%typeinfo)
config = configparser.ConfigParser()
config.read(configinfo)
securemod = config.get(typeinfo,"securemod").strip()
replicas = config.get(typeinfo,"replicas").strip()
init_ip = config.get(typeinfo,"init_ip").strip()
init_port = config.get(typeinfo,"init_port").strip()
ip_num = config.get(typeinfo,"advertise-addr").split(",")

if typeinfo == "ha331":
    chaosblade = "chaosblade_"+config.get(typeinfo,"chaosblade").strip()
    chaosbladepath = os.path.join(toolstmppath,chaosblade)
    remotechaospath = "/etc"
    chaosbin = os.path.join("%s/%s"%(remotechaospath,chaosblade),"blade")
    ethname = config.get(typeinfo,"ethname").strip()


user = config.get(typeinfo,"user").strip()
password = config.get(typeinfo,"password").strip()
sshport = config.get(typeinfo,"sshport").strip()

basecerts = config.get("certs","basecerts").strip()
certs = config.get("certs","certs").strip()
certsdir = os.path.join(basecerts,certs)
if securemod == "secure":
    securemod = "certs-dir=%s"%certsdir
mysafe = config.get("certs","mysafedir").strip()
mysafedir = os.path.join(basecerts,mysafe)
usercerts = config.get("certs","usercerts").strip()
clientip = config.get("certs","clientip").strip()
binname = config.get(typeinfo,"binname").strip()
bindir = config.get(typeinfo,"bindir").strip()
serverbin = os.path.join(toolspath,"%s"%binname)
gm = None
try:
    gm = config.get("certs","gm").strip()
except:
    pass
gen_cs_cert = "%s cert create-ca --certs-dir=%s --ca-key=%s/ca.key"%(serverbin,certsdir,mysafedir)
gen_node_cert = serverbin + "  cert create-node 0.0.0.0 {0} localhost " + clientip  + " {0} 127.0.0.1 --certs-dir="+ certsdir + " --ca-key=" + mysafedir+"/ca.key"
gen_lic = serverbin + " cert create-client " + usercerts + " --certs-dir=%s --ca-key=%s/ca.key"%(certsdir,mysafedir)
if gm == 'gm':
    gen_cs_cert += " --%s" % gm
    gen_node_cert += " --%s" % gm
    gen_lic += " --%s" % gm
    write_logger(logfile).info("gen_cs_cert:{0},gen_node_cert: {1},gen_lic:{2}".format(gen_cs_cert,gen_node_cert,gen_lic))


clibin = os.path.join(toolstmppath,"qianbase_cli")
if not os.path.exists(clibin):
    clibin = serverbin




"""set clusterid license and set ckpt tpcc workload tools sql"""
licsql = "'select dbms_internal.cluster_id();'"
if binname == "cockroach":
    licsql = "'select crdb_internal.cluster_id();'"

presql = "%s/%s  sql --%s "%(bindir,binname,securemod) + " --host=%s:%s "%(init_ip,init_port) + " -e "
preclisql = "%s/%s  sql --%s "%(clibin,binname,securemod) + " --host=%s:%s "%(init_ip,init_port) + " -e "
presqlfile =  "%s/%s sql --%s "%(bindir,binname,securemod) + " --host=%s:%s -f /tmp/%s"
cmd = presql + licsql
registerlic = 'set cluster setting enterprise.license="%s";'
tpccworkload = "%s workload init tpcc --drop "%clibin +  "--warehouses=%s  --data-loader IMPORT  'qianbase://root@%s:%s?sslmode=disable'"
tpccworkload_run = "%s workload run tpcc "%clibin +  "--warehouses={0}  --workers={1} --tolerate-errors  'qianbase://root@%s:%s?sslmode=disable'"
if securemod != "insecure":
    tpccworkload = "%s workload init tpcc "%clibin + " --drop --warehouses={0}  --data-loader IMPORT " + \
            "'qianbase://root@{1}:{2}?" + "sslcert={0}%2Fcerts%2Fclient.root.crt&sslkey={0}%2Fcerts%2Fclient.root.key&sslmode=verify-full&sslrootcert={1}%2Fca.crt'".format(basecerts,certsdir)
    tpccworkload_run = "%s workload run tpcc "%clibin + " --warehouses={0} --workers={1} --tolerate-errors --wait=false --duration={2}m " + \
        "'qianbase://root@{3}:{4}?" + "sslcert={0}%2Fcerts%2Fclient.root.crt&sslkey={0}%2Fcerts%2Fclient.root.key&sslmode=verify-full&sslrootcert={1}%2Fca.crt'".format(basecerts,certsdir)
    if binname == "cockroach":
        tpccworkload = "%s workload init tpcc "%clibin + " --drop --warehouses={0}  --data-loader IMPORT " + \
                "'postgres://root@{1}:{2}?" + "sslcert={0}%2Fcerts%2Fclient.root.crt&sslkey={0}%2Fcerts%2Fclient.root.key&sslmode=verify-full&sslrootcert={1}%2Fca.crt'".format(basecerts,certsdir)
        tpccworkload_run = "%s workload run tpcc "%clibin + " --warehouses={0} --workers={1} --tolerate-errors --wait=false --duration={2}m " + \
                "'postgres://root@{3}:{4}?" + "sslcert={0}%2Fcerts%2Fclient.root.crt&sslkey={0}%2Fcerts%2Fclient.root.key&sslmode=verify-full&sslrootcert={1}%2Fca.crt'".format(basecerts,certsdir)


"""检测副本数的cmd"""

checkreplicas = "%s sql --%s --host=%s:%s -e "%(clibin,securemod,init_ip,init_port)  + " 'select replicas,table_name,database_name from dbms_internal.ranges ;'" + "|" + "grep '{' " + "|" + "awk -F, 'NF<" + replicas + "{print $0,NF}'"  
if binname == "cockroach":
    checkreplicas = "%s sql --%s --host=%s:%s -e "%(clibin,securemod,init_ip,init_port) + " 'select replicas,table_name,database_name from crdb_internal.ranges ;'" + "|" + "grep '{' " + "|" + "awk -F, 'NF<" + replicas + "{print $0,NF}'"  


membership =  presql + '"select membership from dbms_internal.gossip_liveness where node_id in ({0});"'
#get gen license's key and Register xtp 
def get_license():
    try:
        clusterid = get_clusterid(lic=True)
        if clusterid:
            ret = sshapp.cmd("/root/license gen -y 1 %s"%clusterid,host="10.16.30.130",password="esgyndb")
            #ret = sshapp.cmd("/home/cxm/qianbase-xtp-test/tools/license gen -y 1 %s"%clusterid,host="10.14.41.183",password="esgyndb")
            clusterid=str(ret,encoding='utf-8').strip()
            write_logger(logfile).debug("Get clusterid success cluster_id : %s "%clusterid)
            lics = presql + "'%s'"%(registerlic%clusterid)
            ret1 = get_clusterid(lics)
            if ret1:
                write_logger(logfile).info("Register license success sql %s"%lics)
                return True
            else:
                write_logger(logfile).info("Register license failed sql %s"%lics)
                return None
        else:
            write_logger(logfile).error("Get clusterid failed ")
            return None
    except Exception as e:
        write_logger(logfile).error("Register license failed errmsg:%s"%e)
        return None

#检测副本数的机制超时时间为60s
def check_replicas(reps=None,ipport=None,timeout=60):
    i=0
    if reps:
        checkreplicas = "%s/%s sql --%s --host=%s -e "%(toolspath,binname,securemod,ipport)  + " 'select replicas,table_name,database_name,range_id from dbms_internal.ranges ;'" + "|" + "grep '{' " + "|" + "awk -F, 'NF<" + str(reps) + "{print $0  ,NF}'"
        if binname == "cockroach":
            checkreplicas = "%s/%s sql --%s --host=%s -e "%(toolspath,binname,securemod,ipport)  + " 'select replicas,table_name,database_name,range_id from crdb_internal.ranges ;'" + "|" + "grep '{' " + "|" + "awk -F, 'NF<" + str(reps) + "{prin  t $0,NF}'"
    else:
        checkreplicas = "%s sql --%s --host=%s:%s -e "%(clibin,securemod,init_ip,init_port)  + " 'select replicas,table_name,database_name,range_id from dbms_internal.ranges ;'" + "|" + "grep '{' " + "|" + "awk -F, 'NF<" + replicas + "{print $0,NF}'"  
        if binname == "cockroach":
            checkreplicas = "%s sql --%s --host=%s:%s -e "%(clibin,securemod,init_ip,init_port) + " 'select replicas,table_name,database_name,range_id from crdb_internal.ranges ;'" + "|" + "grep '{' " + "|" + "awk -F, 'NF<" + replicas + "{print $0,NF}'"  
    write_logger(logfile).info("check replicas sqlcmd is %s"%checkreplicas)
    while True:
        ret = subprocess.getstatusoutput(checkreplicas)
        if ret[0] == 0:
            if not ret[1]:
                return True
            elif "error" in ret[1].lower():
                write_logger(logfile).error("check replicas cmd is error %s"%ret[1])
                return None
            else:
                write_logger(logfile).debug("system table sync is doing \n%s"%ret[1])
                write_logger(logfile).debug("check qianbase system table replicas cost %d s,and continue check"%(i*5))

        else:
            write_logger(logfile).error("check replicas cmd is error %s"%checkreplicas)
            return None
        if  i > timeout:
            write_logger(logfile).error("check replicas timeout time is %d s"%(i*5))
            return None
        time.sleep(5)
        i=i+1
#检测副本数的机制超时时间为60s
def check_replicas_expansion(reps=None,ipport=None,timeout=60):
    i=0
    if reps:
        checkreplicas = "%s/%s sql --%s --host=%s -e "%(toolspath,binname,securemod,ipport)  + " 'select replicas,table_name,database_name,range_id from dbms_internal.ranges ;'" + "|" + "grep '{' " + "|" + "awk -F, 'NF!=" + str(reps) + "{print $0  ,NF}'"
        if binname == "cockroach":
            checkreplicas = "%s/%s sql --%s --host=%s -e "%(toolspath,binname,securemod,ipport)  + " 'select replicas,table_name,database_name,range_id from crdb_internal.ranges ;'" + "|" + "grep '{' " + "|" + "awk -F, 'NF!=" + str(reps) + "{prin  t $0,NF}'"
    else:
        checkreplicas = "%s sql --%s --host=%s:%s -e "%(clibin,securemod,init_ip,init_port)  + " 'select replicas,table_name,database_name,range_id from dbms_internal.ranges ;'" + "|" + "grep '{' " + "|" + "awk -F, 'NF!=" + replicas + "{print $0,NF}'"  
        if binname == "cockroach":
            checkreplicas = "%s sql --%s --host=%s:%s -e "%(clibin,securemod,init_ip,init_port) + " 'select replicas,table_name,database_name,range_id from crdb_internal.ranges ;'" + "|" + "grep '{' " + "|" + "awk -F, 'NF!=" + replicas + "{print $0,NF}'"  
    write_logger(logfile).info("check replicas sqlcmd is %s"%checkreplicas)
    while True:
        ret = subprocess.getstatusoutput(checkreplicas)
        if ret[0] == 0:
            if not ret[1]:
                return True
            elif "error" in ret[1].lower():
                write_logger(logfile).error("check replicas cmd is error %s"%ret[1])
                return None
            else:
                write_logger(logfile).debug("system table sync is doing \n%s"%ret[1])
                write_logger(logfile).debug("check qianbase system table replicas cost %d s,and continue check"%(i*5))

        else:
            write_logger(logfile).error("check replicas cmd is error %s"%checkreplicas)
            return None
        if  i > timeout:
            write_logger(logfile).error("check replicas timeout time is %d s"%(i*5))
            return None
        time.sleep(5)
        i=i+1


#check ckpt status info
#@pysnooper.snoop("/home/cxm/qianbase-xtp-test/check_ckpt.log")
def check_ckpt(ipport):
    try:
        checksql = "select status,modified,error from dbms_internal.jobs where job_type = 'CHECKPOINT' order by job_id ASC limit 1"
        if binname == "cockroach":
            checksql = "select status,modified,error from crdb_internal.jobs where job_type = 'CHECKPOINT' order by job_id ASC limit 1"
        
        ##sql exec cmd
        sqlcmd = "%s/%s"%(toolspath,binname) +  " sql --" + securemod + " --host=" + ipport + " -e " + '"'+checksql+'"'
        statinfo = subprocess.getstatusoutput(sqlcmd)
        if statinfo[0] == 0:
            retinfo = statinfo[1].split("\n")
            for line in retinfo:
                if not line.strip().startswith("status"):
                    stat = line.split("\t")[0]
                    modified = line.split("\t")[1]
                    errorinfo  = line.split("\t")[2]
                    return (stat,modified,errorinfo)
            return (None,)
        else:
            write_logger(logfile).error("exec sql %s errmsg:%s"%(sqlcmd,statinfo[1]))
            return (None,)
    except Exception as e:
        write_logger(logfile).error("common.check_ckpt method failed errmsg:%s "%e)
        return (None,)

# exec local sql's method
def get_clusterid(sql=cmd,lic=False):
    ret = subprocess.getstatusoutput(sql)
    if ret[0] == 0:
        if lic:
            clusterid =ret[1].split("\n")[1] 
            return clusterid
        else:
            return True
    else:
        return None

#exec local sql file method
def exec_sql_file(host,serverport,sqlfile):
    #get sql filename
    sqlname = os.path.basename(sqlfile)
    try:
        #cp local sql file to remtoe server
        sshapp.upload(sqlfile,"/tmp/%s"%sqlname,host)
        write_logger(logfile).debug("cp local sql file  %s to remote server %s success"%(sqlfile,host))
    except Exception as e:
        write_logger(logfile).error("cp local sql file %s to remote server %s failed errmsg %s"%(sqlfile,host,e))
        return None

    #exec cp remote sql file 
    try:
        cmd = presqlfile%(host,serverport,sqlname)
        sshapp.cmd(cmd,host)
        write_logger(logfile).debug("exec remote sql file  /tmp/%s success "%sqlname)
        return True
    except Exception as e:
        write_logger(logfile).error("exec remote sql file /tmp/%s failed errmsg %s"%(sqlname,e))
        return None

# exec tpcc workload get load fd
def exec_tpcc_load(host,serverport,amount,timeout=300):
    try:
        cmd = tpccworkload.format(amount,host,serverport)
        print(cmd)
        p = subprocess.Popen(cmd,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,encoding="utf-8")
        write_logger(logfile).info("exec tpcc workload data start")
        return p
    except Exception as e:
        write_logger(logfile).error("get tpcc_workload fd failed errmsg:%s"%e)
        return None


# exec tpcc workload 
def exec_tpcc_workload(host,serverport,amount,timeout=300):
    cmd = tpccworkload.format(amount,host,serverport)
    p = subprocess.Popen(cmd,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,encoding="utf-8")
    write_logger(logfile).info("exec tpcc workload data start")
    retrytimes=1
    while True:
        if retrytimes > timeout:
            p.kill()
            write_logger(logfile).error("exec tpcc workload data failed timeout %s s"%timeout)
            res = p.communicate()[1]
            write_logger(logfile).error("exec tpcc workload data errmsg %s"%res)
            return (False,res)
        if p.poll() == 0:
            write_logger(logfile).debug("exec tpcc workload data success")
            ret = p.communicate()[1].split("\n")
            write_logger(logfile).debug("%s exec res start"%cmd)
            for line in ret:
                write_logger(logfile).info("exec tpcc workload res %s"%line)
            write_logger(logfile).info("%s exec res end"%cmd)
            return (True,"")
        time.sleep(1)
        retrytimes = retrytimes + 1
        #line = str(p.stdout.readline(),encoding='utf-8')
        #if line:
        #    write_logger(logfile).info("exec tpcc workload data %s"%line)
    write_logger(logfile).info("exec tpcc workload data end")

#exec tpcc tpmc cmd
def exec_tpcc_business(host,serverport,amount,worker,duration):
    try:
        cmd = tpccworkload_run.format(amount,worker,duration,host,serverport)
        p = subprocess.Popen(cmd,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        return p
    except Exception as e:
        write_logger(logfile).info("get tpcc_business fd failed errmsg:%s"%e)
        return None

    


#monitor tpcc workload run result
def monitor_tpcc_res(p,step=12,fn=None):
    try:
        sum1=0
        if fn:
            if os.path.exists("%s.csv"%fn):
                os.remove("%s.csv"%fn)
            write_logger(logfile).info("filename : %s.csv"%fn)
            with open("%s.csv"%fn,"a+") as f:
                f.write("%s,%s\n"%("interval","tps"))
        step=int(step)
        start=1
        j=0
        m=0
        delayduration=0
        tmpsum1=0
        tmpcount=1
        timeout=300
        t=1
        write_logger(logfile).debug("tpcc run res output start")
        while True:
            if p.poll() == 0:
                stdout,stderr = p.communicate()
                #assert "error" not in  str(stderr,encoding='utf-8').lower() == True and "sqlstat" not in  str(stderr,encoding='utf-8').lower() == True,"errmsg :%s"%str(stderr,encoding='utf-8')
                write_logger(logfile).debug("tpcc run res output end")
                return True
            if p.poll() is None:
                line = str(p.stdout.readline(),encoding='utf-8').strip()
                write_logger(logfile).debug(line)
                if re.match("^([1-9][0-9]*)+(.0)",line):
                    lstcount = line.split()
                    timecount = int(lstcount[0].split(".")[0])
                    if timecount == tmpcount:
                        tmpsum1 = tmpsum1 + int(lstcount[2].split(".")[0])
                        m=m+1
                        if m == 5:
                            if fn:
                                with open("%s.csv"%fn,"a+") as f:
                                    f.write("%s,%s\n"%(tmpcount,tmpsum1))
                            tmpsum1=0
                            m=0
                            tmpcount=tmpcount+1
                    if delayduration >=3:
                        p.kill()
                        stdout,stderr = p.communicate()
                        #assert delayduration == 0,"delayduration great than 24s \n errmsg:%s"%str(stderr,encoding='utf-8')
                        write_logger(logfile).debug("tpcc run res output end")
                        return (delayduration,str(stderr,encoding='utf-8'))
                    if timecount == start:
                        sum1 = sum1 + int(lstcount[2].split(".")[0])
                        j=j+1
                        if j == 5:
                            if sum1 <= 10:
                                delayduration = delayduration + 1
                    elif timecount - start == step:
                        sum1 = sum1 + int(lstcount[2].split(".")[0])
                        j=j+1
                        if j == 5:
                            start = timecount
                            if sum1 <= 10:
                                delayduration = delayduration + 1
                    else:
                        j=0
                        sum1=0
                else:
                    if t > timeout:
                        return True
                        break
                    time.sleep(1)
                    t = t + 1
    except Exception as e:
        write_logger(logfile).error("exec tpcc business failed errmsg:%s"%e)


#monitor tpcc workload run result and run time fault 
def monitor_tpcc_runtime(p,step=12,runtime=30,killtype="kill -9",fn=None,ipport=None):
    try:
        sum1=0
        if fn:
            if os.path.exists("%s.csv"%fn):
                os.remove("%s.csv"%fn)
            write_logger(logfile).info("filename : %s.csv"%fn)
            with open("%s.csv"%fn,"a+") as f:
                f.write("%s,%s\n"%("interval","tps"))
        step=int(step)
        start=1
        j=0
        m=0
        delayduration=0
        tmpsum1=0
        tmpcount=1
        timeout=300
        t=1
        write_logger(logfile).debug("tpcc run res output start")
        while True:
            if p.poll() == 0:
                stdout,stderr = p.communicate()
                #assert "error" not in  str(stderr,encoding='utf-8').lower() == True and "sqlstat" not in  str(stderr,encoding='utf-8').lower() == True,"errmsg :%s"%str(stderr,encoding='utf-8')
                write_logger(logfile).debug("tpcc run res output end")
                return True
            if p.poll() is None:
                line = str(p.stdout.readline(),encoding='utf-8').strip()
                write_logger(logfile).debug(line)
                if re.match("^([1-9][0-9]*)+(.0)",line):
                    lstcount = line.split()
                    timecount = int(lstcount[0].split(".")[0])
                    if timecount == tmpcount:
                        tmpsum1 = tmpsum1 + int(lstcount[2].split(".")[0])
                        m=m+1
                        if m == 5:
                            if fn:
                                with open("%s.csv"%fn,"a+") as f:
                                    f.write("%s,%s\n"%(tmpcount,tmpsum1))
                            tmpsum1=0
                            m=0
                            tmpcount=tmpcount+1
                    if timecount == runtime:
                        runtime = runtime - 1
                        if ipport:
                            ip = ipport.split(":")[0]
                            port = ipport.split(":")[1]
                            stop(ip,port,killtype=killtype)
                    if delayduration >=3:
                        p.kill()
                        stdout,stderr = p.communicate()
                        #assert delayduration == 0,"delayduration great than 24s \n errmsg:%s"%str(stderr,encoding='utf-8')
                        write_logger(logfile).debug("tpcc run res output end")
                        return (delayduration,str(stderr,encoding='utf-8'))
                    if timecount == start:
                        sum1 = sum1 + int(lstcount[2].split(".")[0])
                        j=j+1
                        if j == 5:
                            if sum1 <= 10:
                                delayduration = delayduration + 1
                    elif timecount - start == step:
                        sum1 = sum1 + int(lstcount[2].split(".")[0])
                        j=j+1
                        if j == 5:
                            start = timecount
                            if sum1 <= 10:
                                delayduration = delayduration + 1
                    else:
                        j=0
                        sum1=0
                else:
                    if t > timeout:
                        return True
                        break
                    time.sleep(1)
                    t = t + 1

    except Exception as e:
        write_logger(logfile).error("exec tpcc business failede errmsg:%s"%e)

#monitor tpcc workload run result and run time fault network partition 
def monitor_tpcc_runtime_netpatition(p,ipinfo,instip,step=12,runtime=30,fn=None,flag=None):
    try:
        sum1=0
        if fn:
            if os.path.exists("%s.csv"%fn):
                os.remove("%s.csv"%fn)
            write_logger(logfile).info("filename : %s.csv"%fn)
            with open("%s.csv"%fn,"a+") as f:
                f.write("%s,%s\n"%("interval","tps"))
        step=int(step)
        start=1
        j=0
        m=0
        delayduration=0
        tmpsum1=0
        tmpcount=1
        timeout=300
        ipuuid=None
        t=1
        write_logger(logfile).debug("tpcc run res output start")
        while True:
            if p.poll() == 0:
                stdout,stderr = p.communicate()
                #assert "error" not in  str(stderr,encoding='utf-8').lower() == True and "sqlstat" not in  str(stderr,encoding='utf-8').lower() == True,"errmsg :%s"%str(stderr,encoding='utf-8')
                write_logger(logfile).debug("tpcc run res output end")
                return True
            if p.poll() is None:
                line = str(p.stdout.readline(),encoding='utf-8').strip()
                write_logger(logfile).debug(line)
                if re.match("^([1-9][0-9]*)+(.0)",line):
                    lstcount = line.split()
                    timecount = int(lstcount[0].split(".")[0])
                    if timecount == tmpcount:
                        tmpsum1 = tmpsum1 + int(lstcount[2].split(".")[0])
                        m=m+1
                        if m == 5:
                            if fn:
                                with open("%s.csv"%fn,"a+") as f:
                                    f.write("%s,%s\n"%(tmpcount,tmpsum1))
                            tmpsum1=0
                            m=0
                            tmpcount=tmpcount+1
                    if timecount == runtime:
                        runtime = runtime-1
                        if flag=="reject":
                            for ip in ipinfo:
                                write_logger(logfile).info("ip:%s,lst:%s"%(str(ip),str(instip)))
                                set_iptables.set_iptables_reject_policy(ip,instip)
                        elif flag=="blade":
                            ipuuid = setting_loss(ipinfo,instip)
                        else:
                            for ip in ipinfo:
                                write_logger(logfile).info("ip:%s,lst:%s"%(str(ip),str(instip)))
                                set_iptables.set_iptables_policy(ip,instip)
                    if delayduration >=3:
                        p.kill()
                        stdout,stderr = p.communicate()
                        #assert delayduration == 0,"delayduration great than 24s \n errmsg:%s"%str(stderr,encoding='utf-8')
                        write_logger(logfile).debug("tpcc run res output end")
                        return (delayduration,str(stderr,encoding='utf-8'))
                    if timecount == start:
                        sum1 = sum1 + int(lstcount[2].split(".")[0])
                        j=j+1
                        if j == 5:
                            if sum1 <= 10:
                                delayduration = delayduration + 1
                    elif timecount - start == step:
                        sum1 = sum1 + int(lstcount[2].split(".")[0])
                        j=j+1
                        if j == 5:
                            start = timecount
                            if sum1 <= 10:
                                delayduration = delayduration + 1
                    else:
                        j=0
                        sum1=0
                else:
                    if t > timeout:
                        return True
                        break
                    time.sleep(1)
                    t = t + 1

    except Exception as e:
        write_logger(logfile).error("exec tpcc business failede errmsg:%s"%e)
    finally:
        if ipuuid:
            for tmp in ipuuid:
                ip = tmp[0]
                uuid = tmp[1]
                destroy_delay(ip,uuid)
        else:
            for ip in ipinfo:
                set_iptables.del_iptables_policy(ip,instip)
#general local client certs
def gen_client_dir():
    try:
        if os.path.exists(certsdir):
            delret = subprocess.getstatusoutput("rm -fr %s"%certsdir)
            if delret[0] == 0:
                write_logger(logfile).debug("del dir %s success "%certsdir)
            else:
                write_logger(logfile).error("del dir %s failed errmsg:%s"%(certsdir,delret[1]))
        ret = subprocess.getstatusoutput("mkdir -p %s"%certsdir)
        if ret[0] == 0:
            write_logger(logfile).debug("create dir %s success"%certsdir)
        else:
            write_logger(logfile).debug("create dir %s failed errmsg: %s"%(certsdir,ret[1]))
            return None
    except Exception as e:
        write_logger(logfile).error("operation dir certsdir %s failed errmsg:%s"%(certsdir,e))
        return None

    try:
        if os.path.exists(mysafedir):
            delret = subprocess.getstatusoutput("rm -fr %s"%mysafedir)
            if delret[0] == 0:
                write_logger(logfile).debug("del dir %s success "%mysafedir)
            else:
                write_logger(logfile).error("del dir %s failed errmsg:%s"%(mysafedir,delret[1]))
        ret = subprocess.getstatusoutput("mkdir -p %s"%mysafedir)
        if ret[0] == 0:
            write_logger(logfile).debug("create dir %s success"%mysafedir)
            return True
        else:
            write_logger(logfile).error("create dir %s failed errmsg: %s"%(mysafedir,ret[1]))
            return None
    except Exception as e:
        write_logger(logfile).error("operation dir certsdir %s failed errmsg:%s"%(mysafedir,e))
        return None

    
#general certs's method
def gen_client():
    if not os.path.exists(serverbin):
        write_logger(logfile).error("please check tools path execbin %s"%serverbin)
        print("please check tools path execbin %s"%serverbin)
        sys.exit()
    ret = gen_client_dir()
    if ret:
        flag = subprocess.getstatusoutput("%s"%gen_cs_cert)
        if flag[0] == 0:
            write_logger(logfile).debug("gen local license success !")
            return True
        else:
            write_logger(logfile).error("gen local license failed !!! errmsg %s"%flag[1])
            return False
    else:
        write_logger(logfile).error("mkdir local dir certs,mysafe failed")
        return None

# general server node.crt,node.key
def gen_server(host):
    try:
        #初始化节点的认证目录
        sshapp.cmd("rm -fr {0};mkdir -p {0};rm -fr {1};mkdir -p {1}".format(certsdir,mysafedir),host)

        #gen server certs
        ret = subprocess.getstatusoutput(gen_node_cert.format(host))
        if ret[0] == 0:
            write_logger(logfile).debug("gen node cert success")
            nodecrt = os.path.join(certsdir,"node.crt")
            nodekey = os.path.join(certsdir,"node.key")
            nodeca = os.path.join(certsdir,"ca.crt")
            rootcrt = os.path.join(certsdir,"client.root.crt")
            rootkey = os.path.join(certsdir,"client.root.key")
            if os.path.exists(nodecrt) and os.path.exists(nodekey) and os.path.exists(nodeca):
                sshapp.cmd("rm -fr %s"%nodecrt,host)
                sshapp.cmd("rm -fr %s"%nodekey,host)
                sshapp.cmd("rm -fr %s"%nodeca,host)
                sshapp.cmd("rm -fr %s"%rootcrt,host)
                sshapp.cmd("rm -fr %s"%rootkey,host)
                retcrt = sshapp.upload(nodecrt,nodecrt,host)
                retkey = sshapp.upload(nodekey,nodekey,host)
                retkey = sshapp.upload(nodeca,nodeca,host)
                retkey = sshapp.upload(rootcrt,rootcrt,host)
                retkey = sshapp.upload(rootkey,rootkey,host)
                sshapp.cmd("chmod 644 %s"%nodecrt,host)
                sshapp.cmd("chmod 644 %s"%rootcrt,host)
                sshapp.cmd("chmod 600 %s"%nodekey,host)
                sshapp.cmd("chmod 600 %s"%rootkey,host)
                sshapp.cmd("chmod 644 %s"%nodeca,host)
                if retcrt and retkey:
                    crtcode = subprocess.getstatusoutput("rm -fr %s"%nodecrt)
                    keycode =  subprocess.getstatusoutput("rm -fr %s"%nodekey)
                    if crtcode[0] == 0 and keycode[0] == 0:
                       write_logger(logfile).info("clear local node crt and key success")
                    else:
                        write_logger(logfile).info("clear local node crt and key failed errmsg:%s %s"%(crtcode[1],keycode[1]))
                        return None
            return True
        else:
            write_logger(logfile).error("gen node cert failed errmsg:%s"%ret[1])
            return None
    except Exception as e:
        write_logger(logfile).error("gen server certs failed errmsg %s"%e)
        return None


# gen client default root crt and key
def gen_user_cli():
    ret = subprocess.getstatusoutput(gen_lic)
    if ret[0] == 0:
        write_logger(logfile).debug("gen user client success")
        return True
    else:
        write_logger(logfile).error("gen user client failed errmsg:%s"%ret[1])
        return None
    

# stop qianbase process service common method
def stop(ip,port="26287",prex="listen-addr=:",killtype="kill -9"):
    filterstr = prex+port
    try:
        killcmd="ps -fe|grep -v grep|grep %s/%s|grep %s|awk '{print $2}'|while read line;do %s $line; done"%(bindir,binname,filterstr,killtype)
        if "pkill" in killtype:
            killcmd = killtype + " " + binname
        if "killall" in killtype:
            killcmd = killtype + " " + binname
        elif "reboot" in killtype:
            killcmd = killtype
        elif "init" in killtype:
            killcmd = killtype
        elif "shutdown" in killtype:
            killcmd = killtype
        sshapp.cmd(killcmd,ip)
        write_logger(logfile).debug("ip:%s port:%s exec command %s end!!"%(ip,port,killcmd))
        return True

    except Exception as e:
        write_logger(logfile).error("stop server %s  ip : %s failed errmsg:%s !!!"%(binname,ip,e))
        return False
    finally:
        pass


# start qianbase process service common method
def start(cmd,ip):
    try:
        sshapp.cmd("%s 1>&2"%cmd,ip)
        write_logger(logfile).info("start instance command %s success"%cmd)
        return True
    except Exception as e:
        write_logger(logfile).error("start instance ip %s failed!!!"%ip)
        return False


#del qianbase install dir
def del_dir(ip,cmd):
    pass


#get qianbase connection file description(fd)
def get_conn(host=None,port=None,dbname=None,user=None,password=None,autocommit=None):
    try:
        obj = Conn(host=host,port=port,dbname=dbname,user=user,password=password,autocommit=autocommit)
        conn = obj.get_conn()
    except Exception as e:
        write_logger(logfile).error("get connection file description failed errmsg:%s"%e)
        return None
    return conn

def ckpt_job_switch(coordinator,ckptinfosql=None,timeout=60):
    if not ckptinfosql:
        ckptinfosql = "select coordinator_id from dbms_internal.jobs where job_type = 'CHECKPOINT'"
        if binname == "cockroach":
            ckptinfosql = "select coordinator_id from crdb_internal.jobs where job_type = 'CHECKPOINT'"
    topimeout=timeout
    #print(ckptinfosql)
    i=1
    while True:
        try:
            conn = get_conn()
            if not conn:
                write_logger(logfile).error("ckpt_job_switch get connection fd failed")
            cur = conn.cursor()
            cur.execute(ckptinfosql)
            tmp = cur.fetchone()[0]
            #print(tmp)
            if coordinator == tmp or tmp == None:
                time.sleep(1)
                continue
            else:
                break
            if i > timeout:
                with pytest.raises(SystemExit):
                    raise KeyError("ckpt job swith timeout 300s")
                break
        except Exception as e:
            write_logger(logfile).error("ckpt job switch exception app")
            with pytest.raises(SystemExit):
                gen_raise()
        finally:
            conn.close()
            cur.close()
        i=i+1
    return True


#test get all room info and start args cmd
def test_args(subfix=" --background",host=None,port=None):
    rid1_dict={}
    rid2_dict={}
    rid3_dict={}
    argssql = "select address,locality,args,node_id from dbms_internal.kv_node_status"
    if binname == 'cockroach':
        argssql = "select address,locality,args,node_id from crdb_internal.kv_node_status"
    try:
        if host and port:
            conn = get_conn(host=host,port=port)
        else:
            conn = get_conn()
        if not conn:
            write_logger(logfile).error(" get connection fd failed")
            raise "get conn failed!!!"
        cur = conn.cursor()
        cur.execute(argssql)
        res = cur.fetchall()
        for row in res:

            key=row[0]
            regionlst = (row[1].split("region=")[1]).split(",")
            startcmd = (" ".join(row[2])+subfix)
            nodeinfo = row[3]
            for store in row[2]:
                if store.startswith("--store="):
                    storeinfo = store.split("=")[1]

            if regionlst[2] == "rid=1":
                rid1_dict[key] = (regionlst,startcmd,nodeinfo,storeinfo)
            elif regionlst[2] == "rid=2":
                rid2_dict[key] = (regionlst,startcmd,nodeinfo,storeinfo)
            elif regionlst[2] == "rid=3":
                rid3_dict[key] = (regionlst,startcmd,nodeinfo,storeinfo)



        if not rid1_dict:
            write_logger(logfile).info("get primary room info failed ,please check config rid=1's info!!!")
        if not rid2_dict:
            write_logger(logfile).info("get local room info failed,please check config rid=2's info!!!")
        if not rid3_dict:
            write_logger(logfile).info("get remote room info failed,please check config rid=3's info!!!")

        return (rid1_dict,rid2_dict,rid3_dict)
    except Exception as e:
        write_logger(logfile).error("argssql exec sql %s failed errmsg:%s!!!"%(argssql,e))
        raise "get address locality args failed!!!"
        return None

# get node id method by address
def get_nodeid(address):
    nodeidsql="select node_id from dbms_internal.kv_node_status where address = '%s'"
    if binname == 'cockroach':
        nodeidsql="select node_id from crdb_internal.kv_node_status where address = '%s'"

    try:
        conn = get_conn()
        if not conn:
            write_logger(logfile).error(" get connection fd failed")
            raise "get conn failed!!!"
        cur = conn.cursor()
        cur.execute(nodeidsql%address)
        res = cur.fetchall()
        for row in res:
            node_id=row[0]
        return node_id
    except Exception as e:
        write_logger(logfile).error("argssql exec sql %s failed errmsg:%s!!!"%(nodeidsql,e))
        raise "get address locality args failed!!!"

# decommission node all back
def decommission_method(address):
    try:
        node_id = get_nodeid(address)
        ip = address.split(":")[0]
        port = address.split(":")[1]
        cmd="{3}/{4} node  decommission {0} --" + securemod +" --host={1} --port={2}".format(node_id,ip,port,bindir,binname)
        sshapp.cmd(cmd,ip)
        write_logger(logfile).debug("decommission node_id: %s,ip:%s,port:%s"%(node_id,ip,port))
    except Exception as e:
        write_logger(logfile).debug("decommission node_id failed errmsg:%s"%(e))
        return None


#scp dir to server for chaosblade
def upload_scp(host,localpath=None,remotepath=None):
    if not localpath:
        localpath=chaosbladepath
    if not remotepath:
        remotepath = remotechaospath
    try:
        if os.path.exists(localpath):
            rmt_cmd = "scp -r -P %s %s %s@%s:%s"%(sshport,localpath,user,host,remotepath)
            ret = rmt.rmt_exec(rmt_cmd,password)
            if ret == 0:
                write_logger(logfile).info("scp %s to %s success!! %s"%(localpath,host,rmt_cmd))
            else:
                write_logger(logfile).error("scp %s to %s  failed!! %s"%(localpath,host,rmt_cmd))
                return False
            return True
        else:
            write_logger(logfile).error("check localpath %s is or not exists!!!"%localpath)
            return False

    except Exception as e:
        write_logger(logfile).error("upload_scp  local to remote scp cmd failed errmsg:%s"%e)
        return False

#scp chaosblade to remote server
def deploy_chaosblade():
    try:
        for ipnum in ip_num:
            ip = ipnum.split("-")[0]
            ret = upload_scp(ip)
            if ret:
                sshapp.cmd(chaosbin,ip)
            else:
                write_logger(logfile).error("%s deloy chaosblade experiment failed "%ip)
    except Exception as e:
        write_logger(logfile).error("deley chaosblade experiment failed errmsg:%s"%e)
        sys.exit()
        
#delay time setting method 
def setting_loss(rid1,rid2,loss=100):
    res = []
    loss_cmd1 = chaosbin + " create network loss --percent "+ str(loss)  + " --interface " + ethname + " --destination-ip  %s "%(",".join(rid1)) + " --timeout 600s "
    for ip in rid2:
        ret = sshapp.cmd(loss_cmd1,ip)
        if ret:
            res2 = str(ret,encoding='utf-8').split("\n")
            if "true" in res2[0]:
                tmp=res2[0].replace("true","True")
                tmpdict=eval(tmp)
                res.append((ip,tmpdict.get("result")))
        else:
            write_logger(logfile).error("chaosblade setting network loss failed"%ip)
    loss_cmd2 = chaosbin + " create network loss --percent "+ str(loss)  + " --interface " + ethname + " --destination-ip  %s "%(",".join(rid2)) + " --timeout 600s "
    for ip2 in rid1:
        ret = sshapp.cmd(loss_cmd2,ip2)
        if ret:
            res1 = str(ret,encoding='utf-8').split("\n")
            if "true" in res1[0]:
                tmp=res1[0].replace("true","True")
                tmpdict=eval(tmp)
                res.append((ip2,tmpdict.get("result")))
        else:
            write_logger(logfile).error("chaosblade setting network loss failed"%ip2)
    return res


#delay time setting method 
def setting_delay(ip,duration):
    duration_cmd = chaosbin + " create network delay --time "+ duration +" --interface " + ethname +" --timeout 300s --exclude-port " + sshport
    ret = sshapp.cmd(duration_cmd,ip)
    if ret:
        res = str(ret,encoding='utf-8').split("\n")
        if "true" in res[0]:
            tmp=res[0].replace("true","True")
            tmpdict=eval(tmp)
            return (ip,tmpdict.get("result"))
    else:
        write_logger(logfile).error("chaosblade setting network delay failed")
        return None

#destroy delay time setting method
def destroy_delay(ip,uuid):
    destroy_cmd = chaosbin + " destroy " + "'%s'"%uuid
    ret = sshapp.cmd(destroy_cmd,ip)
    if ret:
        write_logger(logfile).info("destroy delay end")
        return True
    else:
        write_logger(logfile).error("%s"%ret)
        return None



#decrease node 
def decommission_node(ipport,nodeidlst):
    try:
        count=30
        filternodeid = nodeidlst.split()
        filter_clause = ",".join(filternodeid)
        sqlcmd = membership.format(filter_clause)
        decommissioncmd = "%s/%s "%(bindir,binname) + " node decommission " + nodeidlst +  " --" + securemod + " --host=" + ipport
        host = ipport.split(":")[0]
        rmt.exec_cmd(decommissioncmd,host)
        to = 1
        while True:
            ret =subprocess.getstatusoutput(sqlcmd)
            if "decommissioning" in ret[1]:
                time.sleep(5)
            else:
                write_logger(logfile).debug("decommission check sqlcmd retres %s "%ret[1])
                break
            if to > count:
                write_logger(logfile).error("decommission node_ids %s failed"%nodeidlst)
                return None
            to = to + 1
        write_logger(logfile).debug("decommission node_ids %s success"%nodeidlst)
        return True
    except Exception as e:
        write_logger(logfile).error("decommission node_ids %s failed errmsg:%s"%(nodeidlst,e))
        return None

#decrease node 
def execsql(ipport,sqlstat,timeout=100):
    try:
        sqlcmd = "%s/%s "%(bindir,binname) +  "sql  --" + securemod + " --host=" + ipport + " -e " + '''"%s"'''%sqlstat
        host = ipport.split(":")[0]
        rmt.exec_cmd(sqlcmd,host,timeout=timeout)
        write_logger(logfile).debug("exec sql statements success")
        return True
    except Exception as e:
        write_logger(logfile).error("exec sql statements failed errmsg:%s"%e)
        return None

#test raise gen
def gen_raise(casename):
    raise KeyError("test case %s failed"%(casename))


##get decommission node info
def get_decommission_node_id(ridinfo):
    try:
        nodeidlst = ""
        for key,value in ridinfo.items():
            nodeidlst = nodeidlst +str(value[2])+" "
        return nodeidlst
    except Exception as e:
        return None

## exec decommission node info method
def exec_decommission(ipport,ridinfo,sqlstat=None,timeout=100):
    #decommission node pre zone config modify
    if sqlstat:
        execsql(ipport,sqlstat,timeout=timeout)
    nodelist = get_decommission_node_id(ridinfo)
    if nodelist:
        duration = len(nodelist.split())*10
        time.sleep(int(duration))
        decommission_node(ipport,nodelist)
    else:
        time.sleep(10)
            

if __name__ == '__main__':
    pass

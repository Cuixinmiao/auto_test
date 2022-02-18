import os
import glob
import sys
import pytest
import configparser
#from factory import rmt


class QianbaseTestPerformance():

    global startargspath
    global basepath
    global cpunums
    global securemode
    global store
    global locality
    global advertiseaddr
    global port
    global httpaddr
    global cache
    global maxsqlmemory
    global maxoffset
    global joinip
    global work
    global rack
    global pretime
    global pre_after_waittime
    global runtime
    global url
    global warehouse
    global initip_port
    #haproxy
    global nproc
    global maxconn
    global conn_timeout
    global client_timeout
    global server_timeout
  
    config = configparser.ConfigParser()
    basepath=os.getcwd()
    confpath=os.path.join(basepath,"conf")
    toolspath=os.path.join(basepath,"tools")
    conffile = os.path.join(confpath,"config_performance_stable.txt")
    config.read(conffile)

    startargspath=os.path.join(basepath,"testcase/performance/script/startQianbaseScript")
  
    cpunums = config.get("startargs","taskset_cpus").strip()
    securemode = config.get("startargs","securemod").strip()
    store = config.get("startargs","store").strip().split(",")
    locality = config.get("startargs","locality").strip().split(",")
    advertiseaddr = config.get("startargs","advertise-addr").strip().split(",")
    port = config.get("startargs","port").strip().split(",")
    httpaddr = config.get("startargs","http-addr").strip().split(",")
    cache = config.get("startargs","cache").strip()
    maxsqlmemory = config.get("startargs","max-sql-memory").strip()
    maxoffset =  config.get("startargs","max-offset").strip()
    joinip = config.get("startargs","join").strip()
    
    initip_port=joinip.split(",")[0] 
   
    url = config.get("performance","url")
    warehouse = config.get("performance","warehouse")
    work = config.get("performance","worker")
    rack = config.get("performance","rack")
    pretime = config.get("performance","pretime")
    pre_after_waittime = config.get("performance","pre_after_waittime")
    runtime = config.get("performance","runtime")
    #haproxy
    nproc = config.get("haproxy","nproc")
    maxconn = config.get("haproxy","maxconn")
    conn_timeout = config.get("haproxy","connect_timeout")
    client_timeout = config.get("haproxy","client_timeout")
    server_timeout = config.get("haproxy","server_timeout")

    
    def setup_class(self):
        print("generate start scirpt .....")
        if cpunums == "128":
            bangcpulist=['0-15','16-31','32-47','48-63','64-79','80-95','96-111','112-127']
           # return bangcpulist
        elif cpunums == "96":
            bangcpulist=['0-11','12-23','24-35','36-47','48-59','60-71','72-83','84-95']
            #return bangcpulist
        else:
            print("only support cpus 128 or 96")

        for ip in advertiseaddr:
            #if exists, delete start_qianbase_ip.sh
            startfile = "{0}/start_Qianbase_{1}.sh".format(startargspath,ip)
            print(startfile)
            if os.path.exists(startfile):
                os.remove(startfile)
            for i in range(len(store)):
                with open(startfile,'a') as f:
                    f.write("taskset -c {10} qianbase start --{0} --accept-sql-without-tls --store={1} --attrs=ssd --locality={2} --advertise-addr={3} --port={4} --http-addr=:{5} --join={6} --cache={7} --max-offset={8} --max-sql-memory={9} --background \n".format(securemode,store[i],locality[i],ip,port[i],httpaddr[i],joinip,cache,maxoffset,maxsqlmemory,bangcpulist[i]))

  		
    def test_tpmc_qianbase(self):
        isok = self.run_tpcc_Test()
        assert isok,"Tpmc values down more than 5%, performance test fail."

    def run_tpcc_Test(self):
        try:
            iplist = ''
            for ip in advertiseaddr:
                iplist = iplist+","+ip
            
            #get resultfile
            scriptpath = os.path.join(basepath,"testcase/performance/script")
            expectfile = os.path.join(basepath,"testcase/performance/expect/result.exp")
            resultfilepath = os.path.join(basepath,"testcase/performance/result")            
            shellcmd = "sh {0}{1}run_tpcc_Test.sh {2} {3} {4} {5} {6} {7} {8} {9} {10} {11} {12} {13} {14} {15}".format(scriptpath,"/",iplist[1:],warehouse,work,rack,url,pretime,runtime,pre_after_waittime,initip_port,nproc,maxconn,conn_timeout,client_timeout,server_timeout) 
            print(shellcmd)
            #exec run_Test.sh
            os.system(shellcmd)
            
            #after tpcc run finish,get resultfile
            respath = glob.glob(resultfilepath)
            for resfile in os.listdir(respath[0]):
                if ".res" in resfile:
                    resultfilename = resfile
            resultfile = resultfilepath+"/"+resultfilename
            expect = os.popen("tail -n 1 {0}".format(expectfile))
            expectTpmc = expect.read()[:-1]
            print("expect Tpmc is:{}".format(expectTpmc))
            #print("resultfile path is:{}".format(resultfile))
            actual=os.popen("tail -n 1 {0}".format(resultfile))
            actualTpmc=actual.read()[:-1]
            print("actual Tpmc is:{}".format(actualTpmc))
            #if float(actualTpmc) > float(expectTpmc)*0.95:         
            #    return True
            #else:
            #    return False
            
        except Exception as e:
            print(e)


    def readFile(filename):
        linestr=''
        try:
            with open(filename,'r') as f:
                linestr = f.read()
            return linestr
        except Exception as e:
            print(e)
                
 
def main():
    #res = TestStabilisty.getParam()
    #print(res)
    #QianbaseTestPerformance.run_Test()
    QianbaseTestPerformance.generateStartScript()
    QianbaseTestPerformance.run_Test()

if __name__ == '__main__':
    #teststab = TestStabilisty()
    main() 
    

#!/usr/bin/python
import os
import sys
import pytest
import configparser

class QianbaseTestStabilisty():
    global startargspath
    global basepath
    global url
    global concurrency
    global runtime
    global scriptpath
    global isinstall
    global initip_port
    global joinip

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

    
    config = configparser.ConfigParser()
    basepath=os.getcwd()
    confpath=os.path.join(basepath,"conf")
    toolspath=os.path.join(basepath,"tools")
    scriptpath = os.path.join(basepath,"testcase/stability/script")
    conffile = os.path.join(confpath,"config_performance_stable.txt")
    config.read(conffile)
    
    startargspath=os.path.join(basepath,"testcase/stability/script/startQianbaseScript")

    cpunums = config.get("startargs","taskset_cpus").strip()
    securemode = config.get("startargs","securemod").strip()
    store = config.get("startargs","store").strip().split(",")
    locality = config.get("startargs","locality").strip().split(",")
    advertiseaddr = config.get("startargs","advertise-addr").strip().split(",")
    port = config.get("startargs","port").strip().split(",")
    httpaddr = config.get("startargs","http-addr").strip().split(",")
    cache = config.get("stability","cache").strip()
    maxsqlmemory = config.get("stability","max-sql-memory").strip()
    maxoffset =  config.get("startargs","max-offset").strip()

    joinip = config.get("startargs","join").strip()
    initip_port=joinip.split(",")[0]

    url = config.get("stability","url")
    concurrency = config.get("stability","concurrency")
    runtime = config.get("stability","runtime")
    isinstall = config.get("stability","is_install_xtp")
    
    def setup_class(self):
        if isinstall == "yes":
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
            ###########generate start scirpt
            iplist = ''
            for ip in advertiseaddr:
                iplist = iplist+","+ip

            #get resultfile
            scriptpath = os.path.join(basepath,"testcase/stability/script")
            print("initip_port===={0}".format(initip_port))
            shellsrc = "sh {0}{1}init_testEnv.sh {2} {3}".format(scriptpath,"/",iplist[1:],initip_port)
            print(shellsrc)
            #exec run_Test.sh
            os.system(shellsrc)

        elif isinstall == "no":
            pass
        else:
            print(">>>is_install_xtp args errors.please check config file.")
            sys.exit(0)


    def run_workload(self,workload_type):
        try:
            expectpath = os.path.join(basepath,"testcase/stability/expect")
        
            resultfile = os.path.join(basepath,"testcase/stability/result/{0}.res".format(workload_type))
            shellsrc = "sh {0}{1}{6}.sh {2} {3} {4} {5}".format(scriptpath,"/",concurrency,runtime,url,resultfile,workload_type)        
            print(shellsrc)
            os.system(shellsrc)
            actresult = QianbaseTestStabilisty.readFile(resultfile)
            if "pass" in actresult :
                return True
            else:
                return False
        except Exception as e:
            print(e)

    @pytest.mark.skip(reason="no test")
    def bank_test_qianbase(self):
        assert self.run_workload("bank_workload")
    
    #@pytest.mark.skip(reason="no test")
    def kv_test_qianbase(self):
        assert self.run_workload("kv_workload")
    
    @pytest.mark.skip(reason="no test")
    def movr_test_qianbase(self):
        assert self.run_workload("movr_workload")

    @pytest.mark.skip(reason="no test")
    def startrek_test_qianbase(self):
        assert self.run_workload("startrek_workload")

    @pytest.mark.skip(reason="no test")
    def ycsb_test_qianbase(self):
        assert self.run_workload("ycsb_workload")

    @pytest.mark.skip(reason="no test")
    def tpcc_test_qianbase(self):
        assert self.run_workload("tpcc_workload")

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
    QianbaseTestStabilisty.bank_stable_qianbase()

if __name__ == '__main__':
    #teststab = TestStabilisty()
    main() 
    

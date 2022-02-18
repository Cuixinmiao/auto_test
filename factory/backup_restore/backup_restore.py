import os
import sys
import time
import configparser
"""解决qianbasecode 单独执行模块导入异常的问题"""
"""获取执行脚本的根路径"""
typeinfo = os.environ.get("typeinfo")
if not typeinfo:
    if "backup_restore" in __file__:
        os.environ["typeinfo"] = "backup_restore"
try:
    curdir=os.getcwd()
    syspath = curdir
    if "factory" in curdir:
        syspath = curdir.split("factory")[0]
    os.chdir(syspath)
except Exception as e:
    print("修改工作到根路径失败:errmsg:%s"%e)
    sys.exit()

try:
    from factory.conf import *
    from factory import testcase
    from factory import collect
    from factory import sshapp
    from factory.collect import write_logger
    from factory.testcase import Testcase
    from factory.util_ha.inst331 import Startup
    from factory.common import *
    from factory import common
    from factory import rmt
    from factory.backup_restore import ssh
except Exception as e:
    print(syspath)
    sys.path.append(syspath)
    from factory.conf import *
    from factory import sshapp
    from factory import testcase
    from factory.collect import write_logger
    from factory.testcase import Testcase
    from factory.util_ha.inst331 import Startup
    from factory.common import *
    from factory import common
    from factory import rmt
    from factory.backup_restore import ssh


"""inherit baseclass info"""
class Base_bk(Startup):
    def __init__(self,bktype="backup_restore"):
        self.hainfo = bktype
        self.qianbase = 'qianbase'
        self.certs = 'certs'
        super().__init__()
        self.sqlfilepath = None
        self.ckpt = config.get(self.qianbase,"checkpoint").strip()
        self.initsqlpath = os.path.join(self.basepath,"initsql")
        sqlfile="setckpt.sql"
        self.remotefile=os.path.join(self.remotepath,sqlfile)
        self.sqlfilepath = os.path.join(self.initsqlpath,sqlfile)
        self.dbname = config.get(self.qianbase,"dbname").strip()
        self.host = config.get(self.qianbase,"host").strip()
        self.nodeid = config.get(self.qianbase,"nodeid").strip()
        self.backdir = config.get(self.qianbase,"backdir").strip()
        self.gm = config.get(self.certs,"gm").strip()
        self.securepw = config.get(self.qianbase,"securepw").strip()
        self.timezone = config.get(self.qianbase, "timezone").strip()
        self.isolevel = config.get(self.qianbase, "isolevel").strip()
    
    def returnpara(self):
        dic = {'dbname':self.dbname,'securepw':self.securepw,'user':self.user,'sshpassword':self.password,'host':self.host,'dbport':self.listenaddr,'sshport':self.sshport,'bindir':self._bindir,'nodeid':self.nodeid,'backdir':self.backdir,"securemode" : self.securemode,"gm":self.gm,"client":self.client_ip}
        return dic 
    
    def rm_file(self):
        try:
            dire = "qianbase-xtp-test"
            if dire in os.getcwd():
                basepath = os.getcwd().split(dire)[0]
                prepath = os.path.abspath(os.path.join(basepath, "qianbase-xtp-test"))
                listip = list(set(self.advertiseaddr))
                for ip in listip:
                    rmcommand = 'rm -rf %s' % (prepath)
                    ssharg = [ip, self.sshport, self.user, self.password]
                    ssh.myssh(rmcommand, ssharg)
                    write_logger(logfile).info("in %s, '%s' was deleted successfully " %(ip,prepath))
            else:
                write_logger(logfile).info(" No such '%s' directory" %dire)
        except Exception as e:
            write_logger(logfile).error("--errmsg:%s" % e)
            sys.exit()

    def scp_file(self,filepath,fatherpath):
        try:
            listip = list(set(self.advertiseaddr))
            if os.path.exists(fatherpath):
                for ip in listip:
                    mkcommand = 'mkdir -p %s' % (fatherpath)
                    ssharg = [ip,self.sshport,self.user,self.password]
                    ssh.myssh(mkcommand, ssharg)
                    rmt_cmd = "scp -r -P %s %s %s@%s:%s"%(self.sshport,filepath,self.user,ip,filepath)
                    ret = rmt.rmt_exec(rmt_cmd,self.password,timeout=90)
                    if ret == 0:
                        write_logger(logfile).info("scp %s to %s success %s!!"%(filepath,ip,rmt_cmd))
                    else:
                        write_logger(logfile).error("scp %s to %s failed!! %s"%(filepath,ip,rmt_cmd))
                        return False
                return True
            else:
                write_logger(logfile).error("scp %s is not exists !!!"%filepath)
                return False
        except Exception as e:
            write_logger(logfile).error("scp %s failed"%filepath)
            return False
        finally:
            pass


    def run(self,hatype=None):
        #清理环境
        self.teardown()
        #gen certs ca.key
        if self.securemode != "insecure":
            self.set_certs()
        #scp_qianbase 
        retcode = self.scp_qianbase()
        if not retcode:
            write_logger(logfile).error("please place execbin to tools path %s"%self.execbin)
            sys.exit()
        #scp 远程到/usr/lib64/的静态库
        self.upload_scp(self.libgeos,"/usr/lib64")
        self.upload_scp(self.libgeos_c,"/usr/lib64")
        #sftp local to remote sqlfile
        #基数
        i=0
        tmplen = len(self.join)
        for ip_num in self.startnum:
            ip = ip_num
            num=1
            if "-" in ip_num:
                ip = ip_num.split("-")[0]
                num = ip_num.split("-")[1]
            login_str = "ssh %s@%s"%(self.user,ip)
            tmp=rmt.rmt_login(login_str,self.password)
            if tmp[0] == 0:
                self.handler=tmp[1]
            for j in range(0,int(num)):
                datadir = self.store.format(str(j+1))
                cmd = """%s start --%s --store=%s --advertise-addr=%s --listen-addr=:%s --http-addr=:%s --locality=%s --join=%s --cache=%s --max-sql-memory=%s --background"""\
                        %(self.binname,self.securemode,datadir,ip,str(int(self.listenaddr)+j),str(int(self.httpaddr)+j),self.locality[i],self.join1,self.cache,self.maxsqlmemory)
                if self.timezone:
                    cmd = """%s start --%s --store=%s --advertise-addr=%s --listen-addr=:%s --http-addr=:%s --locality=%s --join=%s --cache=%s --max-sql-memory=%s --background %s""" \
                          % (self.binname, self.securemode, datadir, ip, str(int(self.listenaddr) + j),str(int(self.httpaddr) + j), self.locality[i], self.join1, self.cache, self.maxsqlmemory,self.timezone)
                print(cmd)
                #else:
                #    pass
                try:
                    # del instance dir
                    sshapp.cmd("rm -fr %s"%datadir,ip)
                    write_logger(logfile).info("del dir [ %s] success !!!"%datadir)
                    #startup instances 
                    ret = rmt.rmt_cmd(self.handler,cmd)
                    if ret == 0:
                        write_logger(logfile).info("exec command %s success !!"%cmd)
                    else:
                        write_logger(logfile).error("exec command %s failed errmsg %s"%(cmd,ret))
                except Exception as e:
                    write_logger(logfile).error("inst command %s failed %s"%(cmd,e))
            i+=1
            cmd=""

        
        rmt.rmt_close(self.handler)
        #初始化实例
        if self.init == "1" or self.init == "2" or self.init == "3":
            init_cmd = "%s init %s  --%s --host=%s:%s"%(self.binname,self.init,self.securemode,self.init_ip,self.init_port)
        else:
            init_cmd = "%s init  --%s --host=%s:%s"%(self.binname,self.securemode,self.init_ip,self.init_port)

        ret1 = sshapp.cmd(init_cmd,self.init_ip)
        if ret1:
            write_logger(logfile).info("exec init %s success"%init_cmd)
        else:
            write_logger(logfile).error("exec init %s failed"%init_cmd)

        #获取数据库的版本信息
        ipversion = self.advertiseaddr[0]
        sshapp.cmd("%s version"%self.binname,ipversion)

        #查看集群的状态
        check_stat = "%s node status --%s --host=%s:%s"%(self.binname,self.securemode,self.init_ip,self.init_port)
        login_str = "ssh %s@%s"%(self.user,self.init_ip)
        tmp=rmt.rmt_login(login_str,self.password)
        if tmp[0] == 0:
            handler = tmp[1]
            time.sleep(10)
            rmt.rmt_cmd(handler,check_stat)
            ret2 = rmt.rmt_cmd(handler,check_stat)
            isablity=str(handler.before,encoding="utf-8").split("\n")
            for line in isablity: 
                print(line+"\n")
            if ret2 == 0:
                write_logger(logfile).info("exec db status %s success"%check_stat)
                for line in isablity:
                    write_logger(logfile).info("%s"%line)
            else:
                write_logger(logfile).error("exec db status %s failed"%check_stat)
        else:
            retp = sshapp.cmd(check_stat,self.init_ip)
            isablity=str(retp,encoding="utf-8").split("\n")
            for line in isablity:
                print(line+"\n")
        handler.close()
        #注册license的语句
        try:
            print("common.get_lincense")
            ret = common.get_license()
            print(ret)
            if ret:
                write_logger(logfile).info("Register license success")
            else:
                write_logger(logfile).error("Register license failed")

        except Exception as e:
            write_logger(logfile).error("Register license failed  errmsg: %s"%e)
            sys.exit()
        #执行初始化集群的sql文件

        if self.ckpt == '1':
            try:
                self.scp_file(self.sqlfilepath,self.initsqlpath)
            except Exception as e:
                write_logger(logfile).error("scp local %s to remote %s failed errmsg:%s "%(self.sqlfilepath,self.remotepath,e))
                return None
            try:
                cmd = "%s sql --%s --host=%s:%s -f %s"%(self.binname,self.securemode,self.init_ip,self.init_port,self.sqlfilepath)
                sshapp.cmd(cmd,self.init_ip)
                write_logger(logfile).info("init sql cmd %s success "%cmd)
            except Exception as e :
                write_logger(logfile).error("init sql cmd %s failed errmsg: %s"%(cmd,e))
                print("请查看log %s"%(os.path.join(os.getcwd(),logfile)))
                sys.exit()
        if self.isolevel == 'open':
            sqlfile="setisolationlevel.sql"
            self.remotefile=os.path.join(self.remotepath,sqlfile)
            self.sqlfilepath = os.path.join(self.initsqlpath,sqlfile)
            try:
                self.scp_file(self.sqlfilepath,self.initsqlpath)
            except Exception as e:
                write_logger(logfile).error("scp local %s to remote %s failed errmsg:%s "%(self.sqlfilepath,self.remotepath,e))
                return None
            try:
                cmd = "%s sql --%s --host=%s:%s -f %s"%(self.binname,self.securemode,self.init_ip,self.init_port,self.sqlfilepath)
                sshapp.cmd(cmd,self.init_ip)
                write_logger(logfile).info("init sql cmd %s success "%cmd)
            except Exception as e :
                write_logger(logfile).error("init sql cmd %s failed errmsg: %s"%(cmd,e))
                print("请查看log %s"%(os.path.join(os.getcwd(),logfile)))
                sys.exit()


    def start_run(self,startnum=None):
        #start_num 赋值为默认值
        if not startnum:
            startnum = self.startnum
        #基数
        try:
            i=0
            #tmplen = len(self.join)
            for ip_num in startnum:
                ip = ip_num
                num=1
                if "-" in ip_num:
                    ip = ip_num.split("-")[0]
                    num = ip_num.split("-")[1]
                login_str = "ssh %s@%s"%(self.user,ip)
                tmp=rmt.rmt_login(login_str,self.password)
                if tmp[0] == 0:
                    self.handler=tmp[1]
                for j in range(0,int(num)):
                    #if len(self.store[i].split("-")) == 1:
                    datadir = self.store.format(str(j+1))
                    if "rid=3" not in self.locality[i]:
                        if j%3 == 0:
                            locality = self.locality[i].format(str(3))
                        else:
                            locality = self.locality[i].format(str(j%3))
                    else:
                        locality = self.locality[i].format(str(1))
                    cmd = """%s start --%s --store=%s --advertise-addr=%s --listen-addr=:%s --http-addr=:%s --locality=%s --join=%s --cache=%s --max-sql-memory=%s --background"""\
                        %(self.binname,self.securemode,datadir,ip,str(int(self.listenaddr)+j),str(int(self.httpaddr)+j),locality,self.join1,self.cache,self.maxsqlmemory)
                    
                    if self.timezone:
                        cmd = """%s start --%s --store=%s --advertise-addr=%s --listen-addr=:%s --http-addr=:%s --locality=%s --join=%s --cache=%s --max-sql-memory=%s --background %s"""\
                        %(self.binname,self.securemode,datadir,ip,str(int(self.listenaddr)+j),str(int(self.httpaddr)+j),locality,self.join1,self.cache,self.maxsqlmemory,self.timezone)

                    print(cmd)
                    #else:
                    #    pass
                    try:
                    #    rett=rmt.rmt_cmd(self.handler,"rm -fr %s"%datadir)
                    #    if rett == 0:
                    #        write_logger(logfile).info("del dir %s success"%datadir)
                    #    else:
                    #        write_logger(filerport).error("del dir %s failed"%datadir)
                    #
                        ret=rmt.rmt_cmd(self.handler,cmd)
                        if ret == 0:
                            write_logger(logfile).info("exec cmd %s success"%cmd)
                        else:
                            write_logger(logfile).error("exec cmd %s failed"%cmd)
                    except Exception as e:
                        write_logger(logfile).error("inst command %s failed %s"%(cmd,e))
                i+=1
                cmd=""
        except Exception as e:
            write_logger(logfile).error("startup instance  %s failed"%e)
            pass

        finally:
            rmt.rmt_close(self.handler)

    #install backup_restore qianbasedb
    def instbk(self,cmd=None):
        try:
            #exec install 
            self.run(self.hainfo)
            write_logger(logfile).info("backup_store %s install success"%self.hainfo)

        except Exception as e:
            write_logger(logfile).error("backup_store type %s install failed ermsg:%s"%(self.hainfo,e))
            print("backup_store type %s install failed ermsg:%s"%(self.hainfo,e))
            sys.exit()
        finally:
            pass


#安装backup_store集群
def instbk(bk="backup_restore"):
    try:
        bc = Base_bk(bk)
        bc.instbk()
    except Exception as e:
        write_logger(logfile).error("call method install cluster faielld errmsg: %s"%e)
        sys.exit()


if __name__ == '__main__':
    instbk()

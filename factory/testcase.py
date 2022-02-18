# -*- coding:utf8 -*-
#################################
#date :2021-09-14
#func  :testcase exec case method
#func 测试用例模块 sql语句的
#author :Xinmiao Cui
#copyright : esygn
#################################
#!/usr/bin/python

import os
import sys
import shutil
from factory import util
from factory.connectdb import Conn
from factory import run_sql
from factory.collect import *
from factory.conf import *

"""testcasesuite"""
class Testcase():

    def __init__(self,module="func",exe=Conn(),mkexp=0):
        self.module = module
        self.mkexp = mkexp
        self.exe = exe
        self.listdir = util.listdir_nohidden
        self.setparam()


    """set module parameters"""
    def setparam(self):
        self.basepath = os.getcwd()
        self.casepath = os.path.join(self.basepath,"testcase")
        self.modpath = os.path.join(self.casepath,self.module)
        self.exppath = os.path.join(self.modpath,"expect")
        self.resultpath = os.path.join(self.modpath,"result")
        self.diffpath = os.path.join(self.modpath,"diff")
        if not os.path.exists(self.diffpath):
            os.mkdir(self.diffpath)
        if not os.path.exists(self.resultpath):
            os.mkdir(self.resultpath)

        if not os.path.exists(self.exppath):
            os.mkdir(self.exppath)
        self.sqlpath = os.path.join(self.modpath,"sql")


    """execute testcase method"""
    def run(self):
        dirf = self.listdir(self.sqlpath) 
        try:
            for file in dirf:
                run_sql.run_single_sqlfile(self.module,"%s"%os.path.join(self.sqlpath,file))
        except Exception as e:
            write_logger(logfile).error("execute sql %s \nfailed errmsg:%s"%(file,e))


    """exec exp and res diff and generate,return True des or False des  sucess True null"""
    def run_func(self,module,abssqlfile):
        filename = os.path.basename(abssqlfile)
        absres="%s.res"%os.path.join(self.resultpath,filename)
        absexp="%s.exp"%os.path.join(self.exppath,filename)
        absdiff="%s.diff"%os.path.join(self.diffpath,filename)
        try:
            run_sql.run_single_sqlfile(module,abssqlfile)
            if self.mkexp == 1:
                if os.path.exists(absres):
                    if not os.path.exists(absexp):
                        shutil.copy(absres,absexp)
                        return(True,"%s expect is generating!!!"%absexp)
                    else:
                        return(True,"%s expect has been exist!!!"%absexp)
                else:
                    return(False,"%s result is not exists!!!"%abres)
                write_logger(logfile).info("%s gen exp success"%filename)
            return util.diff_exp_data(absexp,absres,absdiff)
        except Exception as e:
            write_logger(logfile).error("other error %s"%e)
            return(False,"other error %s"%e)

    def teardown(self):
        pass


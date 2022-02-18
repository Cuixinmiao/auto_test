import os
import pytest
import configparser
from factory import testcase
from factory.testcase import Testcase
from factory import util,run_sql


"""exec func module's class !!!!!"""
class Mockdata_func():
    mkexp = 0

    def __init__(self):
        pass

    @staticmethod
    def get_param():
        basepath = os.getcwd()
        confpath = os.path.join(basepath,"conf")
        conffile = os.path.join(confpath,"config.txt")
        config = configparser.ConfigParser()
        config.read(conffile)
        module = os.path.basename(os.path.splitext(__file__)[0]).split("_")[1]
        mkexp = config.get(module,"mkexp")
        ts = Testcase(module,mkexp=mkexp)
        dirf = util.listdir_nohidden(ts.sqlpath)
        return(module,ts,dirf)

class Qianbasetestfunc():
    @pytest.mark.parametrize("file",Mockdata_func.get_param()[2])
    def func_qianbase(self,file):
        initdata = Mockdata_func.get_param()
        self.module = initdata[0]
        self.ts = initdata[1]
        ret = self.ts.run_func(self.module,os.path.join(self.ts.sqlpath,file))
        if ret [0]:
            assert ret[1] == ""
        else:
            assert "" == ret[1]

#!/usr/bin/python

import os
import sys
import time
import pytest
import configparser
"""解决qianbasecode 单独执行模块导入异常的问题"""
"""获取执行脚本的根路径"""
os.environ["typeinfo"] = "ha331"
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
    from factory import common
    from factory import startup,connectdb,util
    from factory.testcase import Testcase
    from factory.util_ha import inst331
except Exception as e:
    sys.path.append(syspath)
    from factory import common
    from factory import startup,connectdb,util
    from factory.util_ha import inst331
    from factory.testcase import Testcase

@pytest.fixture(scope="session",autouse=True)
def prefix_env():
    #inst331.Startup().pre_env()
    #common.deploy_chaosblade()
    print("not install and config chaosblade")

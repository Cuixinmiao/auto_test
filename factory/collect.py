#!/usr/bin/python
# -*- coding:utf8 -*-
#################################
#date :2021-09-16
#func  :collect log file
#author :Xinmiao Cui
#################################

import os
import sys
import logging
import shutil
from factory.conf import *


#loglevel set log level logging.ERROR,logging.INFO
def write_logger(logFile,loglevel=logging.DEBUG):
    logger = logging.getLogger("qianbase")
    logger.setLevel(loglevel)
    if not logger.handlers:
        fh = logging.FileHandler(os.path.basename(logFile),encoding="utf-8")
        formatter = logging.Formatter(
                fmt='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                datefmt="%Y-%m-%d %H:%M:%S"
                        )
        fh.setFormatter(formatter)
        logger.addHandler(fh)
    return logger

def clean_report(reportpath):
    if not os.path.exists(reportpath):
        os.makedirs(reportpath)
    lists = os.listdir(reportpath)
    if len(lists) > 6:
        lists.sort(key=lambda fn:os.path.getmtime(os.path.join(reportpath,fn)))
        file_old = lists[:-6]
        for i in file_old:
            os.remove(os.path.join(reportpath,i))

def get_home_path():
    return os.path.split(os.path.realpath(sys.argv[0]))[0]

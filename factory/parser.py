# -*- coding:utf8 -*-
#################################
#date :2021-09-14
#func  :parser sql file
#author :Xinmiao Cui
#copyright : esygn
#################################
#!/usr/bin/python


import os
import sys
from factory.collect import *
from factory.conf import *

def parsersql(sqlfile):
    try:
        strsql=""
        fout = open(sqlfile,"r+")
        for line in fout.readlines():
            if not line.strip().startswith("--") and line.strip("\n"):
                if " --" in line:
                    tmplst = line.split(";")
                    strsql=strsql+tmplst[1]+";\n"+tmplst[0]+";\n"
                else:
                    strsql=strsql+line
            elif line.strip().startswith("--"):
                strsql=strsql+line+";"
        return strsql.split(";")
        #return strsql.strip().split(";$")
    except Exception as e:
        write_logger(logfile).error("parsersql failed errmsg:%s"%e)
        sys.exit()

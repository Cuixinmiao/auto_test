# -*- coding:utf8 -*-
#################################
#date :2021-09-14
#func  :connectdb connect qianbase
#author :Xinmiao Cui
#copyright : esygn
#################################
#!/usr/bin/python

import os
import sys
import pexpect
import configparser
import psycopg2 as psycopg
from factory.conf import *
from factory import parser,util
from factory.collect import *

class Conn(): 
    basepath = os.getcwd()
    confpath = os.path.join(basepath,"conf")
    conffile = os.path.join(confpath,"config.txt")
    config = configparser.ConfigParser()
    if not os.path.exists(conffile):
        write_logger(logfile).error("config file is not exists %s"%conffile)
        sys.exit()
    config.read(conffile)
    host = config.get("qianbase","host").strip()
    dbname = config.get("qianbase","dbname").strip()
    user = config.get("qianbase","user").strip()
    password = config.get("qianbase","user").strip()
    port = config.get("qianbase","port").strip()
    count=0
    session="%+10s,%+20s,%+5s,%+2s\n"%("dbname","host","port","num")
    autocommit = True

    def __init__(self,dbname=dbname,user=user,password=password,host=host,port=port,autocommit=autocommit):
        self.host = host
        self.dbname = dbname
        self.user = user
        self.password = password
        self.port = port
        self.autocommit = autocommit
        Conn.count+=1
        Conn.session=Conn.session+"%+10s,%+20s,%+5s,%+2s\n"%(self.dbname,self.host,self.port,Conn.count)
        #self.conn = self.get_conn()
    def get_conn(self):
        try:
            conn=psycopg.connect(dbname=self.dbname,user=self.user,password=self.password,host=self.host,port=self.port)
        except Exception as e:
            write_logger(logfile).error("establish connect failed errmsg:%s"%e)
            return None
        return conn
    """
    @staticmethod
    def get_conn():
        conn=psycopg.connect(dbname=dbname,user=user,password=password,host=host,port=port)
        return conn
    """

if __name__ == '__main__':
    pass

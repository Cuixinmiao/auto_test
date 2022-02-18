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
import psycopg2
from factory.conf import *
from factory import parser,util
from factory.collect import *



class Conn(): 
    #struct function method init
    def __init__(self,host=None,port=None,dbname=None,user=None,password=None,autocommit=None):
        #判定连接信息的类型
        typeinfo = os.environ.get("typeinfo")
        if typeinfo == None:
            print("%s get typeinfo failed"%__file__)
            sys.exit()
        basepath = os.getcwd()
        confpath = os.path.join(basepath,"conf")
        conffile = os.path.join(confpath,"config%s.txt"%typeinfo)
        config = configparser.ConfigParser()
        if not os.path.exists(conffile):
            write_logger(logfile).error("config file is not exists %s"%conffile)
            sys.exit()
        config.read(conffile)
        dbhost = config.get("qianbase","host").strip()
        self.host = dbhost
        dbname = config.get("qianbase","dbname").strip()
        dbuser = config.get("qianbase","user").strip()
        dbpassword = config.get("qianbase","password").strip()
        dbport = config.get("qianbase","port").strip()
        self.port = dbport
        count=0
        session="%+10s,%+20s,%+5s,%+2s\n"%("dbname","host","port","num")
        dbautocommit = True
        if  host:
            self.host = host
        self.dbname = dbname
        if not user:
            self.user = dbuser
        if not password:
            self.password = dbpassword
        if  port:
            self.port = port
        if not autocommit:
            self.autocommit = dbautocommit
        #count = count+1
        #session = session%(self.dbname,self.host,self.port,count)
    def get_conn(self):
        try:
            conn=psycopg2.connect(dbname=self.dbname,user=self.user,password=self.password,host=self.host,port=self.port)
        except Exception as e:
            write_logger(logfile).error("establish connect failed errmsg:%s"%e)
            return None
        return conn


if __name__ == '__main__':
    pass

# -*- coding:utf8 -*-
#################################
#date :2021-09-14
#func  :run_sql exec sql by conn handler 
#author :Xinmiao Cui
#copyright : esygn
#################################
#!/usr/bin/python
import os
from factory import util,connectdb,parser
from factory.connectdb import Conn
from factory.conf import *
from factory.collect import *

"""init connectdb.Conn's object"""
objConn = Conn()

"""Exce single sqlfile"""
def run_single_sqlfile(module,sqlfile):
    filename=os.path.basename(sqlfile)
    resultpath=os.path.join(Conn.basepath,"testcase",module,"result")
    exppath=os.path.join(Conn.basepath,"testcase",module,"expect")
    tmpres = os.path.join(resultpath,filename)
    res = "%s.res"%tmpres
    if os.path.exists("%s"%res):
        util.remove_file("%s"%res)
    f = open("%s"%res,"a+")
    conn = objConn.get_conn()
    conn.autocommit=True
    cur=conn.cursor()
    lstsql = parser.parsersql(sqlfile)
    write_logger(logfile).info("exec sql file :%s"%sqlfile)
    try:
        for sql in lstsql:
            if not sql.strip().startswith("--") and sql !="\n":
                try:
                    cur.execute("%s"%sql)
                    f.write("%s\n"%sql)
                    if "select" in sql.strip()[:9].lower():
                        des=cur.description
                        col=""
                        for j in range(len(des)):
                            col = col + " " + des[j].name

                        f.write("%s\n"%col.strip())
                        tmp = cur.fetchall()
                        for k in tmp:
                            retstr=""
                            for i in k:
                                retstr=retstr + " " + str(i).strip()
                            f.write("%s\n"%retstr.strip())
                except Exception as esg:
                    f.write("%s\n"%sql.strip())
                    f.write("%s\n"%esg)
            else:
                if sql == "\n":
                    continue
                f.write("%s\n"%sql.strip())
    except Exception as e:
        write_logger(logfile).error("get listsqlst failed errmsg:%s"%e)
    finally:
        f.close()

if __name__ == '__main__':
    pass

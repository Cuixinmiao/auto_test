#!/usr/bin/python

import os
import sys
import time
import pytest
import configparser
from factory import startup,connectdb,util
from factory.testcase import Testcase

@pytest.fixture(scope='session',autouse=True)
def inst_db():
    """install db only call one"""
    startup.inst_xtp()
    time.sleep(1)

@pytest.fixture(scope='session',autouse=True)
def init_db():
    obj = connectdb.Conn(dbname="testdb")
    conn = obj.get_conn()
    cur = conn.cursor()
    print("create db testdb")
    print("create database if not exists %s"%connectdb.Conn.dbname)
    cur.execute("create database if not exists %s"%connectdb.Conn.dbname)
    conn.commit()
    conn.close()
    cur.close()

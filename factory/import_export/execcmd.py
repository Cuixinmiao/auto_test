import os
import sys
import psycopg2
import configparser
import time
import re
"""解决qianbasecode 单独执行模块导入异常的问题"""
"""获取执行脚本的根路径"""
try:
    curdir = os.getcwd()
    syspath = curdir
    if "qianbasecode" in curdir:
        syspath = curdir.split("qianbasecode")[0]
    syspath = os.path.abspath(os.path.join(syspath, os.pardir))
except Exception as e:
    print("修改工作到根路径失败:errmsg:%s" % e)
    sys.exit()

try:
    from factory.collect import write_logger
    from factory.conf import *
    from factory.import_export import ssh
    from factory.import_export import import_export
except Exception as e:
    sys.path.append(syspath)
    from factory.collect import write_logger
    from factory.conf import *
    from factory.import_export import ssh
    from factory.import_export import import_export


def jobcommand(job_type):
    """
    @param job_type: job类型
    @return:
    """
    command = "select job_id,running_status,error,status,job_type from dbms_internal.jobs where job_type = '%s';" % job_type
    return command


def judgestate(job_type, arg, t):
    try:
        job = querySQL(jobcommand(job_type), arg)
        while job:
            job = querySQL(jobcommand(job_type), arg)
            print(job[-1])
            if job[-1][2]:
                write_logger(logfile).info('%s error' % job_type)
                sys.exit()
            elif job[-1][3] == 'succeeded':
                write_logger(logfile).info('%s succeeded' % job_type)
                break
            time.sleep(t)
        return 
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)

def comtabstruc(exp,des):
    if exp != des:
        write_logger(logfile).info('The table structure is different before and after backup')
        sys.exit()
    else:
        write_logger(logfile).info('The table structure is exactly the same before and after backup')


def comdata(exp, des):
    if exp != des:
        write_logger(logfile).info('The data is different before and after backup')
        sys.exit()
    else:
        write_logger(logfile).info('The data is exactly the same before and after backup')

def execdatafile(bindir, host, dbport, path):
    dic = import_export.Base_bk().returnpara()
    time.sleep(0.5)
    command = ('%s/qianbase sql --%s --host=%s:%s -f ' % (bindir,dic["securemode"], host, dbport)) + path
    command2 = ('%s/qianbase node status --%s --host=%s:%s' % (bindir,dic["securemode"],host, dbport)) + " | awk '{print $1,$2}'"
    with open(path, "r", encoding='UTF-8') as f:
        con = f.readline()
    d = dict(re.findall('(\w+)\((.*?)\)', con))
    return command,command2,d

def nodeidip(ssh,nodeid):
    nodeinfo = {}
    tmp = ""
    node = re.split('[" "\n]', ssh.strip())[2:]
    for i in range(len(node)):
        if i % 2 == 0:
            tmp = int(node[i])
        else:
            nodeinfo[tmp] = node[i]
            tmp = ""
    backip = nodeinfo[int(nodeid)].split(":")[0]
    backdbport = nodeinfo[int(nodeid)].split(":")[1]
    #return backip,backdbport,nodeinfo
    return backip,backdbport


def execcmd(command,hostip,dbport):
    try:
        dic = import_export.Base_bk().returnpara()
        recomm= ('%s/qianbase sql --%s --host=%s:%s -e "%s"' % (dic["bindir"],dic["securemode"], hostip, dbport,command))
        return recomm
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()

def judgecmd(job_type, ssharg, t):
    try:
        dic = import_export.Base_bk().returnpara()
        write_logger(logfile).info("%s start" %job_type)
        job = ssh.myssh(execcmd(jobcommand(job_type),dic['host'],dic['dbport']), ssharg)
        while job:
            job = ssh.myssh(execcmd(jobcommand(job_type),dic['host'],dic['dbport']), ssharg)
            job = job.split("\n")[1:-2]
            job = job[-1].split("\t")
            write_logger(logfile).info("%s" %job)
            print(job)
            if job[2]:
                write_logger(logfile).info('%s error --errmsg:%s' % job_type, job[2])
                sys.exit()
            elif job[3] == 'succeeded':
                write_logger(logfile).info('%s succeeded' % job_type)
                break
            time.sleep(t)
        return
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()

def showbackupcmd(nodeid,backdir,ssharg):
    try:
        dic = import_export.Base_bk().returnpara()
        backuppath = "'nodelocal://%s/%s'" % (nodeid, backdir)
        sqlcommand = 'SHOW BACKUPS IN %s;' % backuppath
        backfile = ssh.myssh(execcmd(sqlcommand,dic['host'],dic['dbport']), ssharg)
        backfile = backfile.strip().split("\n")[-1]
        write_logger(logfile).info('backup file: %s' % backfile)
        if not backfile:
            write_logger(logfile).info('no backup file')
            sys.exit()
        return backuppath,backfile
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()

def dealwithstr(s):
    try:
        s = s.strip().split("\n")
        return s
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()

def checkstat(ssharg):
    try:
        dic = import_export.Base_bk().returnpara()
        check_stat = "%s/%s node status --%s --host=%s:%s"%(dic["bindir"],import_export.binname,dic['securemode'],import_export.init_ip,import_export.init_port)
        print(check_stat)
        resstat = ssh.myssh(check_stat,ssharg)
        stat = dealwithstr(resstat)
        nodestat = {}
        for i in stat[1:]:
            j = i.strip().split('\t')
            nodestat[j[0]] = [j[1],j[-2],j[-1]]
            assert nodestat[j[0]][1] ==  nodestat[j[0]][2] == 'true','node %s status error' %(nodestat[j[0]][0])
            write_logger(logfile).info("node %s is in the correct state" % nodestat[j[0]][0])
        print('All nodes are in the correct state')
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()


def querystore():
    try:
        dic = import_export.Base_bk().returnpara()
        cmd = 'select node_id,args,address from dbms_internal.kv_node_status;'
        ssharg = [dic['host'],dic['sshport'],dic['user'],dic['sshpassword']]
        ret = dealwithstr(ssh.myssh(execcmd(cmd,dic['host'],dic['dbport']),ssharg))[1:]
        store = {}
        for i in ret:
            infos = i.strip().split('\t')
            tmp = eval(infos[1]).strip().split(',')
            for j in tmp:
                if '--store=' in j:
                    store[infos[0]] = j.strip().split('=')[1]
                    break
        write_logger(logfile).info('store Successfully obtained')
        return store
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()

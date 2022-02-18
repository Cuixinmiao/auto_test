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
    from factory.backup_restore import ssh
    from factory.backup_restore import backup_restore
except Exception as e:
    sys.path.append(syspath)
    from factory.collect import write_logger
    from factory.conf import *
    from factory.backup_restore import ssh
    from factory.backup_restore import backup_restore

def configset(configname, configitem):
    """
    获取配置文件
    @param configname:配置文件名称
    @param configitem:配置文件内的大项
    @return:返回（数据库名，用户，密码，主机IP，）
    """
    try:
        configname = configname
        configitem = configitem
        parent_dir = os.path.dirname(os.path.abspath(__file__))
        fatherpath = os.path.abspath(os.path.join(parent_dir, "../"))
        confpath = os.path.join(fatherpath, "conf")
        conffile = os.path.join(confpath, "config%s.txt" % configname)
        config = configparser.ConfigParser()
        config.read(conffile)
        datebase = config.get(configitem, "dbname").strip()
        user = config.get(configitem, "user").strip()
        password = config.get(configitem, "password").strip()
        host = config.get(configitem, "host").strip()
        dbport = config.get(configitem, "dbport").strip()
        sshport = config.get(configitem, "sshport").strip()
        bindir = config.get(configitem, "bindir").strip()
        write_logger(logfile).info('The corresponding configuration parameters of the database are successfully obtained')
        return (datebase, user, password, host, dbport, sshport, bindir)
    except Exception as e:
        write_logger(logfile).error('The corresponding configuration parameters of the database are unsuccessfully obtained --errmsg:%s' %e)
        sys.exit()



def querySQL(sqlcommand, *arg):
    """
    查询类SQL语句
    @param sqlcommand:sql命令
    @param database:数据库名
    @param user:用户
    @param password:密码
    @param host:主句IP
    @param port:端口号
    @return:返回查询结果
    """
    try:
        conn = psycopg2.connect(database=arg[0][0], user=arg[0][1], password=arg[0][2], host=arg[0][3], port=arg[0][4])
        cursor = conn.cursor()
        cursor.execute(sqlcommand)
        results = cursor.fetchall()
        conn.commit()
        conn.close()
        write_logger(logfile).info('Successful query')
        return results
    except Exception as e:
        write_logger(logfile).error("%s --exec failed --errmsg:%s" % (sqlcommand, e))
        sys.exit()


def otherSQL(sqlcommand, *arg):
    try:
        conn = psycopg2.connect(database=arg[0][0], user=arg[0][1], password=arg[0][2], host=arg[0][3], port=arg[0][4])
        cursor = conn.cursor()
        cursor.execute(sqlcommand)
        conn.commit()
        conn.close()
        write_logger(logfile).info("%s --exec successfully" % sqlcommand)
        print("%s --exec successfully" % sqlcommand)
        return None
    except Exception as e:
        write_logger(logfile).error("%s --exec failed --errmsg:%s" % (sqlcommand, e))
        sys.exit()



def transactionSQL(sqlcommand, *arg):
    """
    事务型sql
    @param sqlcommand:sql命令
    @param database:数据库名
    @param user:用户
    @param password:密码
    @param host:主机IP
    @param port:端口号
    """
    try:
        conn = psycopg2.connect(database=arg[0][0], user=arg[0][1], password=arg[0][2], host=arg[0][3], port=arg[0][4],sslmode ='require')
        conn.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_AUTOCOMMIT)
        cursor = conn.cursor()
        cursor.execute(sqlcommand)
        conn.commit()
        conn.close()
        write_logger(logfile).info("%s --exec successfully" % sqlcommand)
        print("%s --exec successfully" % sqlcommand)
        return None
    except Exception as e:
        write_logger(logfile).error("%s --exec failed --errmsg:%s" % (sqlcommand, e))
        sys.exit()



def createDatabase(dbname, *arg):
    """
    创建数据库
    @param dbname:将创建数据库名
    @param database:默认数据库名
    @param user:用户
    @param password:密码
    @param host:主机IP
    @param port:端口
    @return:返回创建数据库名
    """
    try:
        conn = psycopg2.connect(database=arg[0][0], user=arg[0][1], password=arg[0][2], host=arg[0][3], port=arg[0][4])
        cursor = conn.cursor()
        cursor.execute("create database if not exists %s ;" % dbname)
        conn.commit()
        conn.close()
        write_logger(logfile).info("database %s created successfully" % dbname)
        print("database %s created successfully" % dbname)
        return dbname
    except Exception as e:
        write_logger(logfile).error("database %s failed to create --errmsg:%s" % (dbname,e))
        sys.exit()


def dropDatabase(dbname, *arg):
    """
    删除数据库
    @param dbname:将删除数据库名
    @param database:默认数据库名
    @param user:用户
    @param password:密码
    @param host:主机IP
    @param port:端口
    @return:返回删除数据库名
    """
    try:
        conn = psycopg2.connect(database=arg[0][0], user=arg[0][1], password=arg[0][2], host=arg[0][3], port=arg[0][4])
        cursor = conn.cursor()
        cursor.execute("drop database if  exists %s cascade;" % dbname)
        conn.commit()
        conn.close()
        write_logger(logfile).info("database %s droped successfully" % dbname)
        print("database %s droped successfully" % dbname)
        return dbname
    except Exception as e:
        write_logger(logfile).error("database %s failed to drop --errmsg:%s" % (dbname, e))
        sys.exit()


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
    dic = backup_restore.Base_bk().returnpara()
    time.sleep(0.5)
    command = ('%s/qianbase sql --%s --host=%s:%s -f ' % (bindir,dic["securemode"], host, dbport)) + path
    command2 = ('%s/qianbase node status --%s --host=%s:%s' % (bindir,dic["securemode"],host, dbport)) + " | awk '{print $1,$2}'"
    with open(path, "r", encoding='UTF-8') as f:
        con = f.readline()
    d = dict(re.findall('(\w+)\((.*?)\)', con))
    return command,command2,d


def showbackups(nodeid,backdir,arg):
    backuppath = '"nodelocal://%d/%s"' % (nodeid, backdir)
    sqlcommand = ('SHOW BACKUPS IN %s;' % backuppath)
    backfile = querySQL(sqlcommand, arg)
    if not backfile:
        write_logger(logfile).info('no backup file')
        sys.exit()
    return backuppath,backfile


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


def execcmd(command,hostip=backup_restore.init_ip,dbport=backup_restore.init_port):
    try:
        dic = backup_restore.Base_bk().returnpara()
        recomm= ('%s/qianbase sql --%s --host=%s:%s -e "%s"' % (dic["bindir"],dic["securemode"], hostip, dbport,command))
        return recomm
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()

def judgecmd(job_type, ssharg, t,point='succeeded'):
    try:
        dic = backup_restore.Base_bk().returnpara()
        write_logger(logfile).info("%s start" %job_type)
        job = ssh.myssh(execcmd(jobcommand(job_type),dic['host'],dic['dbport']), ssharg)
        while job:
            job = ssh.myssh(execcmd(jobcommand(job_type),dic['host'],dic['dbport']), ssharg)
            job = job.split("\n")[1:-2]
            job = job[-1].split("\t")
            write_logger(logfile).info("%s" %job)
            print(job)
            if job[2] != 'job canceled by user' and job[2]:
                write_logger(logfile).info('%s error --errmsg:%s' % job_type, job[2])
                sys.exit()
            elif job[3] == point:
                write_logger(logfile).info('%s succeeded' % job_type)
                return job
            time.sleep(t)
        return
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()

def showbackupcmd(nodeid,backdir,ssharg):
    try:
        dic = backup_restore.Base_bk().returnpara()
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
        dic = backup_restore.Base_bk().returnpara()
        check_stat = "%s/%s node status --%s --host=%s:%s"%(dic["bindir"],backup_restore.binname,dic['securemode'],backup_restore.init_ip,backup_restore.init_port)
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
        dic = backup_restore.Base_bk().returnpara()
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


def detectckpt(ssharg):
    try:
        dic = backup_restore.Base_bk().returnpara()
        if backup_restore.Base_bk().ckpt == '1':
            ckptjobid = judgecmd("CHECKPOINT", ssharg, 3, 'running')[0]
            cancelcmd = 'cancel job %s' % (ckptjobid)
            ssh.myssh(execcmd(cancelcmd, backup_restore.init_ip, backup_restore.init_port), ssharg)
            judgecmd("CHECKPOINT", ssharg, 5, 'canceled')
            createckpt = 'create checkpoint with resolved;'
            ret = ssh.myssh(execcmd(createckpt, backup_restore.init_ip, backup_restore.init_port), ssharg,flag =1)
            if type(ret) == bytes:
                return ret
            judgecmd("CHECKPOINT", ssharg, 5, 'running')
            c = 0
            while c < 8:
                check_stat = "%s/%s primary-region show-sync-info --%s --host=%s:%s" % (dic['bindir'], backup_restore.binname, dic['securemode'], backup_restore.init_ip, backup_restore.init_port)
                t1 = ssh.myssh(check_stat, ssharg)
                time.sleep(15)
                t2 = ssh.myssh(check_stat, ssharg)
                c += 1
                if t1 != t2 and 'last checkpoint' in t1 and 'last checkpoint' in t2:
                    break
        write_logger(logfile).info('检查checkpoint是否正常走\nt1:%s \nt2:%s' %(t1,t2))
        assert t1 != t2,'checkpoint is abnormal'
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()


def detectcluster(ssharg):
    try:
        clusterid = dealwithstr(ssh.myssh(execcmd('select dbms_internal.cluster_id();', backup_restore.init_ip, backup_restore.init_port), ssharg))
        return clusterid
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()


def systbsituation(ssharg,path):
    try:
        cmd = 'use system;show tables'
        command = execcmd(cmd) + """| awk 'NR == 1 {next} {print $2}'"""
        tbs = ssh.myssh(command,ssharg).strip().split('\n')
        ssh.myssh('rm -rf %s'%(path),ssharg)
        for i in tbs:
            b = 'use %s;show create table %s;select * from %s;'% ('system',i,i)
            ssh.myssh(execcmd(b) + ' >> %s' %(path) ,ssharg)
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()


def tablestructure(ssharg,newdb='bankdb', tabname='accounts'):
    try:
        command = 'use %s;show create table %s' % (newdb, tabname)
        res = dealwithstr(ssh.myssh(execcmd(command, backup_restore.init_ip, backup_restore.init_port), ssharg))
        return res
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()

def tabledata(ssharg,newdb='bankdb', tabname='accounts'):
    try:
        command = 'use %s;select * from %s' % (newdb, tabname)
        res = dealwithstr(ssh.myssh(execcmd(command, backup_restore.init_ip, backup_restore.init_port), ssharg))
        return res
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()



def schcommand(schename):
    """
    @param schename: schedule name
    @return:
    """
    try:
        command = "SELECT id,schedule_status FROM [SHOW SCHEDULES] WHERE label  = '%s';" % schename
        return command
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()



def judgesch(schename, ssharg, t,point='ACTIVE'):
    try:
        dic = backup_restore.Base_bk().returnpara()
        write_logger(logfile).info("%s start" %schename)
        j = 0
        while j < 10:
            j += 1
            c = 0
            sch = ssh.myssh(execcmd(schcommand(schename),dic['host'],dic['dbport']), ssharg)
            sch = sch.split("\n")[1:-2]
            if not sch:
                print('drop schedule successfully')
                write_logger(logfile).info("drop schedule  Successfully")
                return sch
            for i in sch:
                c += 1
                if point not in i:
                    write_logger(logfile).info("%s status" %(str(i.split('\t'))))
                    print(i.split('\t'))
                    time.sleep(t)
                    break
            else:
                print([k.split('\t') for k in sch])
                write_logger(logfile).info("%s status" %(str([k.split('\t') for k in sch])))
                break
        return c
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()

def schcreate(schename,nodeid,backdir,with_para_bk,incretime,fulltime):
    try:
        bakcommand = "CREATE SCHEDULE %s for BACKUP INTO 'nodelocal://%s/%s'  %s RECURRING '*/%d * * * *'  full backup '*/%d * * * *' WITH SCHEDULE OPTIONS first_run = 'now';" % (
            schename, nodeid, backdir, with_para_bk, incretime, fulltime)
        return bakcommand
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()

def schoper(schename,operate):
    try:
        pausecmd = "%s SCHEDULES SELECT id FROM [SHOW SCHEDULES] WHERE label = '%s';" % (operate,schename)
        return pausecmd
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)
        sys.exit()



def updateFile(file, old_str='advertise-addr',addandsub = 1):
    try:
        if addandsub not in [1,-1]:
            write_logger(logfile).info("addandsub Incorrect: %d" % addandsub)
        with open(file, "r", encoding="utf-8") as f1, open("%s.bak" % file, "w", encoding="utf-8") as f2:
            for line in f1:
                if old_str in line:
                    tmp = int(line.strip()[-1]) + addandsub
                    if tmp < 0:
                        write_logger(logfile).info("The number of instances cannot be reduced : %d" % tmp)
                        sys.exit()
                    line = line.strip()[:-1] + str(int(line.strip()[-1]) + addandsub) + '\n'
                f2.write(line)
        os.remove(file)
        os.rename("%s.bak" % file, file)
    except Exception as e:
        write_logger(logfile).error("--errmsg:%s" % e)







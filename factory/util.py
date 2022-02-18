# -*- coding:utf8 -*-
#################################
#date :2021-09-15
#func  :util.py common method filediff andfilesize,list dir
#author :Xinmiao Cui
#copyright : esygn
#################################
#!/usr/bin/python

import os
import sys
import shutil


"""获取文件的大小"""
def file_size(file):
    try:
        if os.path.getsize(file):
            return True
        else:
            return False
    except Exception as e:
        return False

"""删除文件"""
def remove_file(filepath):
    try:
        if os.path.exists(filepath):
            if os.path.isdir(filepath):
                shutil.rmtree(filepath)
            else:
                os.remove(filepath)
        else:
            pass
    except Exception as e:
        pass



"""判断两个文件对比"""
def diff_exp_data(exp,data,diff):
    if not file_size(exp) and not file_size(data):
        return(True,"%s & %s not exist"%(exp,data))
    elif not file_size(exp):
        return(False,"%s null"%(exp))
    elif not file_size(data):
        return(False,"%s null"%(data))
    else:
        os.system("diff -Ewa %s %s >%s"%(exp,data,diff))
    if file_size(diff):
        return(False,"diff %s"%diff)
    else:
        remove_file(diff)
        return(True,"")

"""获取目录下的所有文件"""
def listdir_nohidden(path):
    dirf = os.listdir(path)
    for f in dirf:
        if f.startswith("."):
            dirf.remove(f)
    return dirf
if __name__ == "__main__":
    pass

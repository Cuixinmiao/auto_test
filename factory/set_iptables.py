# -*- coding:utf8 -*-
#################################
#date :2022-01-13
#func  :set_iptables.py
#author :Xinmiao Cui
#copyright : esygn
#################################
#!/usr/bin/python
import os
import sys
import time

try:
    from factory.conf import *
    from factory import testcase
    from factory import rmt
    from factory.collect import write_logger
    from factory.testcase import Testcase
except Exception as e:
    sys.path.append(syspath)
    from factory.conf import *
    from factory import rmt
    from factory import testcase
    from factory.collect import write_logger
    from factory.testcase import Testcase


"""set iptables policy"""
def set_iptables_policy(ip,instinfo):
    input_cmd = "iptables -I INPUT -s %s -j DROP"
    output_cmd = "iptables -I OUTPUT -s %s -j DROP"
    for key in instinfo:
        rmt.exec_cmd(input_cmd%key,ip)
        rmt.exec_cmd(output_cmd%key,ip)

    rmt.exec_cmd("iptables -nL --line-number",ip)
    #rmt.exec_cmd("ping %s -c 5"%key,ip)

def set_iptables_reject_policy(ip,instinfo):
    input_cmd = "iptables -I INPUT -s %s -j REJECT"
    output_cmd = "iptables -I OUTPUT -s %s -j REJECT"
    for key in instinfo:
        rmt.exec_cmd(input_cmd%key,ip)
        rmt.exec_cmd(output_cmd%key,ip)

    rmt.exec_cmd("iptables -nL --line-number",ip)
    #rmt.exec_cmd("ping %s -c 5"%key,ip)


"""del iptables policy"""
def del_iptables_policy(ip,instinfo):
    input_cmd = "iptables -D INPUT 1"
    output_cmd = "iptables -D OUTPUT 1"
    for key in instinfo:
        rmt.exec_cmd(input_cmd,ip)
        rmt.exec_cmd(output_cmd,ip)


"""chaosblade set netpatition"""
def set_blade_patition():
    pass


if __name__ == '__main__':
    pass

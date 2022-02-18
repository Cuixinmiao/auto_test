#!/bin/sh

function show_ckpt()
{       
        biname=$1
        filename=$2
        ip_start=$3
        ip_end=$4
        if [[ -z ${ip_start} && -z {$ip_end} ]];then
                ip_start=110
                ip_end=116
        fi
        port_start=$5
        port_end=$6
        if [[ -z ${ip_start} && -z {$ip_end} ]];then
                port_start=26287
                port_end=26292
        fi
        echo $binname,$filename,$ip_start,$ip_end,$port_start,$port_end
        
        for i in `seq ${ip_start} ${ip_end}`
                do      
                        for j in `seq ${port_start} ${port_end}`
                                do      
                                        #echo "${i}:${j} checkpoint time start"
                                        info="`${binname}/qianbase primary-region show-sync-info --certs-dir=/GM_CA/certs --host=10.14.41.${i}:${j}|grep "checkpoint:"|awk -F"checkpoint:" '{print substr($2,1,22)}'`" & pids="$pids $!"
                                        echo "${i}:${j} ${info}" >>${filename}
                                        #echo "${i}:${j} checkpoint time end"
                                done
                done
	wait $pids
}
function  get_rid1_ckpt_min(){
        regionid=$1
        if [[ -z ${regionid} ]];then
                exit 1
        fi
        #ridinfo="`${binname}/qianbase node status --certs-dir=/GM_CA/certs --host=10.14.40.101:20158|grep "rid=1"|awk '{{split($2,a,":")};{print $2,a[1],a[2]}}'|sort`"
        ridinfo="`${binname}/qianbase node status --certs-dir=/GM_CA/certs --host=10.14.41.109:20158|grep ${regionid}|awk '{{split($2,a,":")};{print $2}}'|sort`"
        min_time=9999999999
        lst_tim=""
        for ipport in ${ridinfo}
        do
                #echo ${ipport}
                info="`${binname}/qianbase primary-region show-sync-info --certs-dir=/GM_CA/certs --host=${ipport}|grep "checkpoint:"|awk -F"checkpoint:" '{print substr($2,1,20)}'`"
                if [[ -z ${lst_time} ]];then
                        lst_time=${info}
                else
                        lst_time=${lst_time}" "${info}
                fi
                tmp=${info:0:10}
                #echo ${tmp}
                if [[ ${min_time} -gt ${tmp} ]];then
                                min_time=${tmp}
                fi
        done
        #echo "min_time:${min_time}"
        #echo "lst_time:${lst_time}"
        for m in ${lst_time}
                do
                        tmp1=${m:0:10}
                        if [[ ${min_time} -eq ${tmp1} ]];then
                                min_last=${m}
                                break
                        fi
                done
        echo "min_last:${min_last}"

}


function  get_offline_ckpt_min(){
        regionid=$1
        if [[ -z ${regionid} ]];then
                regionid="110 111 112"
        fi

        min_time=9999999999
        lst_tim=""
        for ip in ${regionid}
        do
                #echo ${ipport}
                info1=`ssh 10.14.41.${ip} "/usr/bin/qianbase debug last-checkpoint /data1/node|grep checkpoint:"`
		echo $info1
		info=`echo ${info1}|awk -F"checkpoint:" '{print substr($2,1,23)}'`
		echo "info ${info}"
                if [[ -z ${lst_time} ]];then
                        lst_time=${info}
                else
                        lst_time=${lst_time}" "${info}
                fi
                tmp=${info:0:11}
                echo ${tmp}
                if [[ ${min_time} -gt ${tmp} ]];then
                                min_time=${tmp}
                fi
        done
        #echo "min_time:${min_time}"
        #echo "lst_time:${lst_time}"
        for m in ${lst_time}
                do
                        tmp1=${m:0:10}
                        if [[ ${min_time} -eq ${tmp1} ]];then
                                min_last=${m}
                                break
                        fi
                done
        echo "min_last:${min_last}"

}
#function run_show_ckpt()
#{
binname=/home/cxm/qianbase-xtp-test/tools/
filename=checkpoint.txt
if [[  $# -eq 1 ]];then
        binname=$1
elif [[ $# -eq 2 ]];then
        binname=$1
        filename=$2
fi

start_time="`date +%s`"
if [[ -f ${filename} ]];then
        mv ${filename} ${filename}${start_time}
fi

show_ckpt ${binname} $filename 110 116 26287 26289

binname=/home/cxm/qianbase-xtp-test/tools/
#get_rid1_ckpt_min "rid=1"
#get_offline_ckpt_min "113 114 115"


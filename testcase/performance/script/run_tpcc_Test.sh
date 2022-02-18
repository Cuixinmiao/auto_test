#!/bin/bash
if [ $# -ne 14 ];then
	echo ">>>args nums errors"
        echo ">>>please input the [iplist] [warehouses] and [workers]  and [rack ] [url] [pretime] [runtime] [waittime] [init_ip_port] [nproc] [maxconn] [connectimetou] [client timeout] [server timeout]"
        exit
fi

iplist=$1
ip_array=(${iplist//,/ })


wh=$2
work=$3
rack=$4
url=$5
pretime=$6
runtime=$7
waittime=$8
#scriptpath=$9
init_ip_port=$9
nproc=${10}
maxconn=${11}
conntimeout=${12}
clienttimeout=${13}
servertimeout=${14}
cur_path=`pwd`
#cur_path=$(cd `dirname $0`; pwd)

if [[ ! -d "$cur_path/performance_logs" ]];then
	mkdir -p $cur_path/performance_logs
fi

clearenv_Setup(){
	#kill all qianbase 
        for ip in ${ip_array[@]}
        do
                echo ">>>clear machine env: "$ip
                ssh $ip "ps -ef | grep qian | grep -v grep | awk '{print \$2}' |xargs kill -9"
                ssh $ip "ps -ef | grep qian | grep -v grep | awk '{print \$2}'"
                ssh $ip "rm -rf /data1/* /data2/* /data3/* /data4/* "
        done

        echo ">>>clear env finish!"
	#scp qianbase binary to remote machine /usr/local/bin

	echo ">>>scp qianbase binary start..."
	for ip in ${ip_array[@]}
        do
                scp "$cur_path/tools/qianbase" root@$ip:/usr/local/bin/
        done
        echo ">>>scp qianbase binary remote to /usr/local/bin  finish!"


        for ip2 in ${ip_array[@]}
        do
                #exec start_qianbase shell
                scp "$cur_path/testcase/performance/script/startQianbaseScript/start_Qianbase_$ip2.sh" root@$ip2:/root/
                ssh $ip2 "sh /root/start_Qianbase_$ip2.sh  > start_Qianbase_$ip2.log 2>&1"
                echo ">>>start $ip2 server finish!"
        done

}
#init cluster env

init_env(){
	echo ">>>qianbase --host=${init_ip_port}"
        qianbase init --insecure --host=${init_ip_port}
        echo ">>>init cluster finish!"
}


#check cluster status
check_status(){
        qianbase node status --insecure --host=${init_ip_port}
        echo ">>>check status finish!"
}

set_haproxy(){
  #systemctl stop haproxy
  qianbase gen haproxy --insecure --host=${init_ip_port}
  sed -i '1,$s/maxconn 4096/nbproc '"${nproc}"' \n maxconn '"${maxconn}"'/g' haproxy.cfg
  sed -i '1,$s/timeout connect.*$/timeout connect     '"${conntimeout}"'s/g' haproxy.cfg
  sed -i '1,$s/timeout client.*$/timeout client      '"${clienttimeout}"'m/g' haproxy.cfg
  sed -i '1,$s/timeout server.*$/timeout server      '"${servertimeout}"'m/g' haproxy.cfg
  sleep 1
  mv haproxy.cfg /etc/haproxy/haproxy.cfg
  sleep 1
  systemctl restart haproxy
  sleep 2
  systemctl status haproxy
  ps -ef | grep haproxy

  echo ">>>haproxy set finish!"
}

load()
{
  time qianbase workload init tpcc --drop --warehouses=${wh} --partitions=${rack} --data-loader IMPORT ${url}
}

setcluterargs()
{
  qianbase sql --insecure --host=${init_ip_port} --user=root -e "SET CLUSTER SETTING rocksdb.ingest_backpressure.l0_file_count_threshold = 100;SET CLUSTER SETTING schemachanger.backfiller.max_buffer_size = '5 GiB';SET CLUSTER SETTING kv.snapshot_rebalance.max_rate = '128 MiB';SET CLUSTER SETTING rocksdb.min_wal_sync_interval = '1000us';SET CLUSTER SETTING kv.range_merge.queue_enabled = false;"
  qianbase sql --insecure --host=${init_ip_port} --user=root -e "set cluster setting kv.allocator.load_based_lease_rebalancing.enabled=false;set cluster setting kv.allocator.load_based_rebalancing=0;set cluster setting kv.range_merge.queue_enabled=false;set cluster setting kv.range_split.by_load_enabled=false;set cluster setting kv.allocator.lease_rebalancing_aggressiveness=0;set cluster setting kv.allocator.range_rebalance_threshold=0;"

}

preheat(){
	#ulimit -n 100000 && qianbase workload run tpcc --warehouses=${wh} --workers=${work} --partitions=${rack} --ramp=1ms --duration=10m --wait=false 'qianbase://root@localhost:20158?sslmode=disable'
	ulimit -n 100000 && qianbase workload run tpcc --warehouses=${wh} --workers=${work} --partitions=${rack} --ramp=1ms --duration=${pretime}m --wait=false ${url}
#	sleep ${waittime}
}

start_nmon(){
	for ip in ${ip_array[@]}
        do
                 ssh $ip "nmon -f -s 20 -c $((${runtime}*60/20))" &
        done
}

run_tpcc()
{
	#clear memory
	for ip in ${ip_array[@]}
        do
		ssh $ip "echo 3 >/proc/sys/vm/drop_caches"
		echo ">>>exec $ip echo 3 >/proc/sys/vm/drop_caches."
		sleep 3
	done

	sleep 5
 	ulimit -n 100000 && qianbase workload run tpcc --warehouses=${wh} --workers=${work} --partitions=8 --wait=false --duration=${runtime}m  ${url}
}


echo ">>>exec init_testEnv.sh  init test env start...."
#sh ${scriptpath}/init_testEnv.sh $iplist
clearenv_Setup
init_env
sleep 10
check_status
set_haproxy

echo ">>>exec init_testEnv.sh  init test env end...."

echo ">>>set cluster args...."
setcluterargs
echo "SET CLUSTER SETTING rocksdb.ingest_backpressure.l0_file_count_threshold = 100;SET CLUSTER SETTING schemachanger.backfiller.max_buffer_size = '5 GiB';SET CLUSTER SETTING kv.snapshot_rebalance.max_rate = '128 MiB';SET CLUSTER SETTING rocksdb.min_wal_sync_interval = '1000us';SET CLUSTER SETTING kv.range_merge.queue_enabled = false;"
echo ">>>set cluster args end."

sleep 5

generate_license()
{
	qianbase sql --insecure --host=10.14.40.152:26287 |tee clusterid.log &
        sleep 5
        clusterid=`grep -ri 'cluster id' clusterid.log |awk '{print $4}'`
        echo ${clusterid}
        license=`tools/license gen -y 1 ${clusterid}`
        echo $license
        qianbase sql --insecure --host=${init_ip_port} -e "set cluster setting enterprise.license='${license}'"
}
echo ">>>generate license start...."
generate_license
echo ">>>generate license end...."

echo ">>>load ${wh} warehouse data start..."
#sh ${cur_path}/load_tpcc.sh ${wh} ${work} ${rack}
load >${cur_path}/performance_logs/load_${wh}_${work}_${rack}_partiton.log 2>&1
echo ">>>load ${wh} warehouse data end..."


echo ">>>pre heat data start...."
preheat > ${cur_path}/performance_logs/preheat_${wh}_${work}_${rack}_partiton.log 2>&1

#skipres=`grep -i 'skip' ${cur_path}/performance_logs/preheat_${wh}_${work}_${rack}_partiton.log`
#failres=`grep -i 'fail' ${cur_path}/performance_logs/preheat_${wh}_${work}_${rack}_partiton.log`
#if [[ $skipres!="" && $failres!="" ]];then
#	echo ">>>preheat test result include SKIP or FAIL,please stop test."
#fi
echo ">>>preheat data end. please wait sleep time: ${waittime}s"
sleep ${waittime}


echo ">>>start nmon ..."
start_nmon

echo ">>>run tpcc workload test start..."
run_tpcc > ${cur_path}/performance_logs/run_${wh}_${work}_${rack}_partiton.log 2>&1
echo ">>>run tpcc workload test end..."

#将log中的tpmc值写入到result/result.res file中,并且备份历史结果
write_res()
{
	resultpath=${cur_path}/testcase/performance/result
	result_bakpath=${resultpath}/history_result_backup
	resultfile=${resultpath}/result_$(date "+%Y%m%d%H%M%S").res

	if [ -d "${result_bakpath}" ];then
                mv ${resultpath}/result_*.res ${result_bakpath}
 	        #sleep 2
		echo "Test Finish Time:$(date "+%Y%m%d%H%M%S")" >> $resultfile
	        echo "Tpmc values is:" >> $resultfile
        	tail -n 1 ${cur_path}/performance_logs/run_${wh}_${work}_${rack}_partiton.log |awk 'END {print $2}' >> $resultfile
	else
        	mkdir -p ${result_bakpath}
        	mv ${resultpath}/result_*.res ${result_bakpath}
                sleep 2
	        echo "Test Finish Time:$(date "+%Y%m%d%H%M%S")" >> $resultfile
	        echo "Tpmc values is:" >> $resultfile
        	tail -n 1 ${cur_path}/performance_logs/run_${wh}_${work}_${rack}_partiton.log |awk 'END {print $2}' >> $resultfile

	fi
}
write_res

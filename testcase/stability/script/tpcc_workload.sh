#!/bin/sh

concurrency=$1
runtime=$2
wh=4000
cur_path=`pwd`
url=$3
result=$4
#iplist="10.14.40.152,10.14.40.153,10.14.40.154,10.14.40.155"


if [[ ! -d "$cur_path/stable_logs" ]];then
        mkdir -p $cur_path/stable_logs
fi

execptionstr="_elapsed_______tpmC____efc__avg(ms)__p50(ms)__p90(ms)__p95(ms)__p99(ms)_pMax(ms)"
load_run_workload(){
 	qianbase workload init tpcc --drop --warehouses=${wh}  --data-loader IMPORT ${url}
        ulimit -n 100000 && qianbase workload run tpcc --warehouses=${wh} --workers=${concurrency} --ramp=1m --wait=false --duration=${runtime}m  ${url}
}


assertTest(){
	resultfile=${cur_path}/stable_logs/run_tpcc_`date +%Y%m%d`.log
        load_run_workload > $resultfile 2>&1
        actval=`grep $execptionstr $resultfile`
	skipres=`grep -i 'skip' $resultfile`
	failres=`grep -i 'fail' $resultfile` 
	errorres=`grep 'Error' $resultfile`

        #if [ "${actval}" == "${execptionstr}" && ${skipres} == "" && ${failres} == "" && ${errorres} == "" ];then
        if [[ "${actval}" == "${execptionstr}" && ${skipres} == "" && ${failres} == "" && ${errorres} == "" ]];then
                echo ">>>tpcc workload test pass." > ${result}
        else
                echo ">>>tpcc workload test fail." > ${result}
        fi
}
main(){
	#bank workload test
	assertTest
}

main

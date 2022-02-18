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

execptionstr="_elapsed___errors_____ops(total)___ops/sec(cum)__avg(ms)__p50(ms)__p95(ms)__p99(ms)_pMax(ms)__result"
load_run_workload(){
	qianbase workload init bank --drop --rows=1000000 ${url}
	qianbase workload run bank --duration=${runtime}m --concurrency=${concurrency} --tolerate-errors ${url}
}


assertTest(){
	resultfile=${cur_path}/stable_logs/run_bank_`date +%Y%m%d`.log
        load_run_workload > $resultfile 2>&1
        actval=`grep $execptionstr $resultfile`
	skipres=`grep -i 'skip' $resultfile`
	failres=`grep -i 'fail' $resultfile` 
	errorres=`grep 'Error' $resultfile`

        #if [ "${actval}" == "${execptionstr}" && ${skipres} == "" && ${failres} == "" && ${errorres} == "" ];then
        if [[ "${actval}" == "${execptionstr}" && ${skipres} == "" && ${failres} == "" && ${errorres} == "" ]];then
                echo ">>>bank workload test pass." > ${result}
        else
                echo ">>>bank workload test fail." > ${result}
        fi
}
main(){
	#bank workload test
	assertTest
}

main

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

load_run_workload(){
	qianbase workload init startrek --drop ${url}
        qianbase sql --insecure -d startrek --host=10.14.40.152:26287 -e "SELECT * FROM startrek.episodes WHERE stardate > 5500;"
}


assertTest(){
        expectval="79   3       24      Turnabout Intruder      5928.5"
        startrek_resultfile=${cur_path}/stable_logs/run_startrek_`date +%Y%m%d`.log
        load_run_workload > $startrek_resultfile 2>&1
        actval=`grep -i 'Turnabout' $startrek_resultfile`
	#echo ${actval}
        #actval=`grep $expectval $startrek_resultfile`
        skipres=`grep -i 'skip' $startrek_resultfile`
        failres=`grep -i 'fail' $startrek_resultfile`
        errorres=`grep 'Error' $startrek_resultfile`

        #if [ "${actval}" == "${execptionstr}" && ${skipres} == "" && ${failres} == "" && ${errorres} == "" ];then
        if [[ "${actval}" != "" && ${skipres} == "" && ${failres} == "" && ${errorres} == "" ]];then
                echo ">>>startrek workload test pass." > ${result}
        else
                echo ">>>startrek workload test fail." > ${result}
        fi
}
main(){
	#bank workload test
	assertTest
}

main

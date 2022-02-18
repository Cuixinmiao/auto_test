#!/bin/sh

concurrency=$1
runtime=$2
wh=4000
cur_path=`pwd`
url=$3
#iplist="10.14.40.152,10.14.40.153,10.14.40.154,10.14.40.155"


if [[ ! -d "$cur_path/logs" ]];then
        mkdir -p $cur_path/logs
fi

execptionstr="_elapsed___errors_____ops(total)___ops/sec(cum)__avg(ms)__p50(ms)__p95(ms)__p99(ms)_pMax(ms)__result"
tpccexecption="_elapsed_______tpmC____efc__avg(ms)__p50(ms)__p90(ms)__p95(ms)__p99(ms)_pMax(ms)"
load_run_bank_workload(){
	qianbase workload init bank --drop --rows=1000000 ${url}
	qianbase workload run bank --duration=${runtime}m --concurrency=${concurrency} ${url}
}

load_run_kv_workload(){
	qianbase workload init kv --drop --concurrency=100 --batch=1 ${url}
	qianbase workload run kv --drop --ramp=1ms --duration=${runtime}m --concurrency=${concurrency} ${url}
}
#
load_run_movr_workload(){	
        qianbase workload init movr --drop --data-loader import ${url}
        qianbase workload run movr --concurrency=${concurrency} --duration=${runtime}m ${url}
}

load_startrek_workload(){
	qianbase workload init startrek --drop ${url}
	qianbase sql --insecure -d startrek -e "SELECT * FROM startrek.episodes WHERE stardate > 5500;"
}

load_run_ycsb_workload(){
	qianbase workload init ycsb --drop --insert-count 1000000 --data-loader import ${url}
	qianbase workload run ycsb --duration=${runtime}m --families --histograms --concurrency=${concurrency} ${url}
}

load_run_tpcc_workload(){
	qianbase workload init tpcc --drop --warehouses=${wh}  --data-loader IMPORT ${url}
	ulimit -n 100000 && qianbase workload run tpcc --warehouses=${wh} --workers=${concurrency} --ramp=1m --wait=false --duration=${runtime}m  ${url}
}

assertBankTest(){
	echo ">>>bank workload test start..." >> "../result/bank_worlk.res"
        bank_resultfile=${cur_path}/logs/run_bank_`date +%Y%m%d`.log
        load_run_bank_workload > $bank_resultfile 2>&1
        actval=`grep $execptionstr $bank_resultfile`

        if [ "${actval}" == "${execptionstr}" ];then
                echo ">>>bank workload test pass." >> "../result/bank_worlk.res"
        else
                echo ">>>bank workload test fail." >> "../result/bank_worlk.res"
        fi
}

assertKvTest(){
        echo ">>>kv workload test start..." >> "../result/kv_worlk.res"
        kv_resultfile=${cur_path}/logs/run_kv_`date +%Y%m%d`.log
        load_run_kv_workload > $kv_resultfile 2>&1
        actval=`grep $execptionstr $kv_resultfile`

        if [ "${actval}" == "${execptionstr}" ];then
                echo ">>>kv workload test pass." >> "../result/kv_worlk.res"
        else
                echo ">>>kv workload test fail." >> "../result/kv_worlk.res"
        fi
}
assertMovrTest(){
        echo ">>>movr workload test start..." >> "../result/movr_worlk.res"
        movr_resultfile=${cur_path}/logs/run_movr_`date +%Y%m%d`.log
        load_run_movr_workload > $movr_resultfile 2>&1
        actval=`grep $execptionstr $movr_resultfile`

        if [ "${actval}" == "${execptionstr}" ];then
                echo ">>>movr workload test pass." >> "../result/movr_worlk.res"
        else
                echo ">>>movr workload test fail." >> "../result/movr_worlk.res"
        fi
}

assertStartrekTest(){
	expectval="79	3	24	Turnabout Intruder	5928.5"
        echo ">>>startrek workload test start..." >> "../result/startrek_worlk.res"
        startrek_resultfile=${cur_path}/logs/run_startrek_`date +%Y%m%d`.log
        load_startrek_workload > $startrek_resultfile 2>&1
        actval=`grep 'Turnabout' $startrek_resultfile`
	#echo $actval
	echo $expectval
	
        if [[ "${actval}" == "$expectval" ]];then 
                echo ">>>startrek workload test pass." >> "../result/startrek_worlk.res"
        else
                echo ">>>startrek workload test fail." >> "../result/startrek_worlk.res"
        fi
}
assertYcsbTest(){
        echo ">>>ycsb workload test start..." >> "../result/ycsb_worlk.res"
        yscb_resultfile=${cur_path}/logs/run_ycsb_`date +%Y%m%d`.log
        load_run_ycsb_workload > $yscb_resultfile 2>&1
        actval=`grep $execptionstr $yscb_resultfile`

        if [ "${actval}" == "${execptionstr}" ];then
                echo ">>>yscb workload test pass." >> "../result/ycsb_worlk.res"
        else
                echo ">>>yscb workload test fail." >> "../result/ycsb_worlk.res"
        fi
}

assertTpccTest(){
	echo ">>>tpcc workload test start..." >> "../result/tpcc_worlk.res"
	tpcc_resultfile=${cur_path}/logs/run_tpcc_`date +%Y%m%d`.log
#	sh ${cur_path}/tpcc_workload.sh $iplist ${concurrency} ${runtime} 4000
	load_run_tpcc_workload > $tpcc_resultfile 2>&1
	actval=`grep $tpccexecption $tpcc_resultfile`

        if [ "${actval}" == "${tpccexecption}" ];then
                echo ">>>tpcc workload test pass." >> "../result/tpcc_worlk.res"
        else
                echo ">>>tpcc workload test fail." >> "../result/tpcc_worlk.res"
        fi

}

main(){
	
	#init xtp server env
	#echo ">>>init test env start..."
	#sh ${cur_path}/init_testEnv.sh $iplist
	#echo ">>>init test env finish."

	#bank workload test
	assertBankTest

	#vk workload test
	assertKvTest

	#movr workload test
	assertMovrTest

	#startrek workload test
	assertStartrekTest
	
	#ycsb workload test
	assertYcsbTest
	
	#tpcc workload test
	assertTpccTest		

}

main

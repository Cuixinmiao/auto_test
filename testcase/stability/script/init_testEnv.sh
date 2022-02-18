#!/bin/bash
if [ $# -ne 2 ];then
        echo ">>>args nums errors"
        echo ">>>please input the [iplist] [init_ip_port]"
        exit
fi

iplist=$1
ip_array=(${iplist//,/ })

#scriptpath=$9
init_ip_port=$2
cur_path=`pwd`

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
                scp "$cur_path/testcase/stability/script/startQianbaseScript/start_Qianbase_$ip2.sh" root@$ip2:/root/
                ssh $ip2 "sh /root/start_Qianbase_$ip2.sh  > start_Qianbase_$ip2.log 2>&1"
                echo ">>>start $ip2 server finish!"
        done

}
#init cluster env

init_env(){
        qianbase init --insecure --host=${init_ip_port}
        echo ">>>init cluster finish!"
}


#check cluster status
check_status(){
        qianbase node status --insecure --host=${init_ip_port}
        echo ">>>check status finish!"
}

clearenv_Setup

init_env
sleep 2

check_status

sleep 2

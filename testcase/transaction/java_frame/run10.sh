#!/bin/bash

for i in {1..11}
do
	rm -rf result$i
	mkdir result$i

	./build.sh

	cat list.txt|while read line
	do
		/usr/bin/java -cp ./qianbase-2.2.0-SNAPSHOT.jar:./ QianBaseTxnTestTool ./sql/${line}.sql &>./result${i}/${line}.sql.res
	done

done


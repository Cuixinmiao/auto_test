#!/bin/bash
rm -rf result
mkdir result

./build.sh

cat list.txt|while read line
do
	./run.sh $line
done


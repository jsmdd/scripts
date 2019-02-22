#!/bin/bash
for i in {1..100};do
	a=$[$i%7]
	if [ $a -eq 0 ];then
		echo $i
	fi
done

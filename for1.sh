#!/bin/bash
a=0
for i in {1..100}
do	
	if [ $[i%2] = 0 ];then
	let a=a+i
	fi
done
	echo $a

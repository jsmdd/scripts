#!/bin/bash
for i in `seq 1 100`;do
	a=`factor $i|cut -d " " -f2`
	[ $a == $i ]&&echo -e "\033[93m$i\033[0m"
	sleep 0.02
done

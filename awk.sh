#!/bin/bash
read -p "数字：" pass
case $pass in
[0-9]+[0-9])
	a=`echo $pass | awk -F "+" '{print $1"\n"$2}'|head -1`
        b=`echo $pass | awk -F "+" '{print $1"\n"$2}'|tail -1`
	echo $b $a
	;;
*)
	echo cuo
	;;
esac

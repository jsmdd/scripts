#!/bin/bash
read -p "请输入你要下的注数:" pass
hongqiu=({1..33})
lanqiu=({1..16})
reds=()
bules=()
case $pass in
[0-9])
	echo "请支付$[$pass*2]元"
	until [ $pass -eq 0 ];do
		j=0
        	while :;do
                	red=$[RANDOM%33]
                	[ -n "${hongqiu[$red]}" ] && reds[$j]=`echo ${hongqiu[$red]}`&& unset hongqiu[$red]&&let j++
                	[[ ${#reds[*]} == 6 ]] && break
			hongqiu=({1..33})
		done
                	echo ${reds[*]} - $[RANDOM%16+1]&&let pass--
			reds=()
	done
	;;
[0-9]+[0-9])
	a=`echo $pass | awk -F "+" '{print $1"\n"$2}'|head -1`
        b=`echo $pass | awk -F "+" '{print $1"\n"$2}'|tail -1`
	if [ $a -ge 6 ]&&[ $a -le 33 ]&&[ $b -ge 1 ]&&[ $b -le 16 ];then
		j=0
        	while :;do
                	red=$[RANDOM%33]
                	[ -n "${hongqiu[$red]}" ] && reds[$j]=`echo ${hongqiu[$red]}`&& unset hongqiu[$red]&&let j++
                	[[ ${#reds[*]} == $a ]] && break
       		done
		while :;do
                	bule=$[RANDOM%16]
                	[ -n "${lanqiu[$bule]}" ] && bules[$j]=`echo ${lanqiu[$bule]}`&& unset lanqiu[$bule]&&let j++
                	[[ ${#bules[*]} == $b ]] && break
        	done

                	echo "你的复式票为:${reds[*]} - ${bules[*]}"
	else
		echo "你输错了"&&exit 
	fi
	if [ $a -eq 6 ];then
		echo "请支付$[$b*2]元"
	elif [ $a -eq 7 ];then
		echo "请支付$[$b*14]元"
	elif [ $a -eq 8 ];then
		echo "请支付$[$b*56]元"
	elif [ $a -eq 9 ];then
		echo "请支付$[$b*168]元"
	fi
	;;
*)
	echo "请支付2元"
	j=0
	while :;do
        	red=$[RANDOM%33]
        	[ -n "${hongqiu[$red]}" ] && reds[$j]=`echo ${hongqiu[$red]}`&& unset hongqiu[$red]&&let j++
        	[[ ${#reds[*]} == 6 ]] && break
	done
		echo "你的彩票：${reds[*]} - $[RANDOM%16+1]"
	;;
esac

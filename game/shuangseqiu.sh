#!/bin/bash
#hongqiu=()
#j=0
#while :;do
#	red=$[RANDOM%33+1]
#	flag=0
#	for i in "${hongqiu[@]}";do
#		[[ $i == $red ]] && flag=1 && break
#	done
#	[[ $flag == 0 ]] && hongqiu[$j]=$red && let j++
#	[[ ${#hongqiu[*]} == 6 ]] && break
#done
#echo ${hongqiu[*]} - $[RANDOM%16+1]
hongqiu=({01..33})
j=0
reds=()
while :;do
	red=$[RANDOM%33]
	[ -n "${hongqiu[$red]}" ] && reds[$j]=`echo ${hongqiu[$red]}`&& unset hongqiu[$red] && let j++
	[[ ${#reds[*]} == 6 ]] && break
done
echo ${reds[*]} - $[RANDOM%16+1]

#!/bin/bash
a=2
b=0
while [ $a -lt 51 ];do
	c=$[a%2]
	if [ $c -eq 0 ];then
		let b=a+b
	else
		let b=b-a
	fi
	let a++
done
echo $b

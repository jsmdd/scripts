#!/bin/bash
#
echo -e "\033[35;5m你从未体验过的全新版本\033[0m"
echo -e "\033[35;5m窝似渣渣辉，似兄弟狗莱砍窝\033[0m"
echo "1-100,一共有6次机会" 
total=6
answer=$[ RANDOM%100+1]
for i in {1..6};do
	read -p "你还有$total次机会,请输入你的数字:" guess
	let total--
	if [ -z "$guess" ];then
		echo "输入不能为空"
	elif ! expr $guess + 1 &> /dev/null;then
		echo "只能输入数字!"
	elif [ $guess -eq $answer ];then
		echo "对"
		exit
	elif [ $guess -gt $answer ];then
		echo "大"
	elif [ $guess -lt $answer ];then
		echo "小"
	fi
done
echo "小垃圾,答案是$answer"

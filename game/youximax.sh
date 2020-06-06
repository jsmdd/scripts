#!/bin/bash
cishu=0
daan=$[RANDOM%150+1]
echo -e "\033[34m欢迎来到花80块，买个教训的游戏\033[0m"
#echo $daan
while :;do
	read -p "展现你的想法把，骚年: " pass
	let cishu++
	cishu_1=$[cishu%8]
	abc=0
	if ! expr $pass + 1 &>/dev/null;then  # 用来判断输入参数是否为整数
		echo -e "\033[33m请输入1-150的数字，你已经用了\033[0m\033[91m$cishu次机会了\033[0m"
	elif [ -z $pass ];then
		echo -e "\033[34m你他么还不猜了？那你你别猜了\033[0m"
		exit
	elif [ $pass = $daan ];then
		echo -e "\033[93m我套你猴子的，你还真猜对了！\033[0m"
		case $cishu in
		1)
			echo -e "\033[91m喜提滚筒洗衣机一台\033[0m"
			;;
		2|3)
			echo -e "\033[91m喜提甩干机一台\033[0m"
			;;
		4|5)
			echo -e "\033[91m喜提加湿器一台\033[0m"
			;;
		*)
			echo -e "\033[91m喜提洗衣粉一袋\033[0m"
			;;
		esac
		exit
	elif [ $pass -gt $daan ];then
		echo -e "\033[33m好可惜哦，大了一点点哦,你已经用了\033[0m\033[91m$cishu次机会了\033[0m"
	elif [ $pass -lt $daan ];then
		echo -e "\033[33m好可惜哦，小了一点点哦,你已经用了\033[0m\033[91m$cishu次机会了\033[0m"
	fi
	if [ $cishu_1 -eq $abc ];then
		echo -e "\033[91m你已经失败了，答案就是$daan\033[0m"
		read -p "你还有梦想吗，骚年？如果有再次充值就可以实现你的梦想：" money
		case $money in
		80)
			cishu=0
			echo -e "\033[92m充值成功！\033[0m" && continue
			;;
		*)
			echo -e "\033[93m祝你的人生一片光明。\033[0m" && exit
			;;
		esac
	fi
done

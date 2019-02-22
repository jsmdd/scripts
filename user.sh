#!/bin/bash
echo -e "\033[92m*************************\033[0m"
echo -e "\033[92m*\033[0m\033[93m     1      注册       \033[0m\033[92m*\033[0m"
echo -e "\033[92m*\033[0m\033[93m     2      登录       \033[0m\033[92m*\033[0m"
echo -e "\033[92m*\033[0m\033[93m     3      退出       \033[0m\033[92m*\033[0m"
echo -e "\033[92m*************************\033[0m"
read -p  "请选择你的操作：" pass
while :;do
if [ $pass -eq 1 ];then
	read -p "请输入用户名：" name
	if id $name &> /dev/null;then
		echo -e "\033[91m用户$name已存在，请重新输入！\033[0m"
		continue
	else
		read -s -p "请输入密码：" mima_1
		echo
		read -s -p "请再次输入密码：" mima_2
		echo
		if [ $mima_1 -eq $mima_2 ];then
			useradd $name &>/dev/null
			echo $mima_2 | passwd --stdin $name &>/dev/null
			echo "用户：$name" >> /root/users
			echo -n $mima_2|md5sum >> /root/users
			echo "用户$name:$name" >>/root/yanzheng
			echo "$name的密码:$mima_2" >>/root/yanzheng
			echo -e "\033[93m恭喜,$name注册成功！\033[0m"
			exit
		else
			echo -e "\033[91m两次密码输入不一致，请重新输入！\033[0m"
			continue
		fi
	fi
elif [ $pass -eq 2 ];then
	read -p "请输入用户名：" name_3
	read -s -p "请输入密码：" mima_3
	echo
	abc=`cat /root/yanzheng |grep "用户$name_3"|cut -d: -f2`
	def=`cat /root/yanzheng |grep "$name_3的密码"|cut -d: -f2`
	if [ "$name_3" != "$abc" ] || [ "$mima_3" != "$def" ];then
		echo -e "\033[91m用户名或密码输入错误，请重新输入！\033[0m"
		continue
	else
		echo -e "\033[93m$name_3,欢迎回来！\033[0m"
		exit
	fi
elif [ $pass -eq 3 ];then
	exit
else 
	echo -e "\033[91m输入错误，请重新输入！\033[0m"&&read -p  "你个智障，那么大的字看不见？再输一次：" pass
fi
done

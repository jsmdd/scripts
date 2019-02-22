#!/bin/bash
read -p "请输入你所要查询组信息：" pass
if [ -z $pass ];then
	echo "当前用户组信息为："
	echo -n `id` 
	echo `awk -F: '/^$pass/{print "成员为："$4}' /etc/group`
elif [ "$pass" == "--help"  ];then
	id --help
elif [ "$pass" == "-h" ];then
	id --help
elif [ "$pass" == "-a" ];then
	awk -F: '{print "组名为："$1,"gid为："$4}' /etc/passwd
elif [ "$pass" == "--all" ];then
	awk -F: '{print "组名为："$1,"gid为："$4}' /etc/passwd
else
	if id $pass &>/dev/null ;then
		id $pass
	else
		echo "该组不存在"
	fi
fi

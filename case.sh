#!/bin/bash
read -p "请输入yes/no :" pass
case "$pass" in
yes|y|ye)
	echo "yes"
	;;
no|n)
	echo "no"
	;;
*)
	echo "只能是yes/no"
	;;
esac

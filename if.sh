#!/bin/bash
[ -z "$1" ] && exit
if ping -c1 $1 &> /dev/null;then
	echo alive
else
	echo not alive
fi

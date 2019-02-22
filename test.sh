#!/bin/bash
a=36
for i in "$@" ##或者直接 $*或$@
do
	let a--
	echo -e "\033[$a;5m$@\033[0m"
	shift 
	sleep 0.5
done

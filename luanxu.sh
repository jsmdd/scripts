#!/bin/bash
for i in {1..10};do
	echo  "$RANDOM $i"
done|sort -n |cut -d " " -f2|xargs

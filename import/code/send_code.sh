#!/bin/bash

cd /root/send_code

for i in `ls`;do
    python $i $1
    sleep 2;
done

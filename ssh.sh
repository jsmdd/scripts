#!/bin/bash
rm -rf /root/.ssh/known_hosts #防止之前用ssh连接过，此文件为指纹文件
/usr/bin/expect <<eof
set timeout 100
spawn ssh-keygen
expect "/root/.ssh/id_rsa"
send "\n"
expect "empty for no passphrase"
send "\n"
expect "passphrase again"
send "\n"

spawn ssh-copy-id $1
expect "yes/no"
send "yes\n"
expect "password"
send "971117\n"

expect eof
eof

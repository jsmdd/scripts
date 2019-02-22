#!/usr/bin/expect
spawn su - jsm 
expect "密码"
send "123\n"
expect "$"
send "pwd\n"
interact

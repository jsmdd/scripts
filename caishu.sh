#!/bin/bash
MAC(){
a=(0 1 2 3 4 5 6 7 8 9 a b c d e f)
mac=()
for i in {1..18};do
        b=$[RANDOM%16]
        c=`echo ${a[$b]}`
        mac[$i]=$c
        case $i in
        3|6|9|12|15)
                echo -n ":"
                ;;
        18)
                echo
                ;;
        *)
                echo -n "`echo ${mac[$i]}`"
                ;;
        esac
done
}
UUID(){
a=(0 1 2 3 4 5 6 7 8 9 a b c d e f)
mac=()
for i in {1..37};do
        b=$[RANDOM%16]
        c=`echo ${a[$b]}`
        mac[$i]=$c
        case $i in
        9|14|19|24)
                echo -n "-"
                ;;
        37)
                echo
                ;;
        *)
                echo -n "`echo ${mac[$i]}`"
                ;;
        esac
done
}
read -p "请输入你想要生成的参数:" pass
case $pass in
mac)
	MAC
	;;
uuid)
	UUID
	;;
*)
	echo 请输入mac或uuid
	;;
esac	

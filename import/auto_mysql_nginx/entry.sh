#!/bin/bash
#by yassor 19.7
#数据库为nginx_logs
#存放基础信息的表为 Basic_Information   存放设备信息的表为 Device_Information   存放主机域名信息的表为 host_list    存放用户请求信息的表为 User_request
FILE_NAME=/data/log
#插入数据库
MYSQL(){
    mysql -uyassor -p123456 -h192.168.169.24 -e "$1"
}
#用户IP 
IP(){
    awk -F "\"" '{print $2}' $FILE_NAME/$i
}
#访问时间
TIME(){
    awk -F "\"" '{print $4}' $FILE_NAME/$i |awk -F "/| " '{print $3}'|awk -F ":" '{$1=null;print $0}'|sed 's/ /:/g'|sed -n 's/://p'
}
#访问日期
DATE(){
    awk -F "\"" '{print $4}' $FILE_NAME/$i |awk -F ":" '{print $1}' |awk -F "/" '{print $3"-"$2"-"$1}'
}
#修改英文月份
MONTH(){
        sed -i 's/Jan/01/g' $date_info
        sed -i 's/Feb/02/g' $date_info
        sed -i 's/Mar/03/g' $date_info
        sed -i 's/Apr/04/g' $date_info
        sed -i 's/May/05/g' $date_info
        sed -i 's/Jun/06/g' $date_info
        sed -i 's/Jul/07/g' $date_info
        sed -i 's/Aug/08/g' $date_info
        sed -i 's/Sept/09/g' $date_info
        sed -i 's/Oct/10/g' $date_info
        sed -i 's/Nov/11/g' $date_info
        sed -i 's/Dec/12/g' $date_info
}
#修改系统类型
MOD(){
        sed -i '/Windows/c Windows' $system_info;
        sed -i '/Macintosh/c Macintosh' $system_info;
}
#设备系统
SYSTEM(){
    awk -F "\"" '{print $14}' $FILE_NAME/$i |cut -d '(' -f2 |cut -d ')' -f1
}
#设备版本
VERSION(){
    awk -F "\"" '{print $14}' $FILE_NAME/$i |awk '{print $(NF-1)}'
}
#设备总信息
SUM(){
    awk -F "\"" '{print $14}' $FILE_NAME/$i
}
#状态码
STATUS_CODE(){
    awk -F "\"" '{print $10}' $FILE_NAME/$i
}
#响应时间
RESPONSE_TIME(){
    awk -F "\"" '{print $12}' $FILE_NAME/$i
}
#请求类型
REQUEST_TYPE(){
    awk -F "\"" '{print $8}' $FILE_NAME/$i |awk '{print $1}'
}
#请求资源
REQUEST_RESOURCE(){
    awk -F "\"" '{print $8}' $FILE_NAME/$i |awk '{print $2}'
}
#数据大小
DATA_SIZE(){
    awk -F "\"" '{print $16}' $FILE_NAME/$i
}


#以下为执行过程
#先mv移动日志，再nginx -s reopen


#插入host_list
INSERT_ONE(){
    host_name=/root/host_name
    cd $FILE_NAME
    for i in * ;do
    domain_name=`echo $i |awk -F "." '{print $1}'`
    insert="INSERT INTO nginx_logs.host_list set host_name = '"$domain_name"';"
    MYSQL "$insert"
    done
    if [ -f $host_name ];then
        rm -f $host_name && MYSQL "select * from nginx_logs.host_list;" > $host_name
    else
        MYSQL "select * from nginx_logs.host_list;" > $host_name
    fi
}
#插入Basic_Information
INSERT_TWO(){
    ip_info=/root/test/ip_info
    time_info=/root/test/time_info
    date_info=/root/test/date_info
    code_info=/root/test/code_info
    response_info=/root/test/response_info
    size_info=/root/test/size_info
    agent_info=/root/test/agent_info
    cd $FILE_NAME
    for i in * ;do 
    IP > $ip_info
    TIME > $time_info
    DATE > $date_info
    MONTH
    STATUS_CODE > $code_info
    RESPONSE_TIME > $response_info
    DATA_SIZE > $size_info
    paste $ip_info $time_info $date_info $code_info $response_info $size_info > $agent_info
    rows=`cat $agent_info|wc -l`
    domain_name=`echo $i |awk -F "." '{print $1}'`
    match=`sed -n '/[0-9]/p' /root/host_name |sed -n '/'"$domain_name"'/p' |awk '{print $2}'`
        for j in `seq $rows`;do
            ip=`sed -n ''"$j"'p' $agent_info |awk '{print $1}'`
            time_=`sed -n ''"$j"'p' $agent_info |awk '{print $2}'`
            date=`sed -n ''"$j"'p' $agent_info |awk '{print $3}'`
            code=`sed -n ''"$j"'p' $agent_info |awk '{print $4}'`
            response=`sed -n ''"$j"'p' $agent_info |awk '{print $5}'`
            size=`sed -n ''"$j"'p' $agent_info |awk '{print $6}'`
            insert="insert into nginx_logs.Basic_Information set ip = '"$ip"',time = '"$time_"',date = '"$date"',status_code = '"$code"',Rresponse_time = '"$response"',data_size = $size,host = $match;"
            #echo $insert >> /root/test/sql2
            MYSQL "$insert"
        done
        #for k in `cat $time_info`;do
        #    insert="insert into nginx_logs.Basic_Information set time = '"$k"';"
        #    MYSQL "$insert"
        #    echo > $time_info
        #done
        #for l in `cat $code_info`;do
        #    insert="insert into nginx_logs.Basic_Information set status_code = '"$l"';"
        #    MYSQL "$insert"
        #    echo > $code_info
        #done
        #for m in `cat $response_info`;do
        #    insert="insert into nginx_logs.Basic_Information set Rresponse_time = '"$m"';"
        #    MYSQL "$insert"
        #    echo > $response_info
        #done
        #for n in `cat $size_info`;do
        #    insert="insert into nginx_logs.Basic_Information set data_size = $n;"
        #    MYSQL "$insert"
        #    echo > $size_info
        #done
        #for o in `cat $date_info`;do
        #    insert="insert into nginx_logs.Basic_Information set data = '"$o"';"
        #    MYSQL "$insert"
        #    echo > $date_info
        #done
    done
}
#插入User_request
INSERT_THREE(){
    type_info=/root/user/type_info
    resource_info=/root/user/resource_info
    request_agent=/root/user/request_agent
    cd $FILE_NAME
    for i in * ;do
    REQUEST_TYPE > $type_info
    REQUEST_RESOURCE > $resource_info
    paste $type_info $resource_info > $request_agent
    rows=`cat $request_agent|wc -l`
        for j in `seq $rows`;do
            request_type=`sed -n ''"$j"'p' $request_agent |awk '{print $1}'`
            request_resource=`sed -n ''"$j"'p' $request_agent |awk '{print $2}'`
            insert="insert into nginx_logs.User_request set request_type = '"$request_type"',request_resource = '"$request_resource"';"
            #echo $insert >> /root/user/sql3
            MYSQL "$insert"
        done
        #for k in `cat $resource_info`;do
        #    insert="insert into nginx_logs.User_request set request_resource = '"$k"';"
        #    MYSQL "$insert"
        #    echo > $resource_info
        #done
    done
}
#插入Device_Information
INSERT_FOUR(){
    system_info=/root/device/system_info
    version_info=/root/device/version_info
    device_agent=/root/device/device_agent
    cd $FILE_NAME
    for i in * ;do
    SYSTEM > $system_info
    MOD
    VERSION > $version_info
    paste $system_info $version_info > $device_agent
    rows=`cat $device_agent |wc -l`
        for j in `seq $rows`;do
            system=`sed -n ''"$j"'p' $device_agent |awk '{print $1}'`
            version=`sed -n ''"$j"'p' $device_agent |awk '{print $2}'`
            insert="insert into nginx_logs.Device_Information set system = '"$system"',version = '"$version"';"
            MYSQL "$insert"
        done
        #for k in `cat $version_info`;do
        #insert="insert into nginx_logs.Device Information set version = '"$k"';"
        #    MYSQL "$insert"
        #    echo > $version_info
        #done
    done
}


INSERT_ONE
INSERT_TWO
INSERT_THREE
INSERT_FOUR

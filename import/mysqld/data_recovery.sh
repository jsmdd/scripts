#/bin/bash
#此脚本的时间线以操作时间为基础

error(){
  echo -e "`date +%F' '%T` [ERROR] \033[31;1m $* \033[0m"
  exit 1
}

warn(){
   echo -e "`date +%F' '%T` [WARN] \033[33;1m $* \033[0m"
}

LOG(){
  echo -e "`date +%F' '%T` [LOG] \033[32m $* \033[0m"
}

#下载数据备份的url和文件名,选择解压文件方式(gunzip，unzip，可不填)
url=
filename=
mode=

#数据库的链接参数以及提取参数(没有可为空)
user=
port=
ip=
password=
dbname=
tbname=

#时间间隔参数
time=
#time=`seq 0 2 35`，比如今天日期为11月12号，此时间参数通过后续处理表示11/12,11/10,11/08，......，10/09

ls /data/all & >/dev/null ||mkdir /data/all;cd /data/all   #此为项目的主目录，

if [ -z "$dbname" ];then
  $extract = TABLE;
  $match_str = $tbname;
elif [ -z "$tbname"];then
  $extract = DB;
  $match_str = $dbname;
else
  error "参数未设置！"；
fi

#下载日期所对应的数据库备份，并导出所需sql
date_back(){
for i in ${time};do
  path=`date -d "${i} days ago" "+%Y-%m-%d"`;
  mkdir ${path};
  cd ${path};
  wget ${url}/${filename};
  [ -n "$mode" ] && $mode $filename;
  sh /root/mysqldumpsplit.sh --source=$filename --extract $extract --match_str $match_str --compression none --decompression none;
  rm -f $filename;
  cd ..;
done  
}

#向数据库导入相应日期的sql
date_sql(){
for i in ${time};do
  path=`date -d "${i} days ago" "+%Y-%m-%d"`;
  ls $path &>/dev/null || mkdir $path ;
  cd $path/out;
  mysql -u ${user} -p${password} -P${port} -h${ip} -e "create database '`$path`';"
  mysql -u ${user} -p${password} -P${port} -h${ip} -D ${path} < ${match_str}.sql
  [ $? -eq 0 ] && LOG "导入${path}/${match_str}.sql失败" || error "导入${path}/${match_str}.sql失败"
  cd ../..;
done
}

#通过id字段去除重复的数据并导出
clear_date(){
minid=1;
for i in ${time};do
  path=`date -d "${i} days ago" "+%Y-%m-%d"`;
  ls $path &>/dev/null || mkdir $path ;
  cd $path/out;
  maxid=`mysql -u ${user} -p${password} -P${port} -h${ip} -D ${path} -e "select max(id) from ${match_str}" |grep -v id | awk '{print $1}' `;
  LOG "查询${i}数据成功, ID最大值${maxid}, ID最小值${minid}" ; 
  ＃表数据
  mysqldump -u ${user} -p${password} -P${port} -h${ip} -D ${path} --no-create-info   --where="id < ${maxid} and id >= ${minid} " > /data/all/${path}.sql ;
  #表结构
  mysqldump -u ${user} -p${password} -P${port} -h${ip} -D ${path} ${match_str}  --no-data > 100000.sql  
  minid=${maxid} ; 
  cd ../..;
done
}

＃导入新的数据库
for i in `ls *.sql`;do echo ${i};mysql -u ${user} -p${password} -P${port} -h${ip} －D NEWDB < ${i};done

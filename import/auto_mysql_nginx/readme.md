## 在使用本脚本前注意以下事项
```
1.nginx的log格式为 
log_format  access  '"$remote_addr" "$time_local" "$http_x_forwarded_for" "$request" "$status" "$request_time" "$http_user_agent" "$bytes_sent" "$http_host" "$http_referer"'
2.mysql使用参数时，可自己调整，灵活使用
3.先利用create table里面的sql创建好初始的表结构
```
> 此脚本是先把数据从nginx日志中提取出来，经过处理，创建临时文件，最后导入数据库.此方法仅供参考，应用场景单一。

sh mysqldumpsplit.sh
```
--source 选择提取的文件名
--desc  将会导出所有的库和表
--extract 选择导出的类型：DB，TABLE，ALLDBS，ALLTABLES
--match_str 选择导出的DB或TABLE的名称
--compression 选择提取的文件的压缩方式，如没有就为  none
--decompression 选择导出的文件的压缩方式，如不设置为  none
--output_dir   选择导出文件的路径，默认为：当前路径下的 ./out/
```
> 示例：sh mysqldumpsplit.sh --source Dbsql.gz --extract TABLE --match_str tablename  --compression gzip --decompression none 

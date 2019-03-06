# MySQL -- 关闭 binlog

#### LNMP一键安装包安装的MySQL默认是开启了日志文件的，如果数据操作比较频繁就会产生大量的日志，在/usr/local/mysql /var/下面产生mysql-bin.0000* 类似的文件，而且一般都在几十MB到几个GB，更甚会吃掉整个硬盘空间，从来导致mysql无法启动或报错，如vps论坛用户的反馈。
 
* 如何关闭MySQL的日志功能：
 

##### 删除日志：
 
* 执行：`/usr/local/mysql/bin/mysql -u root -p`
 
* 输入密码登录后再执行：`reset master;` (sql命令)
 
* 修改 `/etc/my.cnf` 文件，找到

`log-bin=mysql-bin`
`binlog_format=mixed`

再这两行前面加上#，将其注释掉，再执行/etc/init.d/mysql restart即可。
 
 
本文以LNMP一件安装包安装的环境为例 除MySQL重启命令和配置文件路径可能略有不同，其他一样。
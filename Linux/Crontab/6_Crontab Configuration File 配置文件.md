# 6_Crontab Configuration File 配置文件

Author : Chunyang . Zhang

---
> ### 系统配置文件
>
> > * 文件路径 **/etc/crontab**
>
> 
>
> > * 系统配置文件内容
> >
> > ```
> > SHELL=/bin/bash
> > PATH=/sbin:/bin:/usr/sbin:/usr/bin
> > MAILTO=root
> > 
> > # For details see man 4 crontabs
> > 
> > # Example of job definition:
> > # .---------------- minute (0 - 59)
> > # |  .------------- hour (0 - 23)
> > # |  |  .---------- day of month (1 - 31)
> > # |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
> > # |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
> > # |  |  |  |  |
> > # *  *  *  *  * user-name  command to be executed
> > 
> > ```
>



---

### 系统用户crontab配置文件保存目录(crontab -e)

> * 保存路径 **/var/spool/cron/...**
>
>    * root用户：/var/spool/cron/root
>
>    * user01：/var/spool/cron/user01
>
> > * 每次`crontab -e`命令修改其实就是此路径下，针对linux用户创建的配置文件
> >
> > * 例子：
> >
> >   ```bash
> >   [root@ODCDITCBS01 cron]# pwd
> >   /var/spool/cron
> >   [root@ODCDITCBS01 cron]# ll
> >   total 8
> >   -rw------- 1 affincbs cbs  147 Apr 25 18:44 affincbs
> >   -rw------- 1 root     root  68 Sep 27  2018 root
> >   ```











## 解读：

---

> #### 【***】配置文件读取顺序。
> 
> 1. 系统先读取 /etc/crontab 目录下的文件，有任务会以root触发执行
> 2. 然后户读取 /var/spool/cron/username 等每个系统用户的配置文件，有任务以此用户触发执行
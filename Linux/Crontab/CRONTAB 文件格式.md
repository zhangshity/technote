# CRONTAB 文件格式
Author : Chunyang .Zhang

---
> * 命令格式详解 (5 * + command)
>
> | *    *    *    *    * | My Command   |
> | --------------------- | ------------ |
> | 分  时  日  月  周    | 要运行的命令 |
> | m   h   d   M   w     | your command |
>



> * Scope of each  ' * ’ (每一个 * 的范围)
> 
> 1. 表格展示(table)
> 
> ```
> Example of job definition:
> 
>  .---------------- minute (0 - 59)
>  | .-------------- hour (0 - 23)
>  | | .------------ day of month (1 - 31)
>  | | | .---------- month (1 - 12) OR jan,feb,mar,apr ...
>  | | | | .-------- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
>  | | | | |
>  * * * * * user-name command to be executed
> ```
> 
> 2. 图像展示(image in chinese)
> 
> ![Crontab Scope](https://github.com/zhangshity/technote/blob/master/Resources/crontab_scope.png)
> 
> 
> 

---



* 

























---

【参考资料1】：[Linux下的crontab定时执行任务命令详解](https://www.cnblogs.com/longjshz/p/5779215.html)

【参考资料2】：[Linux定时任务Crontab命令详解](https://www.cnblogs.com/intval/p/5763929.html)


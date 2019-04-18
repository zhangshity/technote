### mysql下批量清空某个库下的所有表(库不要删除，保留空库)

----
                                                                     Chunyang.Zhang
> mysql下要想删除某个库下的某张表，只需要切换到该库下，执行语句"drop table tablename"即可删除！但若是该库下有成百上千张表，要是再这样一次次执行drop语句，就太费劲了！

> 正确的批量删除某个库下的所有表的方法只需如下两步：
>
> * 1）第一步（只需将下面的"库名"替换成实际操作中的库名即可）
>
> ```sql
> select concat('drop table ',table_name,';') from information_schema.TABLES where table_schema='库名';
> ```
> * 2）第二步
>   切换到这个库下，把第一步的执行结果导出，然后全部执行 



> 例：
>
> 1要删除数据库 **restaurant** 下的所有表，执行：
>
> ```sql
> select concat('drop table ',table_name,';') from information_schema.TABLES where table_schema='restaurant';
> ```
>
> 2得到结果：
>
> ```sql
> drop table environment_info;
> drop table order_detail;
> drop table order_master;
> drop table product_category;
> drop table product_info;
> drop table queue_info;
> drop table seller_info;
> ```
>
> 3复制结果，执行删除语句





*  [引用网址](<https://www.cnblogs.com/kevingrace/p/9439025.html>)
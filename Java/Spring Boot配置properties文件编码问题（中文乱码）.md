# Spring Boot配置properties文件编码问题（中文乱码）

> 当properties里面属性值是中文的时候，发现java bean绑定的值是乱码：

![](https://img-blog.csdnimg.cn/20191031205910847.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM2NzYxODMx,size_16,color_FFFFFF,t_70)

> 原因是properties文件在idea中默认是utf-8的编码方式，而properties文件用的都是ASCII码，所以就出现了乱码的问题。

* 解决方法：

![](https://img-blog.csdnimg.cn/20191031205956636.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM2NzYxODMx,size_16,color_FFFFFF,t_70)

设置之后再看测试结果就不会有中文乱码问题了。







————————————————
版权声明：本文为CSDN博主「Hern（宋兆恒）」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/qq_36761831/article/details/102845782
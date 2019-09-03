# 执行文件路径的变量：$PATH

@Author:Chunyang.Zhang

---

在Linux中，PATH是环境变量，在执行命令时，系统会按照PATH的设置，去每个PATH定义的路径下搜索执行文件，先搜索到的文件先执行。

输入命令 `echo $PATH`，其中echo表示“显示”的意思，而PATH前面的$表示后面接的是变量，所以就会显示出当前的PATH了。

以下为本人mac的zsh回显:

```shell
 ~ echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Applications/Wireshark.app/Contents/MacOS:/usr/local/mysql/bin:/Library/apache-maven-3.5.3/bin:/Library/apache-tomcat-8.0.50/bin
```



可以看出，/bin在PATH的设置中，可以找到相应的执行文件。PATH对于执行文件来说，是一个很重要的“变量”，其主要用来规范命令搜索的目录。**每个目录是有顺序的，每个目录中间以“ : ”分割**。

摘自《鸟哥的Linux私房菜——基础学习篇》 人民邮电出版社 P118
————————————————

稍加改动，原文链接：https://blog.csdn.net/lyc_daniel/article/details/12616921
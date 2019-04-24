## Jenkins Error: No such plugin: cloudbees-folder 
> ##### 安装过程中出现一个错误： No such plugin: cloudbees-folder 



> ##### 安装插件，有时候会报类似的错误：An error occurred during installation: No such plugin: cloudbees-folder

 

* 上述错误均是安装插件**cloudbees-folder**失败，原因是下载的 **<u>jenkins.war</u>** 包里没有**cloudbees-folder**插件，解决办法：

> 1. 下载URL：<http://ftp.icm.edu.pl/packages/jenkins/plugins/cloudbees-folder/>
>
>  2. 把下载到的 cloudbees-folder.hpi 文件放在
>  `/usr/local/apache-tomcat-9.0.14/webapps/jenkins/WEB-INF/detached-plugins` 目录下即可，其中： */usr/local/apache-tomcat-9.0.14/…*  为Jenkins的容器(tomcat)路径
>
>  3. 重启tomcat，浏览器访问Jenkins服务器，设置用户名、密码等，然后进入Jenkins首页 


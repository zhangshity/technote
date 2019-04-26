# 7_Crontab Environment Variables 环境变量

Author : Chunyang . Zhang

---
### Crontab配置文件配置
> > 1. 环境变量位置： `/etc/crontab`
>
> > 2. 默认系统环境变量：  
> >
> >       `PATH=/sbin:/bin:/usr/sbin:/usr/bin`
> >
> >     * ' : ' 分隔每个变量，如：加入java的环境变量  
> >   
> >          `PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/jdk1.8.0_162/bin`
> >
>
> > 3. 加入环境变量后即可使用对应命令
> >
> >    * 编辑crontab文件  
> >
> >      `crontab -e` 
> >
> >    
> >      * 写入调用java环境变量的 crontab文件命令
> >
> >        ```
> >        * * * * * echo `date` ======crontab环境变量测试===java -version====每分钟写入一次java版本 >>/app/affincbs/java.out && java -version 2>>/app/affincbs/java.out
> >        ```
> >
> >        
> >    
> >



---
### 系统/用户环境变量配置
> 1. 执行具体任务前引入系统变量 / 用户变量
>
>    * 系统环境变量： `vi /etc/profile` 
>    
>      ```shell
>      PATH=$PATH:/usr/local/jdk1.8.0_162/bin
>      export PATH
>      ```
>    
>    * 用户环境变量： `vi ~/.bash_profile`
>    
>      ```shell
>      PATH=$PATH:$HOME/bin:/usr/local/jdk1.8.0_162/bin
>      export PATH
>      ```
>
> 2. 编写shell执行脚本  `vi /root/test.sh`
>
>    ```shell
>    echo `date` ======crontab环境变量测试===java -version====每分钟写入一次java版本 >>/app/affincbs/java.out && java -version 2>>/app/affincbs/java.out
>    ```
>
> 3. 添加 crontab文件 命令 `crontab -e`
>
>    ```crontab
>    * * * * * source /etc/profile;sh /root/test.sh
>    * * * * * source ~/.bash_profile;sh /root/test.sh
>    ```
>
>    * 意思是，每次加载前，使环境变量生效，然后执行写好的shell脚本
>

 
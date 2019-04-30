# Author: Chunyang . Zhang 
# For: Tomcat CD in Jenkins  

# 显示当前路径
echo "Default HOME_DIRECTORY : " /app/affinbds

# 启动前清空日志日志文件
cd /app/affinbds/tomcat_fat/tomcat/logs
echo `date` - " ====================sh startup.sh tomcat===================" > catalina.out

# 进入tomcat/bin目录
cd /app/affinbds/tomcat_fat/tomcat/bin
echo "DIRECTORY is : "  `pwd`

# 启动tomcat
sh startup.sh

# 读取日志每一行并返回, 匹配到成功或失败日志行就返回信息并结束
tail -f /app/affinbds/tomcat_fat/tomcat/logs/catalina.out | while read line
do
    echo $line;
    result1=`echo $line | grep "^INFO: Server startup"`
    result2=`echo $line | grep "^INFO:server stopped"`
    if [ "X$result1" != "X" ]
    then
        echo "BDS startup successful !!! "
        exit
    elif [ "X$result2" != "X" ]
    then
        echo "BDS startup fail !!! "
        exit
    fi
done
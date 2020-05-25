# IntelliJ IDEA 通过maven插件使用Mybatis-generator

版权声明：本文为CSDN博主「莞尔」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/weixin_42338707/article/details/106340082

#### IntelliJ IDEA 通过maven插件使用Mybatis-generator (Eclipse也可用同样方式,配置方式稍有不同)

> - 对比IDE集成插件的优点：
>
>   1. 能灵活调整mybatis-generator生成器版本
>
>   2. 能利用maven plugin实现跨平台使用

---

1. 在maven项目的pom.xml 添加mybatis-generator-maven-plugin 插件**

```maven
<!-- mybatis-generator-maven-plugin 插件依赖包 -->
<dependency>
	<groupId>org.mybatis.generator</groupId>
	<artifactId>mybatis-generator-maven-plugin</artifactId>
	<version>1.3.7</version>
</dependency>
<!-- mybatis-generator-core 代码生成逻辑核心包-->
<dependency>
	<groupId>org.mybatis.generator</groupId>
	<artifactId>mybatis-generator-core</artifactId>
	<version>1.3.7</version>
</dependency>
```
```maven
<build>
   	<plugins>
		<!-- mybatis-generator-maven-plugin 插件 -->
		<plugin>
			<groupId>org.mybatis.generator</groupId>
			<artifactId>mybatis-generator-maven-plugin</artifactId>
			<version>1.3.7</version>
			<configuration>
				<configurationFile>${basedir}/src/main/resources/generatorConfig.xml</configurationFile>
				<overwrite>true</overwrite>
				<verbose>true</verbose>
			</configuration>
		</plugin>
    </plugins>
</build>
```
**2. 在maven项目下的src/main/resources 目录下建立名为 generatorConfig.xml的配置文件，作为mybatis-generator-maven-plugin 插件的执行目标，模板如下**：

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE generatorConfiguration PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd" >
<generatorConfiguration>

    <classPathEntry location="c:\Users\admin\.m2\repository\mysql\mysql-connector-java\5.1.42\mysql-connector-java-5.1.42.jar"/>
    <context id="context1">
        <commentGenerator>
            <!-- 是否去除自动生成的注释 true：是 ： false:否 -->
            <property name="suppressAllComments" value="false"/>
        </commentGenerator>
        <jdbcConnection driverClass="com.mysql.jdbc.Driver" connectionURL="jdbc:mysql://xxx.xxx.xxx.xxx:3306/test_girl"
                        userId="root" password="123456"/>
        <!-- entity.java -->
        <javaModelGenerator targetPackage="com.star.saas.dao.entity.auto" targetProject="/saas-parent/saas-dao/src/main/java"/>
        <!-- mapper.xml -->
        <sqlMapGenerator targetPackage="mybatis.auto" targetProject="/saas-parent/saas-dao/src/main/resources"/>
        <!-- mapper.java -->
        <javaClientGenerator targetPackage="com.star.saas.dao.db.auto" targetProject="/saas-parent/saas-dao/src/main/java"
                             type="XMLMAPPER"/>
    
        <!-- 快递表 -->
        <table  tableName="express_price" domainObjectName="ExpressPriceEntity" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false" />
    
    </context>
</generatorConfiguration>
```

**3. 在Intellij IDEA添加一个“Run运行”选项，使用maven运行mybatis-generator-maven-plugin插件 ：**

![](https://img-blog.csdnimg.cn/20200525190510537.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjMzODcwNw==,size_16,color_FFFFFF,t_70)

![](https://img-blog.csdnimg.cn/20200525190903746.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjMzODcwNw==,size_16,color_FFFFFF,t_70)



`mybatis-generator:generate -e`



![](https://img-blog.csdnimg.cn/20200525191043555.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjMzODcwNw==,size_16,color_FFFFFF,t_70)


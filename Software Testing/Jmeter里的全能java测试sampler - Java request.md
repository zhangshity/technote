# Jmeter里的全能java测试sampler - Java request

* [转]https://blog.csdn.net/qilinxo/article/details/81209523
Jmeter有用与测试java类的sampler，Java request sampler。这个sampler可以测试任何java类，同时可以在类中写任何的逻辑，可以写各种接口的测试逻辑，可以写服务的测试逻辑。。。理论上，这种sampler可以完成各种测试，当然前提是你有空来写一个完善的java脚本。

![img](https://img-blog.csdn.net/20180725202239291?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FpbGlueG8=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

上图是一个java requst的sampler，我将它放在线程组下，并给了它一个view results tree的listener。在图中的界面上，可以修改sampler的name，可以选择要测试的类，可以设置parameter的key和value。

 

1. 首先看看Java request的脚本怎么写：

很简单，jmeter为用户提供了AbstractJavaSamplerClient类作为与用户的交互类。用户只需继承该类，并重写相关的方法，就欧了。

需要重写的方法：

（1）public Arguments getDefaultParameters()

重写该方法，可以设置sampler里面的parameters。当每次在GUI里面点击建立的java requst sampler的时候会调用该方法。该方法设置了parameters的初始值，当然可以在sampler的GUI界面里面做进一步的修改。

书写例子：

```java
public Arguments getDefaultParameters() {

    System.out.println("get Default Parameters");
  
    Arguments params = new Arguments();
    params.addArgument("1", "0");
    params.addArgument("2", "0");
    return params;
}
```

（2）public void setupTest(JavaSamplerContext context)

这个方法用于做一些测试之前的必须工作，比如初始化测试脚本里面需要用到的变量。举个例子，例如在测试spark程序性能的时候，我会创建kafka的producer发送数据，spark会从kafka中消费数据。测试的目标是spark的处理速度，而不是kafka的性能，所以初始化producer的时间不应该统计在我们的测试中。鉴于此种情况，将初始化producer的工作放在setupTest中便可满足需求。setupTest方法将会在每个线程开始之前运行。传入参数context是getDefaultParameters()所返回的参数，即该sampler的parameters。

书写例子：

```java
public void setupTest(JavaSamplerContext context) {
  
    p1 = arg0.getParameter("1");

    p2 = arg0.getParameter("2");

}
```

（3）public void teardownTest(JavaSamplerContext context)

这个方法在每个线程执行完所有的测试工作之后执行，有点像finally的功能，比如说，我开了一个数据库的连接，那么我要在所有的线程完成工作之后删除。实在没有什么可以干的，不写当然也可以。

书写例子：

```java
public void teardownTest(JavaSamplerContext context) {

    System.out.println("tear down");

    super.teardownTest(context);

}
```

（4）public SampleResult runTest(JavaSamplerContext arg0)

这个是测试的主方法，要测试的逻辑都应该写在这里。每个线程会循环执行这个方法，当然有多少线程在执行这个方法、每个线程执行多长时间、每个线程执行多少次，这取决于thread group里面的设置。其中，计时开始的时刻是从SampleResult类里面的sampleStart()方法的执行开始。计时结束的时刻是在sampleEnd()方法执行的时刻。setSuccessful()方法用来表示测试的成功与否，通常使用try catch来设置结果，也可以用if语句。setResponseData()方法用来为测试结果中传递数据。

书写例子：

```java
public SampleResult runTest(JavaSamplerContext arg0) {

    final SampleResult sr = new SampleResult();

    try {
        sr.sampleStart(); // 计时开始
        System.out.println("开始");
      
        sr.setResponseData(("I, the most powerful man, must be seccessful").getBytes());

        sr.setSuccessful(true);
      
    } catch (Exception e) {
        e.printStackTrace();
      
        sr.setResponseData(("error: " + e).getBytes());

        sr.setDataType(SampleResult.TEXT);

        sr.setSuccessful(false);

    } finally {
      
        sr.sampleEnd(); // 计时结束
      
        count++;

    }

    return sr;

}
```

 

2. 搞定了脚本，那么就打包就行。jmeter只认jar包。

现在项目都是用maven搞的，方便。在pom.xml里面填上打jar包的插件配置：

```html
<build>
    <plugins>
        <plugin>
            <artifactId>maven-assembly-plugin</artifactId>
                <configuration>
                    <descriptorRefs>
                        <descriptorRef>jar-with-dependencies</descriptorRef>
                    </descriptorRefs>
                </configuration>
          
                <executions>
                    <execution>
                        <id>make-assembly</id>
                        <phase>package</phase>
                        <goals>
                             <goal>single</goal>
                        </goals>
                   </execution>
                </executions>
            </plugin>
        </plugins>
</build>
```

配置好之后，执行maven install。在target文件夹下就可以看到两个jar包，一个是自己写的程序打出来的jar包，另一个是依赖jar包。将依赖包放在jmeter目录的lib文件夹下，将目标jar包放在lib文件夹下面的ext扩展文件夹中。重启jmeter，在java request sampler里面可以看到，我们需要测试的类已经被识别了。在getDefaultParameters()方法里面设置的参数，也已经被自动识别在下方的parameters表格中。

 

3.  parameter设置

![img](https://img-blog.csdn.net/20180725202605515?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FpbGlueG8=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

parameters已经被getDefaultParameters()方法自动设置初始值了，但并不意味这不可以修改。我们可以修改Name和Value。但是不建议修改Name，因为在程序中，我们并没有作相应的修改，所以Name保持不变。对于Value值，我们可以根据需要做不同的修改。本例中使用csv文件进行了配置。

![img](https://img-blog.csdn.net/20180725202620633?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FpbGlueG8=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

CSV Data Set Config配置：

首先CSV文件的写法。不用写标题行，字段与字段之间使用分隔符断开，什么分隔符都可以。一条数据为一行，自己用文本编辑。将文件名设为.csv就OK了。

在java request sampler里面加上CSV Data Set Config这个config element。指定要用的csv文件。指定encoding是哪中，不填的话，默认是ANSI，一般设成UTF-8；

在Variable Names这一栏，填标题名，中间用逗号分开，如图那么写；

Ignore first line，表示忽略第一行，我们第一行没有用标题，所以不用忽略，设置为false；Delimiter，表示分隔符，csv文件里面用什么分隔符，这里就填什么分隔符；

allow quoted data：双引号相关. 设置为True,则会将CVS文件中的双重双引号只读取一个；设置为False,则会将CVS文件间中的所有双引号当为有效字符传入；

Recycle on EOF：当一个线程把csv里面的所有数据都读完了，是否去在循环？；

Stop thread on EOF：当一个线程读到csv文件结尾是停止运行，要与Recycle on EOF相搭配着玩，否则没有意义。

Sharing mode：共享默认，设置哪些线程可以使用这个csv。选项有all threads，表示所有的线程都可以共享；current thread group，表示当前的线程组可以使用这个线程。

 

4. 配置完文件直接运行即可
# JMeter 简介及简易Demo(Java)

@Author:Chunyang . Zhang

---

> #### 简介
> 1. Apache JMeter是Apache组织开发的**基于Java的压力测试工具**。用于对软件做压力测试，它最初被设计用于Web应用测试，但后来扩展到其他测试领域。 它可以用于测试静态和动态资源，例如静态文件、Java 小服务程序、CGI 脚本、Java 对象、数据库、FTP 服务器， 等等。JMeter 可以用于对服务器、网络或对象模拟巨大的负载，来自不同压力类别下测试它们的强度和分析整体性能。另外，JMeter能够对应用程序做功能/回归测试，通过创建带有断言的脚本来验证你的程序返回了你期望的结果。为了最大限度的灵活性，JMeter允许使用正则表达式创建断言。
>
>    Apache jmeter 可以用于对静态的和动态的资源（文件，Servlet，Perl脚本，java 对象，数据库和查询，FTP服务器等等）的性能进行测试。它可以用于对服务器、网络或对象模拟繁重的负载来测试它们的强度或分析不同压力类型下的整体性能。你可以使用它做性能的图形分析或在大并发负载测试你的服务器/脚本/对象。
>
> 2. 结果参数定义：
>
>    1、Label： 定义的HTTP请求名称
>
>    2、Samples： 表示这次测试中一共发出了多少个请求
>
>    3、Average： 访问页面的平均响应时间
>
>    4、Min: 访问页面的最小响应时间
>
>    5、Max: 访问页面的最大响应时间
>
>    6、Error%： 错误的请求的数量/请求的总数
>
>    7、Throughput：每秒完成的请求数
>
>    8、KB/Sec： 每秒从服务器端接收到的数据量
>
> 3. 
>
> 
>



---

#### Demo

###### 服务端Server：

https://github.com/zhangshity/aysos/blob/master/src/main/java/com/zcy/net/TPC_client_server/Server.java

```Java
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.ServerSocket;
import java.net.Socket;

/**
 * @ Author: chunyang.zhang
 * @ Description: <网络通信-服务器-TCP/>
 * @ Date: Created in 11:04 2019-08-16
 * @ Modified: By:
 * <p>
 * <p>=============================================
 * 服务器模拟程序部署:
 * 1.配置JDK (java -version)
 * 2.复制此代码为 Server.java 文件
 * 3.编译文件 (javac -encoding utf-8 Server.class)
 * 4.运行程序 (java Server)
 * 5.等待客户端发送消息并接收打印
 * <p>=============================================
 */
public class Server {

    public static void main(String[] args) throws IOException {

        //创建服务器连接socket
        ServerSocket serverSocket = new ServerSocket(1333);
        System.out.println("Server has started...\n>>> ...\n>>> ...\n>>> ...");

        int reciveCounter = 0;//接收socket计数器

        while (true) { //循环接收
            //接收客户端socket
            Socket clientSocket = serverSocket.accept();
            System.out.printf("%d 新连接... %s:%d Client Connect successfully! >>> %n", ++reciveCounter, clientSocket.getInetAddress(), clientSocket.getPort());
            //客户端socket转换为InputStream,并读取输出
            InputStream clientInputStream = clientSocket.getInputStream();
            DataInputStream dataInputStream = new DataInputStream(clientInputStream);
            String acceptResult = dataInputStream.readUTF();

            System.out.printf("第%d条数据: %s %n", reciveCounter, acceptResult);


            dataInputStream.close();
            clientSocket.close();
        }
    }
}

```



###### JMeter Client客户端:

```java
import org.apache.jmeter.protocol.java.sampler.AbstractJavaSamplerClient;
import org.apache.jmeter.protocol.java.sampler.JavaSamplerContext;
import org.apache.jmeter.samplers.SampleResult;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.Socket;

/**
 * @ Author: chunyang.zhang
 * @ Description: <>仅供jmeter测试使用</>
 * @ Date: Created in 14:17 2019-08-16
 * @ Modified: By:
 */
public class YangTest extends AbstractJavaSamplerClient {


    @Override
    public SampleResult runTest(JavaSamplerContext context) {
        SampleResult sampleResult = new SampleResult();

        try {
            Socket clientSocket = new Socket("localhost", 1333);

            OutputStream outputStream = clientSocket.getOutputStream();
            DataOutputStream dataOutputStream = new DataOutputStream(outputStream);

            dataOutputStream.writeUTF("{name:xiaoming,age:28,occupation:爸爸}");


            dataOutputStream.flush();

            dataOutputStream.close();
            outputStream.close();
            clientSocket.close();
            sampleResult.setSuccessful(true);
            
        } catch (IOException e) {
            e.printStackTrace();
        }
        return sampleResult;
    }
}
```

>自定义类**继承**AbstractJavaSamplerClient抽象类，根据JMeter自定义取样器的规则编写代码，编译得到jar包，然后放入JMeter的lib目录下，运行JMeter新建自定义的Java 取样器，即可以执行取样器逻辑。
# TECKNOTE_REVIEW

@Author:Chunyang.Zhang

---

## 2 网络

##### 1. OSI参考模型：物理层、数据链路层、网络层、传输层、会话层、表示层、应用层

##### 2. TPC/IP实现模型:物理层、网络层、传输层、应用层

* 两种模型对比:


<table>
    <tr>
        <th>OSI七层模型</th> 
        <th>TPC/IP概念模型</th> 
        <th>功能</th>
        <th>TCP/IP协议簇</th>
    </tr>
    <tr>
        <td>应用层</td>
      	<td rowspan="3">应用层</td>
      	<td>文件传输,电子邮件,文件服务,虚拟终端</td>
       	<td>TFTP,HTTP,SNMP,FTP,SMTP,DNS,Telnet</td>
    </tr>
    <tr>
        <td>表示层</td>  
      	<td>数据格式化,代码转换,数据加密</td>
      	<td>没有协议</td>
    </tr>
    <tr>
    		<td>会话层</td>
      	<td>解除或建立与别的节点联系</td>
      	<td>没有协议</td>
    </tr>
    <tr>
    		<td>传输层</td>
      	<td>传输层</td>
      	<td>提供端对端接口</td>
      	<td>TCP,UDP</td>
    </tr>
    <tr>
    		<td>网络层</td>
      	<td>网络层</td>
      	<td>为数据包选择路由</td>
      	<td>IP,ICMP,RIP,OSPF,BGP,IGMP</td>
    </tr>
  	<tr>
    		<td>数据链路层</td>
      	<td rowspan="2">链路层</td>
      	<td>传输有地址的帧以及错误检测功能</td>
      	<td>SLIP,CSLIP,PPP,ARP,RARP,MTU</td>
    </tr>
  	<tr>
    		<td>物理层</td>
      	<td>以二进制数据形式在物理媒体上传输数据</td>
      	<td>ISO2110,IEEE802,IEEE802.2</td>
    </tr>
</table>
---

##### 3. 三次握手

![三次握手](https://github.com/zhangshity/technote/blob/master/Resources/三次握手.png)

###### 1 描述 

* Client发送请求连接报文 `[SYN=1,seq=x]`    (seq=x 根据自身缓存计算出)
* Server接收报文并返回响应报文 `[SYN=1,ACK=1,seq=y,ack=x+1]`    (seq=y 根据自身缓存计算出,ack=x+1与请求报文相关,因为客户段发送消耗了一个seq号,故x+1)
* Client接收响应报文并返回响应报文 `[ACK=1,seq=x+1,ack=y+1]`    (Client的seq根据server响应报文seq+1,ack与响应报文有关,server消耗一个seq号故y+1)

###### 2 隐患--SYN超时

* Server收到Client的**[SYN]**，回复**[SYN,ACK]**的后未收到Client的**[ACK]**确认，会不断重试直至超时
* Linux系统会尝试5次，每次重试，等待翻倍，1+2+4+8+16+32=63秒

###### 3 SYN Flood 防护机制

* 防止恶意发送SYN，消耗seq，(Linux加入 SYN cookie机制)

###### 4 保活机制

* 未响应发送探测报文，直到测试次数达到上限

---

##### 4. 四次挥手

![](https://github.com/zhangshity/technote/blob/master/Resources/四次挥手.png)

###### 1 描述

* Client发送请求断开报文 `[FIN=1,seq=u]`    (seq=u根据自身计算而出)
* Server接收标并发送响应报文 `[ACK=1,seq=v,ack=u+1]`    (为什么没有FIN标志?因为被动断开的一方可能还有数据要传输,最后传输完成后才进行FIN标志响应)
* Server数据传输完毕发送响应请求断开报文 `[FIN=1,ACK=1,seq=w,ack=u+1]`    (因为两个响应间可能还有数据传输,故seq会改变,因此假设成w. 两个响应报文均是对同一个请求断开报文响应故ack相同=u+1)

* Client接收响应报文并响应 `[ACK=1,seq=u+1,ack=w+1]`    (seq根据响应确定=u+1,ack根据响应=w+1)

###### 2 为什么Client发送ACK要等待2MSL?

* 给Server足够的接收响应时间
* 保证连接有序不混乱

###### 3 Linux频繁的CLOSE_WAIT状态

* 查看CLOSE_WAIT

  ```shell
  ~ netstat -n | awk '/^tcp/{++S[$NF]}END{for(a in S) print a,S[a]}'
  SYN_SENT 8
  LAST_ACK 1
  CLOSE_WAIT 3
  TIME_WAIT 3
  ESTABLISHED 25
  ```

---

##### 5. UDP和TCP区别

1. 面向连接、无连接
2. 可靠性
3. 有序性
4. 速度
5. 量级(报文头 TPC 20Byte、UDP 8Byte)

---

##### 6. TCP滑动窗口

1. RTT: 发送一个数据包到接收到对应的ACK，所花费的时间
2. RTO: 重传时间间隔
3. TCP的滑动窗口 ：流量控制和乱序重排
4.  ...具体实现过程及原理

---

##### 7. HTTP

1. 请求响应模型：
   * Client连接到Web Server
   * 发送HTTP request (TCP套接字)
   * Server接收到request并返回HTTP response
   * Server释放TCP连接 (取决于模式：CLOSR_WAIT服务器主动断开，keep-alive则保持一段时间连接)
   * Client解析HTML内容

2. 游览器键入URL，回车后经历的流程
   * DNS解析 (逐层解析找到ip地址返回)
   * TCP连接
   * 发送HTTP请求
   * Sever处理请求并返回HTTP报文
   * 游览器解析渲染
   * 结束连接
   
3. HTTP状态码
   * 1xx : 指示信息--表示请求已接收，继续处理
   * 2xx : 成功--表示请求已被成功接收、理解、接收
   * 3xx : 重定向--要完成请求必须更进一步操作
   * 4xx : 客户端错误--有语法错误或者请求无法实现 (401未授权403拒绝访问404URL或请求资源不存在)
   * 5xx : 服务器错误--服务器未能实现合法的请求 (500服务器错误503服务器不能处理请求,一段时间后可能会恢复)

4. GET请求和POST请求的区别 (三个层面)

   * Http报文层面 : GET将请求信息放在URL里，以`?`隔开。  POST将请求信息放在报文体中
   * 数据库层面 : GET符合幂等性和安全性，POST不符合
   * 其他层面 : GET可以被缓存、被存储，而POST不行

   [详情贴]https://www.cnblogs.com/jiangxinyang/p/8453827.html

5. Cookie和Session的

   * Cookie简介

     * Server发给Client的特殊信息，以文本形式放在客户端
     * Client再次请求，会回发Cookie
     * Server接收到Cookie后，会解析Cookie生成与客户端相对应的内容

   * Session简介

     * Server端机制，在服务器上保存信息
     * 解析Client请求并操作Session id，按需保存状态信息

   * Session实现方式
   
     * 使用Cookie实现 (客户端Cookie保存服务器发来的Session id,下次请求回传Cookie其实就包含Session id)
   
     * 使用URL回写实现 (所有连接都携带Session参数，任何连接跳转都带着Session id回服务器)
   
       ![](https://github.com/zhangshity/technote/blob/master/Resources/Session的Cookie实现.png)
   
   * Cookie和Session的区别
   
     * Cookie数据放在客户端浏览器上，Session数据放在服务器上
     * Session相对Cookie更安全
   
     * 若考虑减轻服务器负担，应当使用Cookie
   
   ---
   
   ##### 8. HTTP和HTTPS
   
   1. HTTP (全称：HyperText Transfer Protocol，超文本传输协议)
   
   2. HTTPS (全称：Hyper Text Transfer Protocol over Secure Socket Layer 或 Hypertext Transfer Protocol Secure，超文本传输安全协议)
   
   3. SSL (全称：Security Socket Layer,安全套接层，SSL3.0改名为TSL)
   
      加密方式
   
      * 对称加密: 加密解密使用同一个秘钥(AES)
      * 非对称加密: 加密解密使用的秘钥不同 (RSA)
      * 哈希算法(MD5)
      
      * 数字签名
      
   4. HTTPS数据传输流程
   
      * 浏览器讲支持的加密算法信息发送给服务器
      * 服务器选择一套浏览器支持的加密算法，以证书的形式回发浏览器
   
      * 浏览器验证证书合法性，并结合证书公钥加密信息发送给服务器
      * 服务器使用私钥解密信息，验证哈希，加密响应消息回发游览器
   
      * 游览器解密响应消息，并对消息进行验真，之后进行加密交互数据
   
   5. HTTP和HTTPS区别
      * HTTPS需要到CA申请证书，HTTP不需要
      * HTTPS密文传输，HTTP明文传输
      * 连接方式不同，HTTPS默认使用443端口，HTTP使用80端口
      * HTTPS = HTTP + 加密 + 认证 + 完整性保护，较HTTP安全
   
   ---
   
   ##### 9. Socket
   
   1. 定义：Socket是对TCP/IP协议的抽象，是操作系统对外开放的接口
   
   2. Socket通信流程：
   
      ![socket](https://github.com/zhangshity/technote/blob/master/Resources/socket通信流程.png)
   
   3. Java编程https://github.com/zhangshity/aysos/tree/master/src/main/java/com/zcy/net

---





## 3 数据库

##### 1. 索引

1. 二叉查找树
2. B -Tree
3. B+ -Tree
4. Hash结构









---



## 4 Redis

##### 1. 基本类型

* **String**  最基本数据类型，二进制安全

```redis
set name "Allen"
get name

set age 18
get age

set city "LA"
get city


set count 1  --OK
get count    --"1"
incr count   --Integer(2)
get count    --"2"

```

* **Hash** String元素组成的字典，适合用于存储对象

```redis
hmset student name "Allen" age 18 city "LA"
----
OK

hget student name
hget student age
hget student city

hset student city "D.C."
hget student city
```

* **List** 列表，按照String元素的插入顺序排序

```redis
lpush mylist aaa
lpush mylist bbb
lpush mylist ccc

lrange mylist 0 10
----
1)"ccc"
2)"bbb"
3)"aaa"
```

* **Set** String元素组成的无序集合，通过哈希表实现，不允许重复

```redis
sadd myset "aaa"
sadd myset "bbb"
sadd myset "ccc"
sadd myset 112
sadd myset 156

smembers myset
```

* **ZSet** (Sorted Set)通过分数来为集合中的成员进行从小到大排序

```redis
zadd myzset 2 bdc
zadd myzset 1 abc
zadd myzset 3 ced
zadd myzset 2 bdc

zrangebuscore myzset 0 10
----
1)"abc"
2)"bdc"
3)"cde"

```

* HyperLogLog 计数
* Geo 地理信息







---



## 5 Linux

##### 1. 架构

![linux](https://github.com/zhangshity/technote/blob/master/Resources/linux架构.png)

* 用户态（用户空间)
* 内核态  (内核)

##### 2. 进程状态

* 基本三态(就绪、执行、阻塞)
![](https://github.com/zhangshity/technote/blob/master/Resources/%E7%B3%BB%E7%BB%9F%E8%BF%9B%E7%A8%8B%E5%9B%BE3.jpg)
* 加入挂起suspend 
![](https://github.com/zhangshity/technote/blob/master/Resources/%E7%B3%BB%E7%BB%9F%E8%BF%9B%E7%A8%8B%E7%8A%B6%E6%80%81%E5%9B%BE1.jpg)
* 完整状态(包括创建和消亡) 
![](https://github.com/zhangshity/technote/blob/master/Resources/%E7%B3%BB%E7%BB%9F%E8%BF%9B%E7%A8%8B%E7%8A%B6%E6%80%81%E5%9B%BE2.jpeg)





---
## 6 JVM

##### 1. 反射

* Java的反射机制是在*<u>运行状态</u>*中，

  对于任意一个类，都能知道这个类的所有属性和方法；

  对于任意一个对象，都能任意调用它的任意属性和方法；

  这种**动态获取信息**以及**动态调用对象方法**的功能称为java语言的反射机制。

* 代码示例：
  
  ```java
  // 三种反射获取实例的方式
  //* 1)Class类静态方法
  	Class.forName("com.zcy.reflection.Person");   //--最常用
  //* 2)每个类继承的Object类的
  	person.getClass() //方法;                     //--需要先实例化对象
  //* 3)对象实例
  	Class clazz = Person.class                    //--？
  
  
  // 构造器获取方法
   Constructor constructor= clazz.getConstructor();  
  
  // 实例化对象
   //1)
   Object obj  = clazz.newInstance();        
   //2)
   Object obj2 = constructor.newInstance();
  
  // 获取对象方法
   Method method1 = obj.getMethod("setId",int.class);              //--方法名,参数 获取
   Method method2 = obj.getDeclaredMethod("setId",int.class);      //--强制获取,包括私有
   Method[] methods1 = obj.getMethods();                           //--所有方法
   Method[] methods2 = obj.getDeclaredMethods();                   //--强制获取所有方法
  
  // 获取对象字段
   Field field1 = obj.getField("id");                              //--字段名获取
   Field field2 = obj.getDeclaredField("id");                      //--强制获取,包括私有
   Field[] fields1 = obj.getFields();                              //--所有字段
   Field[] fields2 = obj.getDeclaredFields();                      //--强制获取所有字段
  
  ```
  
  

##### 2. ClassLoader

* 定义

  > 负责通过将Class文件里的二进制数据流装载进系统，然后交给Java虚拟机进行连接、初始化等操作。
  >
  > ```java
  > public abstract class ClassLoader {
  >   
  >   protected Class<?> loadClass(String name, boolean resolve) 
  >    		throws ClassNotFoundException
  >   {synchronized (getClassLoadingLock(name)) {
  >         {... c = findClass(name); ...}
  >     return c;}
  >   }
  >   
  >   protected Class<?> findClass(String name) throws ClassNotFoundException {
  >         throw new ClassNotFoundException(name);
  >   }//需要自定义继承类实现
  >   
  >   protected final Class<?> defineClass(String name, byte[] b, int off, int len)
  >        throws ClassFormatError
  >   {return defineClass(name, b, off, len, null);}
  >   
  >   
  >   //核心加载方法(最终调用)
  >   private native Class<?> defineClass0(String name, byte[] b, int off, int len,
  >                                          ProtectionDomain pd);
  >   private native Class<?> defineClass1(String name, byte[] b, int off, int len,
  >                                          ProtectionDomain pd, String source);
  >   private native Class<?> defineClass2(String name, java.nio.ByteBuffer b,
  >                                          int off, int len, ProtectionDomain pd,
  >                                          String source);
  > }
  > ```
  >
  > 自定义ClassLoader实现：
  >
  > https://github.com/zhangshity/aysos/tree/dfffe5b75d41ac7debf1b9ec8e2b3fe54c82be3f/src/main/java/com/zcy/_classloader
  >
  > 子类继承抽象父类，不实现父类方法，main中调用此未实现方法：
  >
  > https://github.com/zhangshity/aysos/tree/dfffe5b75d41ac7debf1b9ec8e2b3fe54c82be3f/src/main/java/com/zcy/_extends/mthd_in_fathr_cls

  

* 种类

  > 1.BootStrapClassLoader：C++编写，加载核心库java.*    (此类库位于`$JAVA_HOME/jre/lib`)
  >
  > 2.ExtClassLoader：Java编写，加载扩展库javax.*    (此类库位于`$JAVA_HOME/jre/lib/ext`)
  >
  > 3.AppClassLoader：Java编写，加载程序所在目录    (位于`$CLASSPATH`下)
  >
  > 4.自定义ClassLoader：Java编写，定制化加载
  >
  > ```java
  > //Bootstrap ClassLoader
  > System.out.println(System.getProperty("sun.boot.class.path"));
  > //Extendsion ClassLoader
  > System.out.println(System.getProperty("java.ext.dirs"));
  > //Application ClassLoader
  > System.out.println(System.getProperty("java.class.path"));
  > ```
  
  
  
* 加载流程

  > 1. 编译器将 **Student.java** 源文件编译为 **Student.class** 字节码文件
  > 2. ClassLoader将字节码文件转换为JVM中的`Class<Student>`对象
  > 3. JVM利用`Class<Student>`对象实例化为**Student**对象

* 双亲委派模型

  > 双亲委派机制工作过程：
  >
  > 1. 类加载器收到类加载的请求，查看已被加载，有就返回；没有就向上找父类；
  >
  > 2. 把这个请求委托给父加载器去完成，一直向上委托，直到启动类加载器；
  >
  > 3. 启动器加载器检查能不能加载（使用findClass()方法），能就加载（结束）；否则，抛出异常，通知子加载器进行加载。
  >
  > 4. 重复步骤三
  >
  > * 从下向上判断是否加载过，加载过就返回，没有就丢给父类去加载，如果父类还有父类就继续向上丢。-------到顶层BootstrapClassLoader就开始逐层向下问是否可以加载(在自定义的findClass()中实现)，能加载就加载不能就往子类丢。
  >
  >   ![](https://github.com/zhangshity/technote/blob/bd9ea055654721c148ed6147239a626646daa7a1/Resources/CL%E5%8F%8C%E4%BA%B2%E5%A7%94%E6%B4%BE%E6%9C%BA%E5%88%B6.jpg)
  >
  > *  **双亲委派机制源码分析：**
  >
  >   ```java
  >   protected Class<?> loadClass(String name, boolean resolve)
  >           throws ClassNotFoundException
  >       {
  >           synchronized (getClassLoadingLock(name)) {
  >               // First, check if the class has already been loaded
  >               Class<?> c = findLoadedClass(name); //1.判断类是否已经加载,加载了就返回
  >               if (c == null) {                    //2.没加载就一直循环loadClass到顶层
  >                   long t0 = System.nanoTime();
  >                   try {
  >                       if (parent != null) {
  >                           c = parent.loadClass(name, false);
  >                       } else {
  >                           c = findBootstrapClassOrNull(name); //到了顶层(c代码实现)
  >                       }                      //顶层加载类      //可能没有加载返回null
  >                   } catch (ClassNotFoundException e) {
  >                       // ClassNotFoundException thrown if class not found
  >                       // from the non-null parent class loader
  >                   }
  >                        //顶层没有加载，返回对象就依然为null
  >                   if (c == null) {                //3.开始从顶层开始向下加载
  >                       // If still not found, then invoke findClass in order
  >                       // to find the class.
  >                       long t1 = System.nanoTime();
  >                       c = findClass(name);        //4.向下加载过程为子类覆盖方法findClass()自定义
  >   
  >                       // this is the defining class loader; record the stats
  >                       sun.misc.PerfCounter.getParentDelegationTime().addTime(t1 - t0);
  >                       sun.misc.PerfCounter.getFindClassTime().addElapsedTimeFrom(t1);
  >                       sun.misc.PerfCounter.getFindClasses().increment();
  >                   }
  >               }
  >               if (resolve) {
  >                   resolveClass(c);
  >               }
  >               return c;
  >           }
  >       }
  >   ```
  >
  >   

##### 3. JVM内存模型

* ![](https://github.com/zhangshity/technote/blob/master/Resources/JVM内存模型.png)
* 



## 7 GC







---

## 8 Java多线程与并发

* [runoob教程参考]https://www.runoob.com/java/java-multithreading.html

* [OpenJDK源码]http://hg.openjdk.java.net/

  > ![Java线程学习框架终极版](https://github.com/zhangshity/technote/blob/master/Resources/Java%E7%BA%BF%E7%A8%8B%E5%AD%A6%E4%B9%A0%E6%A1%86%E6%9E%B6%E7%BB%88%E6%9E%81%E7%89%88.png)

##### 1. 线程和进程的区别

* 进程和线程的由来

  ![proces-status](https://github.com/zhangshity/technote/blob/master/Resources/%E7%BA%BF%E7%A8%8B%E5%92%8C%E8%BF%9B%E7%A8%8B%E7%9A%84%E7%94%B1%E6%9D%A5.png)
  
* 进程(Process)是资源分配的最小单位，线程(Thread)是CPU调度的最小单位

  * 所有与进程相关的资源都被记录在PCB
  * 进程是抢占处理机的调度单位。线程属于某个进程，共享其资源
  * 线程只由堆栈寄存器、程序计数器和TCB组成

##### 2. 线程的状态

* 6个状态

  > **①初始(NEW)**：新创建了一个线程对象，但还没有调用start()方法。
  >
  > ②**运行(RUNNABLE)**：Java线程中将就绪（ready）和运行中（running）两种状态笼统的成为“运行”。
  > 线程对象创建后，其他线程(比如main线程）调用了该对象的start()方法。该状态的线程位于可运行线程池中，等待被线程调度选中，获取cpu 的使用权，此时处于就绪状态（ready）。就绪状态的线程在获得cpu 时间片后变为运行中状态（running）。
  >
  > ③**阻塞(BLOCKED)**：表线程阻塞于锁。
  >
  > ④**等待(WAITING)**：进入该状态的线程需要等待其他线程做出一些特定动作（通知或中断）。
  >
  > ⑤**超时等待(TIME_WAITING)**：该状态不同于WAITING，它可以在指定的时间内自行返回。
  >
  > ⑥**终止(TERMINATED)**：表示该线程已经执行完毕。

* [线程状态切换参考贴]https://www.cnblogs.com/cowboys/p/9315331.html

* 线程状态转换图解

  >![线程状态图解1](https://github.com/zhangshity/technote/blob/master/Resources/java%E7%BA%BF%E7%A8%8B%E5%9B%BE2.png)
  >
  >​        线程状态转换图解 [1]
  >
  >![线程状态图解2](https://github.com/zhangshity/technote/blob/master/Resources/Java%E7%BA%BF%E7%A8%8B%E5%91%A8%E6%9C%9F%E5%9B%BE1.png)
  >
  >​        线程状态转换图解 [2]

* ...

##### 3.线程的优先级(Priority)

* Java 线程的优先级是一个整数，其取值范围是 **1 (Thread.MIN_PRIORITY)  —  10 (Thread.MAX_PRIORITY)**

* 默认情况下，每一个线程都会分配一个优先级 **NORM_PRIORITY（5）**。

* 具有较高优先级的线程对程序更重要，并且应该在低优先级的线程之前分配处理器资源。但是，线程优先级不能保证线程执行的顺序，而且非常依赖于平台。

##### 4. 创建线程的三种方法

* 继承`Thread`类
* 实现`Runnable`接口
* 通过 `Callable` 和` Future `创建线程

##### 5. start() 和 run() 区别

- **1.start()** 方法来启动线程，真正实现了多线程运行。这时无需等待 run 方法体代码执行完毕，可以直接继续执行下面的代码；通过调用 Thread 类的 start() 方法来启动一个线程， 这时此线程是处于就绪状态， 并没有运行。 然后通过此 Thread 类调用方法 run() 来完成其运行操作的， 这里方法 run() 称为线程体，它包含了要执行的这个线程的内容， run 方法运行结束， 此线程终止。然后 CPU 再调度其它线程。

  ```java
  public synchronized void start() { ......
          try {
              start0(); ......
          } finally {......}
  }
  
  private native void start0();
  ```
  
  
  
- **2.run()** 方法当作普通方法的方式调用。程序还是要顺序执行，要等待 run 方法体执行完毕后，才可继续执行下面的代码； 程序中只有主线程——这一个线程， 其程序执行路径还是只有一条， 这样就没有达到写线程的目的。

##### 6. sleep() 和 wait()区别

> [代码详解]https://github.com/zhangshity/aysos/blob/master/src/main/java/com/zcy/thread/wait_sleep_notify/WaitSleepNotifyDemo.java
>
> * sleep(long millis) 是Thread类下的 static native方法
> * sleep() 只是让出CPU，使线程进入阻塞状态，并不影响锁
> * wait() 是Object下的final native方法
>
> * wait()    1.解除线程对此锁的占用 (释放锁)    2.使占用锁的线程进入等待队列    3.占用锁的线程让出CPU

##### 7. notify() 和notifyAll()区别

> [代码详解]https://github.com/zhangshity/aysos/blob/master/src/main/java/com/zcy/thread/wait_sleep_notify/WaitSleepNotifyDemo.java
>
> 均是Object类下的final native方法
>
> ```java
> public final native void notify();
> public final native void notifyAll();
> ```
>
> * 锁池 EntryList
> * 等待池WaitSet

* notifyAll() ：会让所有处于等待池中的线程全部进入锁池 去竞争获取锁的机会 (已经进入锁池线程不能回到等待池，只能等待其他机会获取锁)
* notify() ：只会随机选取一个处于等待池中的线程进入锁池去竞争获取锁的机会

##### 8. yield()

> * **概念**：当调用`Thread.yield()`函数时，会给线程调度器一个当前线程愿意让出当前CPU使用资源的暗示。(线程调度器可能会忽略此暗示)
>
> * Thread类下的static native方法
>
>   ```java
>   public static native void yield();
>   ```
>
> * 代码示例：
>
>   [1] https://github.com/zhangshity/aysos/blob/master/src/main/java/com/zcy/thread/yield/YieldDemo.java
>

##### 9. interupt()

> * 概念：调用interrut()方法，通知线程应该中断了（替代废弃的stop()方法）
>
>   * 如果线程处于被阻塞状态，那么线程立即退出被阻塞状态，并抛出一个InterruptedException异常
>   * 如果线程处于正常活动状态，那么会将该线程的中断标志设置为true。被设置中断标志的线程将继续正常运行，不受影响。
>
> * Thread类下的普通方法（本质是native interrupt0()方法）
>
>   ```java
>   public void interrupt() { ......
>           synchronized (blockerLock) { ......
>           interrupt0();
>   }
>                            
>   private native void interrupt0();
>   ```
>
> * 代码示例：
>
>   [1] https://github.com/zhangshity/aysos/blob/master/src/main/java/com/zcy/thread/intetrrupt/InterruptDemo.java

##### 10. join()

> * **概念**：一个线程t2，调用另一个线程`t1.join()`方法，直到线程t1完成其才继续进行（本质是wait()方法）
>
> * Thread类下的final普通方法
>
>   ```java
>   public final void join() throws InterruptedException {
>     join(0);
>   }
>   
>   public final synchronized void join(long millis, int nanos)
>   throws InterruptedException { ......
>     join(millis);
>   }
>   
>   public final synchronized void join(long millis)
>   throws InterruptedException { ......
>     if (millis == 0) {
>         while (isAlive()) {
>             wait(0);}
>     } else {
>         while (isAlive()) { ......
>             wait(delay); ......}}
>   }
>   ```
>
> * 首先`join()`是一个synchronized方法， 里面调用了`wait()`，这个过程的目的是让持有这个同步锁的线程进入等待。那么谁持有了这个同步锁呢？答案是主线程——
> (因为主线程调用了thread-A.join()方法，相当于在threadA.join()代码这块写了一个同步代码块）。谁去执行了这段代码呢，是主线程，所以主线程被wait()了。
> 然后在子线程thread-A执行完毕之后，JVM会调用lock.notify_all(thread);唤醒持有threadA这个对象锁的线程，也就是主线程，会继续执行。
>
> * 代码实例：
>
>   [1] https://github.com/zhangshity/aysos/tree/master/src/main/java/com/zcy/thread/join/join_print
>
>   [2] https://github.com/zhangshity/aysos/blob/master/src/main/java/com/zcy/thread/join/DemoThread.java
>

##### 11. synchronized原理

>* 锁：对象锁、类锁
>
> * 对象锁
>
>   ```java
>   //1.同步代码块，锁是()中的对象
>   synchronized(this){}
>   synchronized(类实例对象){}
>   //2.同步非静态方法，锁是当前实例对象
>   public synchronized String lockedMethod(){} 
>   ```
>
> * 类锁
>
>   ```java
>   //1.同步代码块，锁是()中的类对象
>   synchronized(类.class){}
>   //同步静态方法,锁是当前类对象
>   public synchronized static String lockedMethod(){}
>   ```
>
> #### 总结：
>
> 1. 有线程对象访问同步代码块时，另外的线程可以访问该对象的非同步代码块(为加锁代码块)
> 2. 若锁住的是同一个对象，一个线程在访问对象同步代码块时，另外一个访问对象的同步代码块的线程会被阻塞
> 3. 若锁住的是同一个对象，一个线程在访问对象的同步方法时，另外一个访问对象的同步方法的线程会被阻塞
> 4. 若锁住的是同一对象，一个线程在访问对象的同步代码块时，另一个访问对象同步方法的线程会被阻塞，反之亦然
> 5. 同一个类的不同对象的对象锁互不干扰
> 6. 类锁是一种特殊的对象锁，因此表现和上述1,2,3,4一致，而由于一个类只有一把对象锁(class对象)，所以同一个类的不同对象使用类锁，将会是同步的
> 7. 类锁和对象锁互不干扰
>
>---
>
>* synchronized底层实现原理
>  * 对象在内存中的布局：对象头、实例数据、对其填充
>  * 

##### 12. synchronized和Reentrentlock区别



##### 13. 线程池

> * 定义：线程池，其实就是一个容纳多个线程的容器，其中的线程可以反复使用，省去了频繁创建线程对象的操作，无需反复创建线程而消耗过多资源。（是什么）
>
> * 原因：
>
>   为什么需要用到线程池呢？每次用的时候手动创建不行吗？在java中，如果每个请求到达就创建一个新线程，开销是相当大的。在实际使用中，创建和销毁线程花费的时间和消耗的系统资源都相当大，甚至可能要比在处理实际的用户请求的时间和资源要多的多。除了创建和销毁线程的开销之外，活动的线程也需要消耗系统资源。如果在一个jvm里创建太多的线程，可能会使系统由于过度消耗内存或“切换过度”而导致系统资源不足。为了防止资源不足，需要采取一些办法来限制任何给定时刻处理的请求数目，尽可能减少创建和销毁线程的次数，特别是一些资源耗费比较大的线程的创建和销毁，尽量利用已有对象来进行服务。（为什么）
>
> * 功能：
>
>   线程池主要用来解决线程生命周期开销问题和资源不足问题。通过对多个任务重复使用线程，线程创建的开销就被分摊到了多个任务上了，而且由于在请求到达时线程已经存在，所以消除了线程创建所带来的延迟。这样，就可以立即为请求服务，使用应用程序响应更快；另外，通过适当的调整线程中的线程数目可以防止出现资源不足的情况。（什么用）
>   
> * Executors
>
>   ```java
>       public static ExecutorService newFixedThreadPool(int nThreads) {
>           return new ThreadPoolExecutor(nThreads, nThreads,
>                                         0L, TimeUnit.MILLISECONDS,
>                                         new LinkedBlockingQueue<Runnable>());
>       }
>   
>       public static ExecutorService newCachedThreadPool() {
>           return new ThreadPoolExecutor(0, Integer.MAX_VALUE,
>                                         60L, TimeUnit.SECONDS,
>                                         new SynchronousQueue<Runnable>());
>       }
>   
>       public static ExecutorService newWorkStealingPool(int parallelism) {
>           return new ForkJoinPool
>               (parallelism,
>                ForkJoinPool.defaultForkJoinWorkerThreadFactory,
>                null, true);
>       }
>   
>       public static ExecutorService newSingleThreadExecutor() {
>           return new FinalizableDelegatedExecutorService
>               (new ThreadPoolExecutor(1, 1,
>                                       0L, TimeUnit.MILLISECONDS,
>                                       new LinkedBlockingQueue<Runnable>()));
>       }
>   
>   ```
>
>   
>
> * Fork/Join框架
>
>   * 把大任务分割成若干小任务并行执行，最终汇总每个小任务结果后得到大任务结果的框架。
>   * Work-Stealing算法：某个线程从其他队列里窃取任务来执行
>
> * Executor框架：
>
>   ![](https://github.com/zhangshity/technote/blob/master/Resources/Executor%E6%A1%86%E6%9E%B6.png)
>
> * J.U.C三个Executor接口
>
>   * Executor：运行新任务的简单接口，将任务提交和任务执行细节解耦
>
>     ```java
>     public interface Executor {
>         void execute(Runnable command);
>     }
>     //Demo
>     Thread t = new Thread();
>     t.start();
>     Thread t1 = new Thread();
>     executor.execute(t);
>     ```
>
>     
>
>   * ExecutorService：具备管理执行器和任务生命周期的方法，提交任务机制更完善
>
>   * ScheduledExecutorService：支持Future和定期执行任务
>
>   ![](https://github.com/zhangshity/technote/blob/master/Resources/ThreadPoolExecutor%E5%B7%A5%E4%BD%9C%E6%B5%81%E7%A8%8B%E5%9B%BE.png)
>
> * 线程池状态
>
>   1. RUNNING：能接受新提交的任务，并且也能处理阻塞队列中的任务
>   2. SHUTDOWN：不接受新提交的任务，但可以处理存量任务
>   3. STOP：不接受新提交任务，也不处理存量任务
>   4. TIDYING：所有任务都已终止
>   5. TERMINATED：terminated()方法执行完后进入该状态
>
>   * 线程池状态转化图
>
>     ![](https://github.com/zhangshity/technote/blob/master/Resources/%E7%BA%BF%E7%A8%8B%E6%B1%A0%E7%8A%B6%E6%80%81%E8%BD%AC%E5%8C%96%E5%9B%BE.png)
>
>   * 工作线程的生命周期
>
>     ![](https://github.com/zhangshity/technote/blob/master/Resources/%E5%B7%A5%E4%BD%9C%E7%BA%BF%E7%A8%8B%E7%9A%84%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F.png)
>
>     

​	

---

## 10 类库

 ##### 1 异常



##### 2 Collection 集合框架

> ~ 数据结构
>
> * 数组和链表的区别
> * 链表的操作(反转、链表环路检测、双向链表、循环链表)
> * 队列、栈
> * 二叉树的遍历方式 递归和非递归实现
> * 红黑树的旋转

> ~ 算法
>
> * 内部排序：递归排序、交换排序(冒泡 快速)、选择排序、插入排序
> * 外部排序：有限内存配合海量外部存储，处理超大数据集

![](https://github.com/zhangshity/technote/blob/master/Resources/List%E5%92%8CSet.png)



##### J.U.C包(java.util.concurrent)

> 

---


## 11 Spring

##### 1. IOC

* IOC原理(Inversion of Control)
  * 上层依赖下层
    ![](https://github.com/zhangshity/technote/blob/master/Resources/上层依赖下层-原始.png)
  
  * 上层依赖下层-修改下层类导致的情况(大量的改动)
  
    ![](https://github.com/zhangshity/technote/blob/master/Resources/上层依赖下层-参数修改.png)
  
  * 利用DI的思想(底层类作为参数传递给上层类)
  
    ![](https://github.com/zhangshity/technote/blob/master/Resources/依赖注入-原始.png)
  
  * 利用DI的思想-修改下层类
  
    ![](https://github.com/zhangshity/technote/blob/master/Resources/依赖注入-参数修改.png)
  
  * **总结**
  
    普通的上层类依赖下层类的写法，看似简单，但如果依赖的类太多，如果要做改动其工作量是不可接收的，几乎没有可维护性。
  
    而利用依赖注入的思想，把下层类作为参数传递(注入)给上层类，能很好的解耦，下层类的改动几乎不影响上层类的代码结构。
  
    但是这样会不停的new新的对象来传递给上层，工作量也是很繁琐，这也就是spring IOC Container要做得工作—负责创建对象，并对操作者隐藏其步骤，只用关心其业务逻辑即可。
  
* DI : 底层类作为参数传递给上层类，实现上层对下层的控制    

* IOC Container及优势：
  * 避免在各处new来创建类，并且可以统一维护
  * 创建实例的时候不需要了解其中的细节
  * ![](https://github.com/zhangshity/technote/blob/master/Resources/IOC容器优势.png)
  
* IOC/DL/DI的关系

  * ![](https://github.com/zhangshity/technote/blob/master/Resources/IOC和DI:DL关系1.png)
  * ![](https://github.com/zhangshity/technote/blob/master/Resources/IOC和DI:DL关系2.png)

* Spring IOC

  ![](https://github.com/zhangshity/technote/blob/master/Resources/Spring%20IOC.png)

  * 支持的功能：依赖注入、依赖检查、自动装配、支持集合、指定初始化方法和销毁方法、支持回调方法

  * 核心接口：**BeanFactory**、**ApplicationContext**

  * BeanFactory (顶层接口) : 

    > 1.提供IOC的配置机制
    >
    > 2.包含Bean的各种定义,便于实例化Bean
    >
    > 3.建立Bean之间的依赖关系
    >
    > ![](https://github.com/zhangshity/technote/blob/master/Resources/BeanFactory体系结构.png)
  
  * ApplicationContext (继承多个接口) : 
  
    ```java
    public interface ApplicationContext extends EnvironmentCapable,ListableBeanFactory, HierarchicalBeanFactory,MessageSource,ApplicationEventPublisher,ResourcePatternResolver{
    	String getId();
    	String getApplicationName();
    	String getDisplayName();
    	long getStartupDate();
    	@Nullable
    	ApplicationContext getParent();
    	AutowireCapableBeanFactory getAutowireCapableBeanFactory() throws IllegalStateException;
    }
    ```
  
    > 1.继承<u>BeanFactory</u>接口：能够管理和装配Bean 
    >
    > 2.继承<u>ResourcePatternResolver</u>接口：能够加载资源文件 
    >
    > 3.继承<u>MessageSource</u>接口：能够实现国际化等功能 
    >
    > 4.继承<u>ApplicationEventPublisher</u>接口：能够注册监听器，实现监听机制
  
  * BeanFactory和ApplicationContext的比较：
  
    > 1.BeanFactory是Spring框架的基础设施，面向Spring
    >
    > 2.ApplicationContext面向使用Spring框架的开发者
    >
    > ![](https://github.com/zhangshity/technote/blob/master/Resources/BeanFactory%E5%92%8CApplicationContext%E7%9A%84%E5%85%B3%E7%B3%BB.png)
    
  * refresh方法
  
    > 1.为IOC容器及Bean的生命周期管理提供条件
    >
    > 2.刷新Spring上下文信息，定义上下文加载流程
  
  * getBean方法
  
    > 代码逻辑：
    >
    > 1.转换beanName 2.从缓存中加载实例 3.实例化Bean 4.检测parentBeanFactory 5.初始化依赖的Bean 6.创建Bean
  
  * Spring的作用域
  
    > singleton: Spring的默认作用域，容器内拥有唯一的Bean实例
    >
    > prototype: 针对每个getBean请求，容器都会创建一个Bean实例
    >
    > request: 会为每个Http请求创建一个Bean实例
    >
    > session: 会为每个session创建一个Bean实例
    >
    > globalSession: 会为每个全局的Http Session创建一个Bean实例,该作用域仅对Portlet有效

##### 2.AOP原理

* AOP原理(Aspect Oriented Programming)

  * 三种织入方式

    > 编译时织入：需要特殊的Java编译器，如AspectJ
    >
    > 类加载织入：需要特殊的Java编译器，如ApectJ和AspectWerkz
    >
    > 运行时织入：Spring采取的方式，通过动态代理的方式，实现简单

  * AOP的实现(JdkProxy和Cglib)

    > 由AopProxyFactory根据AdvisedSupport对象的配置来决定
    > 默认策略如果目标类是接口，则用JDKProxy来实现，否则用后者
    >
    > JDKProxy的核心：InvocationHandler接口和Proxy类
    >
    > Cglib：以继承的方式动态生成目标类的代理
    >
    > 
    >
    > JDKProxy：通过Java的内部反射机制实现
    >
    > Cglib：借助ASM实现
    >
    > 反射机制在生成类的过程中比较高效
    >
    > ASM在生成类之后的执行过程中比较高效













---

## 补充

##### 1.HashMap和HashTable

> * 共性：
>   * 都implements了<u>Map</u>接口
>   * 都可自动扩容
>   * 底层都是数组+链表 (1.8之后HashMap为数组+链表+红黑树)
>   * 都可自动扩容




> * 区别：
>   
>   * HashMap extends了<u>AbstractMap</u>抽象类，HashTable extends了<u>Dictionary</u>抽象类
>   
>   * HashMap是线程不安全的，HashTable是线程安全的
>   * 遍历方式不同



HashMap 1.8和1.7对比：

* 详见简书[转]https://www.jianshu.com/p/8324a34577a0

* https://github.com/zhangshity/technote/blob/master/Java/HashMap源码分析(jdk1.8).md

##### 2.面试时，问：重载（Overload）和重写（Override）的区别？

```
答：
方法的重载和重写都是实现多态的方式，区别在于前者实现的是编译时的多态性，而后者实现的是运行时的多态性。
重载发生在一个类中，同名的方法如果有不同的参数列表（参数类型不同、参数个数不同或者二者都不同）则视为重载；
重写发生在子类与父类之间，重写要求子类被重写方法与父类被重写方法有相同的参数列表，有兼容的返回类型，比父类被重写方法更好访问，不能比父类被重写方法声明更多的异常（里氏代换原则）。
重载对返回类型没有特殊的要求，不能根据返回类型进行区分。

```

> ##### 重写与重载之间的区别
>
> | 区别点   | 重载方法 | 重写方法                                       |
> | :------- | :------- | :--------------------------------------------- |
> | 参数列表 | 必须修改 | 一定不能修改                                   |
> | 返回类型 | 可以修改 | 一定不能修改                                   |
> | 异常     | 可以修改 | 可以减少或删除，一定不能抛出新的或者更广的异常 |
> | 访问     | 可以修改 | 一定不能做更严格的限制（可以降低限制）         |
>
> ------
>
> ##### 总结
>
> 方法的重写(Overriding)和重载(Overloading)是java多态性的不同表现，重写是父类与子类之间多态性的一种表现，重载可以理解成多态的具体表现形式。
>
> - (1)方法重载是一个类中定义了多个方法名相同,而他们的参数的数量不同或数量相同而类型和次序不同,则称为方法的重载(Overloading)。
> - (2)方法重写是在子类存在方法与父类的方法的名字相同,而且参数的个数与类型一样,返回值也一样的方法,就称为重写(Overriding)。
> - (3)方法重载是一个类的多态性表现,而方法重写是子类与父类的一种多态性表现。
>
> ![img](https://www.runoob.com/wp-content/uploads/2013/12/overloading-vs-overriding.png)
>
> ![img](https://www.runoob.com/wp-content/uploads/2013/12/20171102-1.jpg)	
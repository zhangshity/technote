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















---



## 5 Linux

##### 1. 架构

![linux](https://github.com/zhangshity/technote/blob/master/Resources/linux架构.png)

* 用户态（用户空间)
* 内核态  (内核)



 







---


## 11 Spring

##### 1. IOC

* IOC原理
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

##### 2.



---
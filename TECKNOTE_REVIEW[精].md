# TECKNOTE_REVIEW

@Author:Chunyang.Zhang

---

## 2-1网络

1. OSI参考模型：物理层、数据链路层、网络层、传输层、会话层、表示层、应用层
2. TPC/IP实现模型:物理层、网络层、传输层、应用层

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



3. 三次握手

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



4. 四次挥手

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

1. RTT
2. RTO
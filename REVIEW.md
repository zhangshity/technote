# REVIEW

@Author:Chunyang.Zhang

---

##### 2-1网络

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

3. 三次握手，四次挥手

   ![三次握手](/Users/zhangchunyang/Documents/SourcetreeGitRepo/technote/Resources/三次握手.png)
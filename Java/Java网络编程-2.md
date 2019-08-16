# Java 网络编程-2

[简书转]https://www.jianshu.com/p/a10e1174f24f
### IP地址

在`java.net`下提供了`InetAddress`用来保存IP地址，但该类没有向外提供构造方法，因此需要通过其提供的静态方法来获取该类对象，举例：

```java
InetAddress ip = InetAddress.getByName("xxx");  //通过主机名获取
System.out.println(ip); //主机名/保留地址
```

### url编码和解码

通过`URLEncoder.encode(String, Parser)`进行编码，使用`URLDecoder.decode(String, Parser)`进行解码，举例：

```java
String es = URLEncoder.encode("你好", "utf-8");
String ds = URLDecoder.decode(es, "utf-8");
System.out.println(es); //%E4%BD%A0%E5%A5%BD
System.out.println(ds); //你好
```

### TCP通信

在`java.net`下有`Socket`和`ServerSocket`类，分别用来实现`client`和`server`端。

##### 步骤

1.在服务端中通过`ServerSocket(port)`来绑定端口，然后在客户端中通过`Socket(ip, port)`来连接服务端。
2.在服务端中通过`accept()`来等待接收客户端连接，并保存到`Socket`对象中
3.客户端和服务端之间的通信需要先获取输入输出流（`getInputStream()`/`getOutputStream()`），然后通过`read()`/`write()`方法进行收发
4.最后记得使用`close()`方法关闭客户端和服务端的连接

##### 最简单TCP通信

###### Server端

```java
import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;

public class ServerTest {
    public static void main(String[] args) throws Exception{
        ServerSocket server = new ServerSocket(6666);
        while(true){
            Socket client = server.accept();
            System.out.println("新连接！");
            DataInputStream dis = new DataInputStream(client.getInputStream());
            System.out.println(dis.readUTF());
            dis.close();
            client.close();
        }
    }
}
```

###### Client端

```java
import java.io.*;
import java.net.Socket;

public class ClientTest{
    public static void main(String[] args) throws Exception {
        Socket client = new Socket("127.0.0.1", 6666);
        OutputStream ops = client.getOutputStream();
        DataOutputStream dos = new DataOutputStream(ops);
        dos.writeUTF("连接成功！");
        dos.flush();
        dos.close();
        client.close();
    }
}
```

##### 多线程服务端

只需要在`accept()`接收到新连接时启动一个新线程即可，举例：

```java
import java.io.DataInputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class ServerTest {
    public static void main(String[] args) throws Exception {
        ServerSocket server = new ServerSocket(6666);
        while (true) {
            final Socket client = server.accept();
            System.out.println("新连接！");
            new Thread() { // 启动一个新线程
                public void run() {
                    try {
                        DataInputStream dis = new DataInputStream(
                                client.getInputStream());
                        String rs;
                        while (true) {

                            if ((rs = dis.readUTF()).equals("-1")) {
                                client.close();
                            }
                            System.out.println(rs);
                        }
                    } catch (Exception e) {
                    }
                }
            }.start();
        }
    }
}
```

### UDP通信

UDP通信时，通过`DatagramPacket`类来构造数据报包，然后收发两端都实例化一个`DatagramSocket`来发送和接收数据报包。注意只有TCP分C/S端，在UDP里只有发送和接收端，且是可以互换的。

##### 最简单的UDP通信

###### 接收端

```java
import java.net.DatagramPacket;
import java.net.DatagramSocket;

public class ServerTest {
    public static void main(String[] args) throws Exception{
        byte buf[] = new byte[1024];
        DatagramPacket dp = new DatagramPacket(buf, buf.length);
        DatagramSocket ds = new DatagramSocket(6666);
        while(true){
            ds.receive(dp);
            System.out.println(new String(buf, 0, dp.getLength()));
        }
    }
}
```

###### 发送端

```java
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetSocketAddress;

public class ClientTest{
    public static void main(String[] args) throws Exception {
        byte buf[] = (new String("message!")).getBytes();
        DatagramPacket dp = new DatagramPacket(buf, buf.length, new InetSocketAddress("127.0.0.1", 6666));  //发送到的IP:PORT
        DatagramSocket ds = new DatagramSocket(9999);   //从9999端口发送
        ds.send(dp);
        ds.close();
    }
}
```

### URL编程

给资源定位好后，可以通过实例化url，从而可以通过该url定位到资源内容
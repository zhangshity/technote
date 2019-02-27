# JMeter多机测试配置方法

##### 利用JMeter进行负载测试的时候，使用单台机器模拟测试超过1000个行程的并发就有些力不从心，在执行的过程中，JMeter自身会自动关闭，要解决这个问题，可以使用分布式测试，运行多台机器运行所谓的 Agent 来分担 JMeter自身的压力，并借此来获取更大的并发用户数,但是需要进行相关的一些修改，具体如下：

-
* 1、在所有期望运行 JMeter 作为 Load Generator 的机器上安装 JMeter，并确定其中一台机器作为 Controller，其他的机器作为 Agent。然后运行所有 Agent 机器上的JMeter-server.bat文件——假定我们使用两台机器 192.168.0.1 和 192.168.0.2 作为 Agent；
-
* 2、在Controller 机器的 JMeter 安装目录下找到 bin 目录，再找到 JMeter.properties 这个文件，使用记事本或者其他文字编辑工具打开它；
-
* 3、在打开的文件中查找“remote_hosts=”这个字符串，你可以找到这样一行“remote_hosts=127.0.0.1”。其中的 127.0..0.1 表示运行 JMeter Agent 的机器，这里需要修改为“remote_hosts=192.168.0.1:1099,192.168.0.2:1099”——其中的 1099 为 JMeter 的 Controller 和 Agent 之间进行通讯的默认 RMI 端口号，端口号在运行Agent上面的jmeter-server.bat时，会显示出来，注意：有些高版本的JMeter不需要写port，remote_hosts=192.168.0.1就可以了；
-
* 4、保存文件，并重新启动 Controller 机器上的 JMeter.bat，并进入 Run -> Remote Start 菜单项，在这里可以看到远程启动菜单下面有192.168.0.1 ，192.168.0.1两个IP地址
-
* 5、如果要让某个电脑执行，可以点击改电脑的IP地址就可以，如果两个都要执行，可以点击Run 菜单下的“远程运行全部”菜单
-
* 6、有时候用作代理的机器太少，仍不能满足需要，则需要将作为Controller的电脑也当作Agent，则同样需要修改 JMeter.properties文件，将Controller的IP地址写入。同时，这个时候，需要打先打开Controller 电脑中JMeter下bin目录下的jmeter-server.bat，然后再打开JMeter.bat，此时，进入Run -> Remote Start菜单，可以看到Controller也作为远程机器进行运行。

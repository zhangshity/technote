# [Ubuntu 18.04 on Windows 10 更改 Oh-My-Zsh agnoster 主题下的目录背景色](https://www.cnblogs.com/Ricky81317/p/9062590.html)

> [转]<https://www.cnblogs.com/Ricky81317/p/9062590.html>

####  题外话

* 我的 MacBook Pro 已经使用了6年多的时间，尽管作为一个 .NET 程序员绝大部分时间都是在 Windows 下工作，直到 .NET Core 的逐步成熟。要说 Mac OS，最满意的地方就是它的终端 iTerm2 + Oh-My-Zsh，既好看又好用。然而在 MacBook Pro 里跑 Windows 无论是用 Parallels Desktop 虚拟机还是 BootCamp，都多多少少有些不便的地方，尤其是电池的续航力，完全无法开开心心的不插电源写代码写上3、4个小时，加上6年时间电池的老化，连 Mac OS 下都撑不住2、3小时。所以，虽然我之前给它升级了512G SSD, 16G RAM（2012款最后一代可以自行升级的MBP），但因为电池问题和 Windows 系统的问题，最终还是决定尝试换回一款 Windows 笔记本，毕竟微软这几年无论是拥抱开源、做 .NET Core，还是出的这些硬件都深得我心（可惜 Windows Phone 还是废了），感觉比苹果进步更大。而苹果已经在“轻薄”这2个字上走火入魔、不顾一切了。

* 如果你问我为何一个 .NET 程序员买 MBP？因为当年我换笔记本的时候被那一大票的 16:9 宽屏及 13xx * 7xx 分辨率的笔记本恶心到了，写代码完全接受不了那么扁的屏幕和那么低的分辨率，最后一怒之下买了十分昂贵的 16:10 屏幕的 15'' MBP...
* 如果你问我现在换了那款 Windows 笔记本，我现在用的是 Surface Book 2——绝对的生产力利器……只是比当年买的 MBP 还贵上一大大大截…… 😓

# 正篇

* 我本人还是非常喜欢 Windows 10 系统的，要说 Windows 相比类 Unit 系统最大的不足之处就是终端命令行部分非常弱，既不好看也不好用。。。那有什么办法弥补吗？也有，就是 Windows 10 里的 Linux 子系统！前几天从 Windows 10 自带的 Microsft Store 上下载安装了 Ubuntu 18.04，然后安装了 Zsh 和 Oh-My-Zsh 再设置成我最喜欢的 agnoster 主题，基本上和我以前用 MBP 的终端的效果非常接近了。看起来是这样的：

![DefaultFolderColor](https://github.com/zhangshity/technote/blob/master/Resources/agnoster1.png?raw=true)

除了没有 iTerm2 的各种窗口切分能力，单讲终端本身的使用已经和 Mac OS 下无异了，毕竟是同一套东西。但也有个小问题，就是当前路径这种蓝色背景、黑色字体实在是标准“程序员级别的审美”，那是完全看不清啊！怎么办？翻遍了整个互联网也没发现什么特别简单、有效的解决方法，最终还是靠自己想办法解决。说起来倒也简单，就是自己修改 agnoster 主题呗。

首先，在 Ubuntu 里用文本编辑器打开 agnoster 的主题文件：

```bash
vim ~/.oh-my-zsh/themes/agnoster.zsh-theme
```

然后找到这个地方：

![OriginalTheme](https://github.com/zhangshity/technote/blob/master/Resources/agnoster2.png?raw=true)

看到那个 `blue` 了吗？把它改成一个合适的颜色就行。我改成了 `075` 这个颜色：

![ChangeTheme](https://github.com/zhangshity/technote/blob/master/Resources/agnoster3.png?raw=true)

然后保存、退出，再关闭 Ubuntu 并重新打开，现在当前目录看起来是这样的：

![New Folder Color](https://github.com/zhangshity/technote/blob/master/Resources/agnoster5.png?raw=true)

是不是看起来好多了？

这种做法的缺点是改了主题文件导致 oh-my-zsh 的 repository 不“干净”了，估计下次升级 oh-my-zsh 之前需要还原才能升级。不过这已经是我目前最好的解决方法了。。。

最后，天晓得 `075` 是什么颜色？这里附上一个系统支持的颜色表：

![Terminal Colors](https://github.com/zhangshity/technote/blob/master/Resources/agnoster6.jpg?raw=true)
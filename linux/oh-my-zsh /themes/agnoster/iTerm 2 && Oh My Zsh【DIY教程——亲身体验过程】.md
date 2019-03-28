# iTerm 2 && Oh My Zsh【DIY教程——亲身体验过程】

* 年前，在搞终端的时候偶然一次机会，让我看到了各种强大的DIY界面，这让我很想去自己搞一个。于是在网上不断的寻找资源，也请教了大多数朋友。最终以失败告终。最近，本人又突然想起当时这件事，于是，决定边做笔记，边尝试当初失败的过程。经过一个晚上的时间，终于DIY出我梦寐以求的效果。

  #####最终DIY效果图:

![81f8a509gy1fn91lygevxj212q0tykc8](http://wx3.sinaimg.cn/mw690/81f8a509gy1fn91lygevxj212q0tykc8.jpg)

下面，我将分步骤讲解我是怎么一步一步完成DIY过程

### 1. 首先下载 [iTerm 2](<https://www.iterm2.com/>) 

### 2. 打开iTerm 2

### 3. 输入下面指令安装[oh-my-zsh](https://link.jianshu.com?t=https%3A%2F%2Fgithub.com%2Frobbyrussell%2Foh-my-zsh) 

```
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
```

```

```



### 4. 接下来安装[Powerline](https://link.jianshu.com?t=http%3A%2F%2Fpowerline.readthedocs.org%2Fen%2Flatest%2Finstallation.html) 

在官网有教程，我们只需要执行官网第一条安装指令就行

如果你的终端能够正常执行pip指令，那么直接执行下面的指令可以完成安装

```
pip install powerline-status
```

如果没有，则先执行安装pip指令

```
sudo easy_install pip
```

### 5. 下载、安装库[字体库](https://link.jianshu.com?t=https%3A%2F%2Fgithub.com%2Fpowerline%2Ffonts) 

1）将工程下载下来后cd到`install.sh`文件所在目录

2）执行指令安装字体库

执行`./install.sh`指令安装所有Powerline字体

安装完成后提示所有字体均已下载到`/Users/superdanny/Library/Fonts`路径下

All Powerline fonts installed to /Users/superdanny/Library/Fonts

### 6. 设置iTerm 2的Regular Font 和 Non-ASCII Font

安装完字体库之后，把iTerm 2的设置里的`Profile`中的`Text` 选项卡中里的`Regular Font`和`Non-ASCII Font`的字体都设置成 Powerline的字体，我这里设置的字体是12pt Meslo LG S DZ Regular for Powerline

![81f8a509gw1eva0ltpbjrj20po0f00w0](http://ww4.sinaimg.cn/mw690/81f8a509gw1eva0ltpbjrj20po0f00w0.jpg)



### 7. 配色方案

1）安装[配色方案](https://link.jianshu.com?t=https%3A%2F%2Fgithub.com%2Faltercation%2Fsolarized)

进入刚刚下载的工程的`solarized/iterm2-colors-solarized` 下双击 `Solarized Dark.itermcolors` 和 `Solarized Light.itermcolors` 两个文件就可以把配置文件导入到 iTerm2 里

2）配置配色方案

通过load presets选择刚刚安装的配色主题即可

![81f8a509gw1eva0lz9dryj20po0f0tbj](http://ww4.sinaimg.cn/mw690/81f8a509gw1eva0lz9dryj20po0f0tbj.jpg)



### 8. 使用agnoster主题

1）下载[agnoster](https://link.jianshu.com?t=https%3A%2F%2Fgithub.com%2Ffcamblor%2Foh-my-zsh-agnoster-fcamblor)主题

到下载的工程里面运行install文件,主题将安装到`~/.oh-my-zsh/themes`目录下

2）设置该主题
 进入`~/.zshrc`打开`.zshrc`文件，然后将`ZSH_THEME`后面的字段改为`agnoster`。`ZSH_THEME="agnoster"`（agnoster即为要设置的主题）

### 9. 增加指令高亮效果——[zsh-syntax-highlighting](https://link.jianshu.com?t=https%3A%2F%2Fgithub.com%2Fzsh-users%2Fzsh-syntax-highlighting) 

指令高亮效果作用是当用户输入正确命令时指令会绿色高亮，错误时命令红色高亮

1）cd到`.zshrc`所在目录

2）执行指令将工程克隆到当前目录

```
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
```

3）打开`.zshrc`文件，在最后添加下面内容

```
source XXX/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

保存文件。

注意：`xxx`代表`.zshrc`所在目录

4）`cd ~/.oh-my-zsh/custom/plugins`

5）再次打开`.zshrc`文件，在最后面添加下面内容

```
plugins=(zsh-syntax-highlighting)
```

保存文件。



------

## 问题解答区

1. 启动iTerm 2 默认使用dash改用zsh解决方法：`chsh -s /bin/zsh` 
2. 如果想切换回原来的dash：`chsh -s /bin/bash` 
3. 卸载`oh my zsh`，在命令行输入如下命令，回车即可：`uninstall_oh_my_zsh` 
4. 执行指令`pip install powerline-status`出错解决方法：
    需要下载苹果官方的[Command line](https://link.jianshu.com?t=https%3A%2F%2Fdeveloper.apple.com%2Fdownloads%2Findex.action%3Fname%3Dfor%2520Xcode%2520)。必須官方工具下载最新版 Command Line
5. ⌘+Q关闭iTerm 2 时每次弹窗提示问题：
    iTerm 2 中，进入`Preference`-`General`-`Closing栏目`，将`Confirm "Quit iTerm2(⌘Q)" command`选项勾选去掉就行
6. 找不到.zshrc文件问题：
    我这里将我的.zshrc文件分享出来。供大家下载[网盘](https://link.jianshu.com?t=http%3A%2F%2Fpan.baidu.com%2Fs%2F1sk1LqCt) 
7. 路径前缀的XX@XX太长，缩短问题：
    在此感谢评论区的朋友提供的[解决方案](https://link.jianshu.com?t=http%3A%2F%2Fblog.csdn.net%2Fz3512498%2Farticle%2Fdetails%2F51245853)。在`~/.oh-my-zsh/themes`路径下找到`agnoster.zsh-theme`文件，可使用文本工具打开，将里面的`build_prompt`下的`prompt_context`字段在前面加`#`注释掉即可。
8. 背景图:
    有朋友喜欢我那个终端的背景图，这里放出来给喜欢的朋友使用。[http://wx1.sinaimg.cn/large/81f8a509gy1fnjdvkkwgoj20zk0m8ak8.jpg](https://link.jianshu.com?t=http%3A%2F%2Fwx1.sinaimg.cn%2Flarge%2F81f8a509gy1fnjdvkkwgoj20zk0m8ak8.jpg)


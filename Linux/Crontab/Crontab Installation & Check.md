## Crontab Installation & Check

> * Linux安装(yum):
> 1. 清理yum缓存：`yum clean all`
>
> 2. 更新yum最新版本：`yum update `
>
> 3. 安装cron服务和crontab工具：`yum install -y cronie crontabs` (-y 是yes,安装中不用反复确认 )
>
> 成功返回:
>
> ```bash
> [root@ODCDITCBS01 ~]# yum install -y cronie crontabs
> Loaded plugins: fastestmirror
> Loading mirror speeds from cached hostfile
>     * base: ap.stykers.moe
>     * extras: ap.stykers.moe
>     * updates: ap.stykers.moe
> Package cronie-1.4.11-20.el7_6.x86_64 already installed and latest version
> Package crontabs-1.11-6.20121102git.el7.noarch already installed and latest version
> Nothing to do
> ```
>
---

> * 验证Crond服务和crontab工具 (centos)
>
> 1. 检查crond服务安装及启动：
>
>    `yum list cronie && systemctl status crond`
>
> 成功返回：
>
> ```bash
> [affincbs@ODCDITCBS01 ~]$ yum list cronie && systemctl status crond
> Loaded plugins: fastestmirror
> Determining fastest mirrors
>      * base: ap.stykers.moe
>      * extras: ap.stykers.moe
>      * updates: ap.stykers.moe
> Installed Packages
> cronie.x86_64                                                          1.4.11-20.el7_6                                                          @updates
> ● crond.service - Command Scheduler
>  Loaded: loaded (/usr/lib/systemd/system/crond.service; enabled; vendor preset: enabled)
>  Active: active (running) since Wed 2019-04-24 15:52:47 CST; 18h ago
> Main PID: 16138 (crond)
>  CGroup: /system.slice/crond.service
>          └─16138 /usr/sbin/crond -n
> ```
>
> 
>
> 2. 检查crontab工具是否安装：
>
>   `yum list crontabs && which crontab && crontab -l `
>
> 成功返回：
>
> ```bash
> [affincbs@ODCDITCBS01 ~]$ yum list crontabs && which crontab && crontab -l
> Loaded plugins: fastestmirror
> Loading mirror speeds from cached hostfile
>       * base: ap.stykers.moe
>       * extras: ap.stykers.moe
>       * updates: ap.stykers.moe
> Installed Packages
> crontabs.noarch                                                     1.11-6.20121102git.el7                                                     @anaconda
> /usr/bin/crontab
> no crontab for affincbs
> ```




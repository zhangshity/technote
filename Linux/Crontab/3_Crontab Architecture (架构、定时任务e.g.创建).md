# 3_Crontab Architecture (架构及简单定时任务e.g.创建)

Author : Chunyang .Zhang

---
> ##### Crond守护进程会周期性的定时读取Crontab文件 (通过Crontab解析工具)，并执行其命令(shell python java等)，从而实现定时任务功能。
> 
> * 文件架构图
> ![Crontab Architecture](https://github.com/zhangshity/technote/blob/master/Resources/crontab_architecture.jpg)

---


> * Crontab文件命令初步解释(详细解释会在**4_Crontab** 文件格式说明)
>
> | 分 时 日 月 周 |
> | -------------- |
> | my Command     |

---
###简单的Crontab定时任务创建过程 ：
1. 编辑crontab表单

   `crontab -e`

   vim 编辑 **crontab文件** 内容 ：`* * * * * my command`  ,并保存

2. 查看crontab表单

   `crontab -l`

   成功返回：

   ```bash
   [affincbs@ODCDITCBS01 ~]$ crontab -l
   * * * * * my command
   ```
   
3. 重启crond守护进程

   ```bash
   systemctl restart crond
   ```

4. 查看crond守护进程状态

   ```bash
   systemctl status crond
   ```

   成功返回active (running)状态

   ```bash
   [root@ODCDITCBS01 ~]# systemctl status crond
   ● crond.service - Command Scheduler
      Loaded: loaded (/usr/lib/systemd/system/crond.service; enabled; vendor preset: enabled)
      Active: active (running) since Thu 2019-04-25 14:31:55 CST; 1min 31s ago
    Main PID: 17939 (crond)
      CGroup: /system.slice/crond.service
              └─17939 /usr/sbin/crond -n
   
   Apr 25 14:31:55 ODCDITCBS01 systemd[1]: Started Command Scheduler.
   Apr 25 14:31:55 ODCDITCBS01 crond[17939]: (CRON) INFO (RANDOM_DELAY will be scaled with factor 96% if used.)
   Apr 25 14:31:55 ODCDITCBS01 systemd[1]: Starting Command Scheduler...
   Apr 25 14:31:55 ODCDITCBS01 crond[17939]: (CRON) INFO (running with inotify support)
   Apr 25 14:31:55 ODCDITCBS01 crond[17939]: (CRON) INFO (@reboot jobs will be run at computer's startup.)
   ```

5. 成功后 **crond** 守护进程会根据 **crontab文件** 配置来执行任务。(当然例子中的my command 是无效命令，故不会产生直观效果，具体可视化的例子会在 **5_Crontab e.g. 简单例子** 中展现)
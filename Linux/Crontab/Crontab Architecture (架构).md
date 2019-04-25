# Crontab Architecture (架构)

​                                                                                                                                          Chunyang . Zhang

---

![Crontab Architecture](https://github.com/zhangshity/technote/blob/master/Resources/crontab_architecture.jpg)
* 按照格式编写定时任务：

| 分 时 日 月 周 |
| -------------- |
| my Command     |

1. 编辑crontab表单

   `crontab -e`

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

   

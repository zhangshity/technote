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

   成功返回

   ```bash
   [affincbs@ODCDITCBS01 ~]$ crontab -l
   * * * * * my command
   You have new mail in /var/spool/mail/affincbs
   ```

   
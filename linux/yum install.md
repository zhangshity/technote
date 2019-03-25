### 查看yum是否安装

*         `rpm -qa |grep yum`

### 安装
*         `rpm -ivh yum-* --nodeps --force`

```
rpm -ivh yum-3.4.3-154.el7.noarch yum-metadata-parser-1.1.4-10.el7.x86_64 yum-langpacks-0.4.2-7.el7.noarch yum-rhn-plugin-2.0.1-9.el7.noarch yum-utils-1.1.31-42.el7.noarch --nodeps --force
```
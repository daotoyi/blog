---
title: "Linux systecm service manager"
author: ["SHI WENHUA"]
date: "2023-09-24 20:18:00"
lastmod: "2024-04-27 09:59:41"
categories: ["Linux"]
draft: false
---

## init/systemd {#init-systemd}

<https://img-blog.csdn.net/20180825000445679?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM4MjI4ODMw/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)>


## service manage {#service-manage}


### 适用 service/chkconfig {#适用-service-chkconfig}

-   redhat/centos6 及以下版本

<!--listend-->

```bash
chkconfig  设置是当前不生效，linux重启后才生效
service    设置是即时生效，linux关机重启后设置失效

#  查看
service --status-all
chkconfig --list

ps -aux ｜ grep xxx
service vsftpd status
chkconfig vsftpd status

# 启动
chkconfig –level 345 vsftpd off/on
chkconfig –add xxx
chkconfig –del xxx
# ( 注意：服务脚本必须存放在 /etc/init.d/目录下)
# 例如： chkconfig  httpd on     # 级别3运行
```

-   **chkconfig 开机时**
    -   根据/etc/rc.d/rc3.d/下的文件名来启动服务，比如发现有 s01httpd 文件，它就调用 service httpd start 来启动服务. 关键是文件名前面的 S ，它代表启动的意思，如果将文件名前 S 改成 K，那么这个服务开机时是不会启动的。


## systemd {#systemd}

-   适用 redhat/centos7 及以上版本

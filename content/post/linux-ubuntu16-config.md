---
title: "Linux Ubuntu16.04LTS"
date: "2023-12-29 08:35:00"
lastmod: "2023-12-29 08:36:41"
categories: ["Linux"]
draft: false
---

```bash
# ENV
Ubuntu 16.04.6 LTS
uname: 4.15.0-45-generic

# ISO安装后默认apt源可用
apt update
# 安装sshd
apt install openssh-server
# root可远程，配置/etc/ssh/sshd_config
PermitRootLogin yes

# install xfce desktop (必须安装xubuntu-desktop启动才会显示桌面选择)
apt install xubuntu-desktop

apt install screen
# screenfetch # 显示Unity桌面
# 右上角桌面环境显示xbuntu

apt install xfce4
apt install lightdm
# 右上角桌面环境显示xfe

# compile
apt install gcc cmake make  # git
```

-   FAQ

    ```bash
    # /var/lib/apt/lists/lock - open(11:资源暂不可用)
    rm /var/lib/apt/lists/lock
    ```
---
title: "Linux 远程桌面(win)"
date: "2022-08-05 21:04:00"
lastmod: "2022-08-07 09:28:21"
categories: ["Linux"]
draft: false
---

## VNC | vncserver/vncviewer {#vnc-vncserver-vncviewer}

-   vncserver
    -   linux / raspbian
    -   realvnc、tightvnc、x11vnc
-   vncviewer
    -   PC
    -   realvnc、tightvnc、ultravnc、tigervnc

> tightvnc viewer：<https://www.tightvnc.com/download.php>
> ultravnc viewer：<http://www.uvnc.com/downloads.html>
> tigervnc viewer：<https://bintray.com/tigervnc/beta/tigervnc>


### Ref {#ref}

-


## Xdmcp | xming(free)/xmanager/Mobaxterm(Xdmcp) {#xdmcp-xming--free--xmanager-mobaxterm--xdmcp}

-   X Display Manager Control Protocol
-   X 显示管理器控制协议.


### server | linux {#server-linux}

-   “系统”-“首选项”-“远程桌面”
    -   在“允许其它人查看您的远程桌面”前打勾；
    -   在“允许其它用户控制您的桌面”打勾
-   在/etc/gdm/custom.conf 配置文件中的[xdmcp]下，添加 Enable=1(或 true). Port=177(默认）

    ```cfg
    # GDM configuration storage

    [daemon]

    [security]

    [xdmcp]
    Enable=true
    Port=177
    [greeter]

    [chooser]

    [debug]
    ```
-   重启 RedHat 系统即可

查看 177 端口是否启用：netstat -tulnp # ss -tulnp


### client | windows {#client-windows}

-   xmanager
-   XDMCP 会话


## XRDP/RDP {#xrdp-rdp}

-   RDP
    -   windows 远程桌面服务
    -   Remote Desktop Protocol
-   XRDP
    -   Linux 上类似的 RDP 服务
    -   Xrdp 是一个开源工具，允许用户通过 Windows RDP 访问 Linux 远程桌面。
    -   除了 Windows RDP 之外，xrdp 工具还接受来自其他 RDP 客户端的连接
    -   Xrdp 现在支持 TLS 安全层
-   Xrdp 要求
    -   xrdp 和 xorgxrdp 包
    -   监听 3389/tcp. 确保防火墙接受连接


### server | linux {#server-linux}

-   Ubuntu

<!--listend-->

```bash
apt install xrdp
sudo systemctl restart xrdp
systemctl enable xrdp

ufw enable
ufw allow 3389/tcp
```

-   Redhat7

<!--listend-->

```bash
rpm -Uvh https://dl.Fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum update && yum -y install xrdp tigervnc-server

firewall-cmd --permanent --zone=public --add-port=3389/tcp
firewall-cmd --reload

systemctl enable xrdp && systemctl restart xrdp
```


### client | windows {#client-windows}

`Win + r -> mstsc` 打开远程桌面连接,输入账号密码。


### Ref {#ref}

-   [Xrdp - 通过Windows的RDP连接Linux远程桌面（Ubuntu/CentOS/Redhat 7）](https://www.linuxidc.com/Linux/2018-10/155073.htm)


## SSH+X11 forwarding| Mobaxterm {#ssh-plus-x11-forwarding-mobaxterm}


### server {#server}

-   SSH 能正常访问即可.
-   **开启 X11Forwarding**

    ```bash
    # /etc/ssh/sshd_config
    X11Forwarding yes

    # X11UseLocalhost no
    # 网上说法X11UseLocalhost no也要设置，但设置后无法登录

    service sshd restart
    # or
    systemctl sshd restart
    ```


### client {#client}

-   Mobaxterm
    -   SSH
    -   将 Remote environment 由 `Interactive shell` 修改为 `LXDE desktop` (根据实际桌面环境修改）。
-   Putty
    -   会话设置的 `Connection–SSH–X11` 下启用 `X11 forwarding`
    -   会话设置的 Connection–SSH–X11 下启用 X11 forwarding


## MobaXterm {#mobaxterm}

-   内建 X server，可远程运行 X 窗口程序
-   内建 SFTP 文件传输
-   直接支持 VNC/RDP/Xdmcp 等远程桌面
-   支持 mosh 协议，在弱网环境下取代 SSH
-   内建多标签和多终端分屏
-   内建 FTP、HTTP 等诸多服务器，一键开启
-   免费版可满足大部分使用需求
-   非常多的额外功能，支持插件

使用示例：
![](http://ww4.sinaimg.cn/large/90fd3da6gw1f89dqjg4oyj20qk0ez7ac.jpg)


## Ref {#ref}

-   [Linux远程桌面服务VNC/XRDP/Xdmcp/SSH+X11](https://blog.csdn.net/zbgjhy88/article/details/81009222)
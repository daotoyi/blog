---
title: "SSH 端口转发实现穿透内网"
date: "2022-05-02 10:41:00"
lastmod: "2022-09-25 16:24:53"
tags: ["SSH", "NAT-DDNS"]
categories: ["VPS"]
draft: false
toc: true
---

## connect {#connect}

假设有本地内网服务器 A，外网服务 B（固定 IP）。为了进行端口转发，需要从 A ssh 连到 B（建立隧道）并监听端口。达到该目的的命令是：

> ssh -R 外网监听端口:本地服务器:本地端口 username@host

例如要将 B 上的 8081 端口请求转发到 A，则在 A 上运行命令：

```bash
ssh -R 8081:localhost:8080 username@hostB
```

该命令会建立一个 A 到 B 的连接，并在 B 上监听 8081 端口，将该端口收到的请求转发到 A 的 8080 端口。在连接到的 B 的终端上输入： `netstat -nltp| grep sshd` 或者 `ss -lntp | grep sshd` ，可以看到 sshd 进程已经在监听 8081 端口。


## gateway {#gateway}

启用端口转发，编辑 /etc/ssh/sshd_config 文件，找到 GatewayPorts 选项，配置为： GatewayPorts yes

```bash
sed -i "s/#GatewayPorts no/GatewayPorts yes/g" /etc/ssh/sshd_config
systemctl restart ssh
```


## user access {#user-access}

离正式使用还差一步：B的 8081 端口只监听了本地(127.0.0.1 或者::1)，意味着其他用户不同通过 “<http://b:8081>” 访问 A 上的内容。这是因为 ssh 默认不允许远程主机进行端口转发。为了启用端口转发，编辑 /etc/ssh/sshd_config 文件，找到 GatewayPorts 选项，配置为：

```cfg
GatewayPorts yes
```

重启 sshd 服务并重新连接到 B，打开浏览器，输入”<http://b:8081″，访问到的内容和> “<http://a:8080>” 将会一致。

如果只是进行端口转发，就没必要登录到 B 上并打开终端。ssh 命令的-R 参数可以配合-f 和-N 一起使用，达到静默连接和转发的效果。运行命令：

```bash
ssh -fNR 8081:localhost:8080 user@hostB
# ssh -lroot -p22 -qngfNTR 8822:localhost:22 121.41.218.68 -o ServerAliveInterval=10
```

-   -f 参数表示后台执行
-   -N 表示不执行远程命令。
-   ServerAliveInterval=10: 客户端每 10s 发送一个心跳保持隧道的链接，否则这条连接很容易被重置。

该命令只建立连接，不分配终端，进程后台执行，连接成功后终端控制权马上交给用户。


## ip {#ip}

解决了内网穿透问题，接下来是浮动 ip 问题。浮动 ip 会导致建立的 ssh 连接断开，转发就失效了。为了让转发长时间有效，保证服务的可用性，可以定时检测 ssh 连接，断线自动重连。以下是断线重连的脚本：

```bash
#!/usr/bin/bash

while true
    do
        RET=`ps ax | grep "ssh" | grep -v grep`
        if [ "$RET" = "" ]; then
            echo "the recent ssh disconnect at `date`" >> ~/check.log
            echo "restart ssh connect"
            ssh -fNR 8081:localhost:8080 user@host
        else
            echo "ssh connect at `date`"
            break;
        fi
    done
```

为了自动重连，你需要先配置 ssh 免密登录。然后配置 crontab 定期执行脚本： \*/2 \* \* \* \* 脚本路径。如此一来内网穿透和浮动 ip 的问题就都解决了。


## Ref {#ref}

-   [SSH端口转发实现穿透内网](https://ssrvps.org/archives/3383)
-   [三条命令助你快速实现 SSH 内网穿透](https://mp.weixin.qq.com/s/_7EXB1b5UTR8WsyePVOQMw)
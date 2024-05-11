---
title: "Linux Proxy"
author: ["SHI WENHUA"]
date: "2022-04-10 16:43:00"
lastmod: "2024-04-22 19:32:18"
categories: ["Linux"]
draft: false
---

Linux 图形化下设置本地代理与 Windows 类似，原理都是监听本地（127.0.0.1）的指定端口。也可以直接修改配置文件，这在无图形界面下很有用。写入后重新加载该配置文件即可 source /etc/profile。


## local proxy {#local-proxy}

export http_proxy=<http://127.0.0.1:port>


## config {#config}

```cfg
no_proxy=localhost,127.0.0.0/8,*.local # 访问指定地址时不使用代理，可以用逗号分隔多个地址
NO_PROXY=localhost,127.0.0.0/8,*.local
all_proxy=socks://proxy.example.com:8080/
ALL_PROXY=socks://proxy.example.com:8080/
http_proxy=http://proxy.example.com:8080
HTTP_PROXY=http://proxy.example.com:8080
ftp_proxy=http://proxy.example.com:8080
FTP_PROXY=http://proxy.example.com:8080
https_proxy=http://proxy.example.com:8080
HTTPS_PROXY=http://proxy.example.com:8080
```

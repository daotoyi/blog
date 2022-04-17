+++
title = "Linux Proxy"
date = 2022-04-10T16:43:00+08:00
lastmod = 2022-04-10T16:43:08+08:00
categories = ["Linux"]
draft = false
+++

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
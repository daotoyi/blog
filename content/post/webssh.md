---
title: "WebSSH - 网页上的 SSH 终端"
date: "2022-07-10 12:20:00"
lastmod: "2022-07-10 13:09:15"
tags: ["WebSSH"]
categories: ["VPS"]
draft: false
toc: true
---

## 安装使用 {#安装使用}

WebSSH 要求 Python2.7 或 3.4+。

```bash
pip install webssh
wssh
docker-compose up
```


## 登录参数 {#登录参数}

WebSSH 支持使用 URL 参数进行登录，和进行命令行窗口的外观设置：

```bash

# 传递主机、端口、用户名和 base64 编码的密码进行登
http://localhost:8888/?hostname=xx&username=yy&password=str_base64_encoded

# 设置命令行背景颜色
http://localhost:8888/#bgcolor=green

# 设置命令行标题
http://localhost:8888/?title=my-ssh-server

# 设置命令行字符编码
http://localhost:8888/#encoding=gbk

# 设置登录后马上执行的命令
http://localhost:8888/?command=pwd

# 设置命令行类型
http://localhost:8888/?term=xterm-256color
```


## 内网穿透登录 {#内网穿透登录}

不用 vpn 通过 v2ray 搭建的内网穿透通道即可通过网面端 SSH(WebSSH)登录内网主机.

-   内网主机搭建 v2ray 的 bridge 端, 并安装 webssh 并启动

<!--listend-->

```cfg
"reverse": {
      "bridges": [
        {
          "tag": "bridge",
          "domain": "tunnel.daotoyi.cn"
        }
      ]
}
```

-   vps 服务器搭建 v2ray 的 portal 端

    ```cfg
    "reverse": {
         "portals": [
         {
            "tag": "portal",
                 "domain": "tunnel.daotoyi.cn"
         }]
    }
    "routing": {
         "domainStrategy": "IPIfNonMatch",
         "rules": [
             {
                 "type":"field",
                 "inboundTag":[ "mix-proxy-reverse" ],
                 "domain":[ "full:tunnel.daotoyi.cn" ],
                 "outboundTag":"portal"
             },
             {
                 "type": "field",
                 "inboundTag": [
                   "mix-proxy-reverse",
                   "inbound_trojan",
                   "inbound_vlessws",
                   "inbound_vmesstcp",
                   "inbound_vmessws"
                 ],
                 "ip": [ "172.16.254.115" ],
                 "outboundTag": "portal"
             }
         ]
     }
    ```
-   操作主机搭建 v2ray 客户端, 配置要连接内网 ip 走 proxy 模式

    ```cfg
    "rules": [
              {
                  "inboundTag": [
                      "QV2RAY_API_INBOUND"
                  ],
                  "outboundTag": "QV2RAY_API",
                  "type": "field"
              },
              {
                  "ip": [
                      "172.16.254.115/24"
                  ],
                  "outboundTag": "PROXY",
                  "type": "field"
              }]
    ```

即可在操作主机的浏览器页面直接远程登录内网主机(<http://172.16.254.115:8888>)[内网主机 IP:PORT].

**操作机浏览器通过内网的 ip(如 172.16.254.115)进行内网穿透连接,所以要将 WebSSH 安装在内网机上**


## Ref {#ref}

-   [WebSSH](https://github.com/huashengdun/webssh)
-   [WebSSH - 网页上的SSH终端](https://www.jianshu.com/p/af2a765c4c4c)
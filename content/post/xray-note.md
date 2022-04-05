+++
title = "Xray 笔记"
lastmod = 2022-04-04T15:06:10+08:00
categories = ["VPS"]
draft = true
+++

## install {#install}


### system {#system}

```bash
bash <(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh) install
```


### docker {#docker}

```bash
docker pull teddysun/xray
mkdir -p /etc/xray

mkdir -p /etc/xray/ssl
yum install -y nginx
```


## config {#config}

`/etc/xray/config.json`

```js
{
    "log": {
        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "f9950445-a796-454d-a2c7-9745dc2eb9e3",
                        "flow": "xtls-rprx-direct",
                        "level": 0
                    }
                ],
                "decryption": "none",
                "fallbacks": [
                    {
                        "dest": "127.0.0.1:80"
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "xtls",
                "xtlsSettings": {
                    "alpn": [
                        "http/1.1"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/etc/xray/ssl/chain.crt",
                            "keyFile": "/etc/xray/ssl/key.key"
                        }
                    ]
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
```


## fullback {#fullback}

**Fallback 是 Xray 的最强大功能之一, 可有效防止主动探测, 自由配置常用端口多服务共享**

fallback 为 Xray 提供了高强度的防主动探测性, 并且具有独创的首包回落机制.

fallback 也可以将不同类型的流量根据 path 进行分流, 从而实现一个端口, 多种服务共享.


### fallback [parameter](https://xtls.github.io/config/features/fallback.html) {#fallback-parameter}

引入了分流和回落的概念.

VLESS 协议 中的 fallback 是可选的，只能用于 TLS 或 XTLS 模式下;

```js
{
    "name": "",
    "alpn": "",
    "path": "",
    "dest": "",
    "xver": ""
}
```

-   dest: 必须的
-   alpn: 可选,一般不用管（或者填["http/1.1"]）
-   path: 是回落路径
-   xver 用来指示是否传递真实 ip 信息（需要填 1，不需要填 0）。

****该项有子元素时，Inbound TLS 需设置 "alpn":["http/1.1"]。****

通常，你需要先设置一组 alpn 和 path 均省略或为空的默认回落，然后再按需配置其它分流。如果有多组转发，则可按照 path 路径配置多组 fallback 对象:

```js
"fallbacks": [
    {
        "dest": 80 // 或者回落到其它也防探测的代理
    },
    {
        "path": "/websocket", // 必须换成自定义的 PATH
        "dest": 1234,
        "xver": 1
    },
    {
        "path": "/vmesstcp", // 必须换成自定义的 PATH
        "dest": 2345,
        "xver": 1
    },
    {
        "path": "/vmessws", // 必须换成自定义的 PATH
        "dest": 3456,
        "xver": 1
    }
]
```

-   客户端:
    -   请求 域名:/websocket 时，流量将转发到本机的 1234 端口；
    -   请求 域名:/vmesstcp 时，流量转发到本机的 2345 端口；
    -   请求路径为 /vmessws 时转发到 3456 端口；
    -   如果是其他请求，则转到到 80 端口。


## startup {#startup}

```bash
docker run -d -p 443:443 --name xray --restart=always -v /etc/xray:/etc/xray teddysun/xray
docker run -d -p 8888:8888 --name xray --restart=always -v /etc/xray:/etc/xray teddysun/xray
docker run -d -p 8888:8888 --name xray -v /etc/xray:/etc/xray teddysun/xray  xray -config=/etc/xray/config.json
```
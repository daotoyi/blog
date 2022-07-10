---
title: "Xray 笔记"
date: "2022-04-10 22:15:00"
lastmod: "2022-07-10 12:56:29"
tags: ["Xray"]
categories: ["VPS"]
draft: false
toc: true
---

## install {#install}


### system {#system}

[github/XTLS](https://github.com/XTLS/Xray-install)

Install &amp; Upgrade Xray-core and geodata with User=nobody, but will NOT overwrite User in existing service files

```bash
bash <(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh) install
```

Update geoip.dat and geosite.dat only

```bash
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install-geodata
```

Remove Xray, except json and logs

```bash

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
-   path: 是回落路径
-   xver 用来指示是否传递真实 ip 信息（需要填 1，不需要填 0）。
-   alpn: 可选,一般不用管（或者填["http/1.1"]）

-   ****该项有子元素时，Inbound TLS 需设置 "alpn":["http/1.1"]。****

通常，你需要先设置一组 alpn 和 path 均省略或为空的默认回落，然后再按需配置其它分流。如果有多组转发，则可按照 path 路径配置多组 fallback 对象:


#### alpn {#alpn}

-   用途：解决了 Nginx 的 h2c 服务不能同时兼容 http/1.1 的问题.
-   Nginx 需要写两行 listen，分别用于 1.1 和 h2c。
-   注意：fallbacks alpn 存在 "h2" 时，Inbound TLS 需设置 "alpn":["h2","http/1.1"]，以支持 h2 访问。

**NOTE** : Fallback 内设置的 alpn 是匹配实际协商出的 ALPN，而 Inbound TLS 设置的 alpn 是握手时可选的 ALPN 列表，两者含义不同


#### path {#path}

尝试匹配首包 HTTP PATH，空为任意，默认为空，非空则必须以 / 开头，不支持 h2c。

注意：fallbacks 所在入站本身必须是 TCP+TLS，这是分流至其它 WS 入站用的，被分流的入站则无需配置 TLS。


#### dest {#dest}

决定 TLS 解密后 TCP 流量的去向，目前支持两类地址：

-   TCP，格式为 "addr:port"
    -   其中 addr 支持 IPv4、域名、IPv6，若填写域名，也将直接发起 TCP 连接（而不走内置的 DNS）。
    -   若只填 port，数字或字符串均可，形如 80、"80"，通常指向一个明文 http 服务（addr 会被补为 "127.0.0.1"）
-   Unix domain socket，格式为绝对路径
    -   形如 "/dev/shm/domain.socket"，可在开头加 @ 代表 abstract，@@ 则代表带 padding 的 abstract。


#### xver {#xver}

专用于传递请求的真实来源 IP 和端口，填版本 1 或 2

-   默认为 0，即不发送。
-   若有需要建议填 1。
-   填 1 或 2，功能完全相同，只是结构不同，且前者可打印，后者为二进制。


#### conf {#conf}

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


## transparent proxy {#transparent-proxy}

透明代理简单地说就是不让被代理的设备感觉到自己被代理了。简单地说就是，被代理的设备上不需要运行任何代理软件(比如 Xray、V2RayNG 等)，当你连接上网络时，你的设备已经被代理了。

这也意味着，代理的软件运行在别的地方，比如运行在路由器中，通过路由器上网的设备就自动被代理了。


## Ref {#ref}

-   [Project X](https://xtls.github.io/Xray-docs-next/en/config/%E9%85%8D%E7%BD%AE%E6%8C%87%E5%8D%97)
-   [配置指南](https://xtls.github.io/Xray-docs-next/en/config/)
-   [配置指南-多文件配置](https://xtls.github.io/xray-docs-next/en/config/features/multiple.html#%e6%8e%a8%e8%8d%90%e7%9a%84%e5%a4%9a%e6%96%87%e4%bb%b6%e5%88%97%e8%a1%a8)
-   [使用指南-回落 (fallbacks) 功能简析](https://xtls.github.io/Xray-docs-next/document/level-1/fallbacks-lv1.html)
-   [路由 (routing) 功能简析](https://xtls.github.io/Xray-docs-next/document/level-1/routing-lv1-part1.html)
-   [使用指南-SNI回落](https://xtls.github.io/Xray-docs-next/document/level-1/fallbacks-with-sni.html)
-   [使用指南-透明代理](https://xtls.github.io/Xray-docs-next/document/level-2/transparent_proxy/transparent_proxy.html#%E4%BB%80%E4%B9%88%E6%98%AF%E9%80%8F%E6%98%8E%E4%BB%A3%E7%90%86)
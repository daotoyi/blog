+++
title = "Xray+XTLS+VLESS 终极配置"
description = "VLESS over TCP with XTLS + fullbacks(回落&分流) to WHATEVER"
lastmod = 2022-04-04T23:11:22+08:00
tags = ["Xray"]
categories = ["VPS"]
draft = false
+++

## [config](https://github.com/XTLS/Xray-examples/blob/main/VLESS-TCP-XTLS-WHATEVER/README.md) {#config}

-   VLESS over TCP with XTLS，数倍性能，首选方式
-   VLESS over TCP with TLS
-   VLESS over WS with TLS
-   VMess over TCP with TLS，不推荐
-   VMess over WS with TLS
-   Trojan over TCP with TLS


## config note {#config-note}

```js
// REFERENCE:
// https://github.com/XTLS/Xray-examples
// https://xtls.github.io/config/

// 常用的config文件，不论服务器端还是客户端，都有5个部分。外加小小白解读：
// ┌─ 1_log          日志设置 - 日志写什么，写哪里（出错时有据可查）
// ├─ 2_dns          DNS-设置 - DNS怎么查（防DNS污染、防偷窥、避免国内外站匹配到国外服务器等）
// ├─ 3_routing      分流设置 - 流量怎么分类处理（是否过滤广告、是否国内外分流）
// ├─ 4_inbounds     入站设置 - 什么流量可以流入Xray
// └─ 5_outbounds    出站设置 - 流出Xray的流量往哪里去


{
    // 1_日志设置
    "log": {
        "loglevel": "warning",    // 内容从少到多: "none", "error", "warning", "info", "debug"
        "access": "/home/vpsadmin/xray_log/access.log",    // 访问记录
        "error": "/home/vpsadmin/xray_log/error.log"    // 错误记录
    },

    // 2_DNS设置
    "dns": {
        "servers": [
            "https+local://1.1.1.1/dns-query",    // 首选1.1.1.1的DoH查询，牺牲速度但可防止ISP偷窥
            "localhost"
        ]
    },

    // 3_分流设置
    "routing": {
        "domainStrategy": "AsIs",
        "rules": [
            // 3.1 防止服务器本地流转问题：如内网被攻击或滥用、错误的本地回环等
            {
                "type": "field",
                "ip": [
                    "geoip:private"    // 分流条件：geoip文件内，名为"private"的规则（本地）
                ],
                "outboundTag": "block"    // 分流策略：交给出站"block"处理（黑洞屏蔽）
            },
            // 3.2 屏蔽广告
            {
                "type": "field",
                "domain": [
                    "geosite:category-ads-all"    // 分流条件：geosite文件内，名为"category-ads-all"的规则（各种广告域名）
                ],
                "outboundTag": "block"    // 分流策略：交给出站"block"处理（黑洞屏蔽）
            }
        ]
    },

    // 4_入站设置
    // 4.1 这里只写了一个最简单的vless+xtls的入站，因为这是Xray最强大的模式。如有其他需要，请根据模版自行添加。
    "inbounds": [
        {
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "", // 填写你的 UUID
                        "flow": "xtls-rprx-direct",
                        "level": 0,
                        "email": "vpsadmin@yourdomain.com"
                    }
                ],
                "decryption": "none",
                "fallbacks": [
                    {
                        "dest": 80 // 默认回落到防探测的代理
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "security": "xtls",
                "xtlsSettings": {
                    "allowInsecure": false,    // 正常使用应确保关闭
                    "minVersion": "1.2",       // TLS最低版本设置
                    "alpn": [
                        "http/1.1"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/home/vpsadmin/xray_cert/xray.crt",
                            "keyFile": "/home/vpsadmin/xray_cert/xray.key"
                        }
                    ]
                }
            }
        }
    ],

    // 5_出站设置
    "outbounds": [
        // 5.1 第一个出站是默认规则，freedom就是对外直连（vps已经是外网，所以直连）
        {
            "tag": "direct",
            "protocol": "freedom"
        },
        // 5.2 屏蔽规则，blackhole协议就是把流量导入到黑洞里（屏蔽）
        {
            "tag": "block",
            "protocol": "blackhole"
        }
    ]
}
```


## why not VLESS+XTLS+WS? {#why-not-vless-plus-xtls-plus-ws}

如果服务端配置了 VLESS+XTLS+WS，V2ray 将无法正常启动。通过 journalctl -xen -u v2ray --no-pager 查看日志，会发现如下错误信息：

> XTLS only supports TCP, mKCP and DomainSocket for now

这是因为 WS 协议需要 **首先建立 HTTP 请求，然后才升级为 WS 连接** 。如果第一次请求就使用 XTLS 加密，CDN 或者 Nginx 等中间件无法识别该加密协议，将直接作为无效请求处理。
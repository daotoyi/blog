---
title: "v2ray 笔记"
date: "2022-03-05 17:20:00"
lastmod: "2022-04-30 12:50:19"
tags: ["v2ray"]
categories: ["VPS"]
draft: false
---

## introduction {#introduction}

-   [V2Ray 用户手册](https://www.v2ray.com/)
-   [v2ray简易手册](https://selierlin.github.io/v2ray/)
-   [V2Ray 项目地址](https://github.com/v2ray/v2ray-core)


## TLS/XTLS {#tls-xtls}


### TLS {#tls}

(Transport Layer Security)

译作: **传输层安全性协议** ([wikipedia:传输层安全性协议](https://wuu.wikipedia.org/wiki/%E4%BC%A0%E8%BE%93%E5%B1%82%E5%AE%89%E5%85%A8%E6%80%A7%E5%8D%8F%E8%AE%AE))

前身 \*安全套接层\*（Secure Sockets Layer，缩写：SSL）.


### XTLS {#xtls}

XTLS 官方库 的介绍仅有一句话：THE FUTURE。

-   **XTLS 的原理：**

    使用 TLS 代理时，https 数据其实经过了两层 TLS：外层是代理的 TLS，内层是 https 的 TLS。XTLS 无缝拼接了内外两条货真价实的 TLS，使得代理几乎无需再对 https 流量进行数据加解密，只起到流量中转的作用，极大的提高了性能。
-   [V2ray 的 VLESS 协议介绍和使用教程](https://vpsgongyi.com/p/2422/)


## WebSocket {#websocket}

-   HTTP 协议有一个缺陷：通信只能由客户端发起。
-   WebSocket:服务器可以主动向客户端推送信息，客户端也可以主动向服务器发送信息，属于服务器推送技术的一种.

[WebSocket教程](https://www.ruanyifeng.com/blog/2017/05/websocket.html)


## Shadowsocks {#shadowsocks}

V2Ray 集成有 Shadowsocks 模块的，用 V2Ray 配置成 Shadowsocks 服务器或者 Shadowsocks 客户端都是可以的，兼容 Shadowsocks-libev。


### v2ray VS Shadowsocks {#v2ray-vs-shadowsocks}

-   Shadowsocks 只是一个简单的代理工具，而 V2Ray 定位为一个平台，任何开发者都可以利用 V2Ray 提供的模块开发出新的代理软件。
-   V2Ray 本身只是一个内核，V2Ray 上的图形客户端大多是调用 V2Ray 内核套一个图形界面的外壳
-   V2Ray 不像 Shadowsocks 那样有统一规定的 URL 格式，所以各个 V2Ray 图形客户端的分享链接/二维码不一定通用。
-   V2Ray 对于时间有比较严格的要求，要求服务器和客户端时间差绝对值不能超过 2 分钟,还好 V2Ray 并不要求时区一致。
-   与 Shadowsocks 不同，从软件上 V2Ray 不区分服务器版和客户端版，也就是说在服务器和客户端运行的 V2Ray 是同一个软件，区别只是配置文件的不同。
-   可以用 V2Ray 配置成 Shadowsocks 服务器或者 Shadowsocks 客户端都是可以的，兼容 Shadowsocks-libev.


## Vmess/Vless {#vmess-vless}


### Vmess {#vmess}

VMess 协议是由 V2Ray 原创并使用于 V2Ray 的加密传输协议.


### Vless {#vless}


#### 简介 {#简介}

V2ray 官方对 VLESS 协议的定义是“性能至上、可扩展性空前，目标是全场景终极协议”。

VLESS 是一种无状态的轻量级数据传输协议，被定义为下一代 V2ray 数据传输协议。

VLESS 命名源自“less is more”,与 VMESS 协议相同，VLESS 使用 UUID 进行身份验证，配置分入栈和出栈两部分，可用在客户端和服务端。.


#### 总结 {#总结}

VLESS 协议本身不自带加密，用于翻墙时不能单独使用。由于 XTLS 的引入，目前 VLESS 协议有如下玩法：

-   VLESS + TCP + TLS
-   VLESS + TCP +TLS +  WS
-   VLESS + TCP + XTLS
-   VLESS + HTTP2 + h2c


### Vless 与 VMESS 区别 {#vless-与-vmess-区别}

-   VLESS 协议 **不依赖于系统时间，不使用 alterId** 。
-   VLESS 协议不带加密，用于科学上网时要配合 TLS 等加密手段；
-   VLESS 协议 **支持分流和回落** ，比 Nginx 分流转发更简洁、高效和安全；
-   使用 TLS 的情况下，VLESS 协议比 VMESS **速度更快** ，性能更好，因为 VLESS 不会对数据进行加解密；
-   V2ray 官方对 VLESS 的期望更高，约束也更严格。例如要求客户端统一使用 VLESS 标识，而不是 Vless、vless 等名称；VLESS 分享链接标准将由官方统一制定（尚未出炉）；
-   VLESS 协议的加密更灵活，不像 VMESS 一样高度耦合（仅对开发者有用）


## install {#install}

V2Ray 的安装有脚本安装、手动安装、编译安装 3 种方式.

-   脚本安装

<!--listend-->

```shell
##  DISCARDED
# wget https://install.direct/go.sh # 下载脚本
# sudo bash go.sh
# sudo systemctl start v2ray

## 安裝執行檔和 .dat 資料檔
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)

# 只更新 .dat 資料檔
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh)

# 移除 V2Ray
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh) --remove
```

配置文件路径为 `/etc/v2ray/config.json`

V2Ray 的方法是 **再次执行安装脚本** ！


## docker install {#docker-install}

-   docker install v2ray

<!--listend-->

```shell
# docker pull v2ray/official
# docker pull v2ray/official:latest

# v2ray change name v2fly
# https://hub.docker.com/r/v2fly/v2fly-core/tags
docker pull v2fly/v2fly-core
docker pull v2fly/v2fly-core:v4.33.0

mkdir /etc/v2ray
# mkdir /var/log/v2ray

docker container start v2ray //启动V2ray
docker container stop v2ray //停止V2ray
docker container restart v2ray //重启V2ray

docker run -d --name v2ray -v /etc/v2ray:/etc/v2ray -p 8888:8888 v2fly/v2fly-core  v2ray -config=/etc/v2ray/config.json
docker run -d --name v2ray -v /etc/v2ray:/etc/v2ray -p 8888:8888 v2fly/v2fly-core:v4.34.0  v2ray -config=/etc/v2ray/config.json
#https://hub.docker.com/r/v2fly/v2fly-core/tags

docker run \
       --restart=always \
       --name=v2ray \
       --net=host \
       -v /etc/v2ray/config.json:/etc/v2ray/config.json \
       -v /var/log/v2ray:/var/log/v2ray \
       -i -t -d \
       v2ray/official:latest
# 升级
docker container stop v2ray
docker container rm v2ray
docker pull v2ray/official
# docker run -it -d --name v2ray -v /etc/v2ray:/etc/v2ray -p 8888:8888 v2ray/official v2ray -config=/etc/v2ray/config.json
```


## v2ray cmd-line {#v2ray-cmd-line}

```cfg
# 进入docker内部
docker exec -it v2ray /bin/sh

v2ray info 查看 V2Ray 配置信息
v2ray config 修改 V2Ray 配置
v2ray link 生成 V2Ray 配置文件链接
v2ray infolink 生成 V2Ray 配置信息链接
v2ray qr 生成 V2Ray 配置二维码链接
v2ray ss 修改 Shadowsocks 配置
v2ray ssinfo 查看 Shadowsocks 配置信息
v2ray ssqr 生成 Shadowsocks 配置二维码链接
v2ray status 查看 V2Ray 运行状态
v2ray start 启动 V2Ray
v2ray stop 停止 V2Ray
v2ray restart 重启 V2Ray
v2ray log 查看 V2Ray 运行日志
v2ray update 更新 V2Ray
v2ray update.sh 更新 V2Ray 管理脚本
v2ray uninstall 卸载 V2Ray
```


## configure {#configure}

`/etc/v2ray/config.json`
[V2ray 基本配置方法](https://ansongd.gitbooks.io/v2ray/content/v2rayji-ben-pei-zhi.html)


### formate {#formate}

```js
{
    "log": {},
    "inbound": {},
    "outbound": {},
    "inboundDetour": [],
    "outboundDetour": [],
    "routing": {},
    "transport": {},
    "dns": {},
    "policy": {},
    "stats": {},
    "api": {},
}
```


### log {#log}

-   access：将访问的记录保存到文件中，这个选项的值是要保存到的文件的路径
-   error：将错误的记录保存到文件中，这个选项的值是要保存到的文件的路径
-   error、access 字段留空，并且在手动执行 V2Ray 时，V2Ray 会将日志输出在 stdout 即命令行中（terminal、cmd 等），便于排错


### [route](https://www.bookstack.cn/read/V2RAY/chapter_02-03_routing.md) {#route}

4 种 outbound 协议：

-   用于代理的 VMess 和 Shadowsocks 协议
-   用于直连的 freedom 协议
-   以及用于拦截的 blackhole 协议。

domainStrategy 支持

1.  "AsIs"：针对域名生效
    只使用域名进行路由选择。
    快速解析，不精确分流。默认值。

2.  "IPIfNonMatch"：针对 IP 地址生效
    当域名没有匹配任何规则时，将域名解析成 IP（A 记录或 AAAA 记录）再次进行匹配.
    -   当一个域名有多个 A 记录时，会尝试匹配所有的 A 记录，直到其中一个与某个规则匹配为止；
    -   解析后的 IP 仅在路由选择时起作用，转发的数据包中依然使用原始域名;

        理论上解析比”AsIs”稍慢，但使用中通常不会觉察到。

3.  "IPOnDemand"：针对 IP 地址生效
    当匹配时碰到任何基于 IP 的规则，将域名立即解析为 IP 进行匹配；

    解析最精确，也最慢。

如果在自定义路由设置规则时，添加了匹配 IP 的路由代理规则，比如 geoip:cn、geoip:private，或者直接添加的 IP 地址规则，须选择位于中间的”IPIfNonMatch”，不然，匹配 IP 地址的路由规则不会生效。

rules 属性有两个规则：

1.  type 支持
    -   "field（全属 ）"
    -   "chinaip（中国境内的 IP ）"
    -   "chinasites（中国境内的域名）"

2.  outboundTag 支持
    -   "direct(直连)"
    -   "blocked(组织)"
    -   对应的额外传出配置

<!--listend-->

```js
{
    "outboundDetour": [ //outboundDetour，是一个数组，可以放若干个如 outbound 格式的内容
        {
            "protocol": "freedom",
            "settings": {}
        },
        {
            "protocol": "blackhole",
            "settings": {}
        }
    ]
}
```


#### direct {#direct}

```js
{
    "outboundDetour": [
        {
            "protocol": "freedom",
            "settings": {},
            "tag": "direct" //如果要使用路由，这个 tag 是一定要有的，在这里 direct 就是 freedom 的一个标号，在路由中说 direct V2Ray 就知道是这里的 freedom 了
        }
    ],
    "routing": {
        "strategy": "rules",
        "settings": {
            "domainStrategy": "IPOnDemand",
            "rules": [
                {
                    "type": "field",
                    "outboundTag": "direct",
                    "domain": ["geosite:cn"]
                },
                {
                    "type": "chinaip",
                    "outboundTag": "direct",
                    "ip": ["geoip:cn"]
                }
            ]
        }
    }
}
```

-   "domain": ["geosite:cn"] 包含了中国大陆主流网站大部分域名
-   "ip": ["geoip:cn"]       包含了中国大陆几乎所有的 ip

`outbound 是作为默认的传出，当一个数据包没有匹配的规则时，路由就会把数据包发往 outbound`


#### adblock {#adblock}

```js
{
    "rules": [
        {
            "domain": [
                "tanx.com",
                "googeadsserving.cn",
                "baidu.com"
            ],
            "type": "field",
            "outboundTag": "adblock"
        },
        {
            "domain": [
                "amazon.com",
                "microsoft.com",
                "jd.com",
                "youku.com",
                "baidu.com"
            ],
            "type": "field",
            "outboundTag": "direct"
        },
        {
            "type": "field",
            "outboundTag": "direct"，
            "domain": ["geosite:cn"]
        },
        {
            "type": "chinaip",
            "outboundTag": "direct",
            "ip": ["geoip:cn"]
        }
    ]
}
```

-   规则是放在 routing.settings.rules 这个数组当中，数组的内容是有顺序的，也就是说在这里规则是有顺序的，匹配规则时是从上往下匹配；
-   当路由匹配到一个规则时就会跳出匹配而不会对之后的规则进行匹配；


#### BT(vps) {#bt--vps}

```js
{
    "outboundDetour": [
        {
            "protocol": "blackhole",
            "settings": {},
            "tag": "block"
        }
    ],
    "routing": {
        "strategy": "rules",
        "settings": {
            "domainStrategy": "AsIs",
            "rules": [
                {
                    "type": "field",
                    "outboundTag": "block",
                    "protocol": [
                        "bittorrent"
                    ]
                }
            ]
        }
    }
}
```

-   inbound 的 sniffing 必须开启.

    ```js
    "inbound": {
        "sniffing": {
            "enabled": true,
            "destOverride": [
                "http",
                "tls"
            ]
        }
    }
    ```


#### proxy {#proxy}


### [DNS](https://www.bookstack.cn/read/V2RAY/chapter_02-04_dns.md) {#dns}

V2Ray 内置了一个 DNS 服务器，可以将 DNS 查询根据路由设置转发到不同的远程服务器中。


### policy {#policy}

本地策略可以配置一些用户相关的权限，比如连接超时设置。V2Ray 处理的每一个连接，都对应到一个用户，按照这个用户的等级（level）应用不同的策略。


### Mux {#mux}

Mux 多路复用功能是在一条 TCP 连接上分发多个 TCP 连接的数据。


### API {#api}

V2Ray 中可以开放一些 API 以便远程调用。这些 API 都基于 gRPC。


### stats {#stats}

V2Ray 提供了一些关于其运行状况的统计信息。


### protocol {#protocol}

V2Ray

-   传入协议有
    -   HTTP
    -   SOCKS

        Socks 协议实现，兼容 Socks 4、Socks 4a 和 Socks 5。
    -   Shadowsocks

        包含传入和传出两部分，兼容大部分其它版本的实现。
    -   VMess

        加密传输协议，它分为传入和传出两部分，通常作为 V2Ray 客户端和服务器之间的桥梁。
    -   Dokodemo-door

        （任意门）是一个传入数据协议，它可以监听一个本地端口，并把所有进入此端口的数据发送至指定服务器的一个端口，从而达到端口映射的效果。

-   传出协议有
    -   VMess
    -   Shadowsocks
    -   Blackhole

        （黑洞）是一个传出数据协议，它会阻碍所有数据的传出，配合路由（Routing）一起使用，可以达到禁止访问某些网站的效果。
    -   Freedom

        Freedom 是一个传出数据协议，可以用来向任意网络发送（正常的） TCP 或 UDP 数据
    -   SOCKS

-   其他
    -   MTProto

        一个 Telegram 专用的代理协议。在 V2Ray 中可使用一组传入传出代理来完成 Telegram 数据的代理任务。 目前只支持转发到 Telegram 的 IPv4 地址。


### client {#client}

```js
{
    "inbound": {
        "port": 1080, // 监听端口
        "protocol": "socks", // 入口协议为 SOCKS 5
        "domainOverride": ["tls","http"], //从网络流量中识别出域名
        "settings": {
            "auth": "noauth"  //socks的认证设置，noauth 代表不认证，由于 socks 通常在客户端使用，所以这里不认证
        }
    },
    "outbound": {
        "protocol": "vmess", // 出口协议
        "settings": {
            "vnext": [
                {
                    "address": "serveraddr.com", // 服务器地址，请修改为你自己的服务器 IP 或域名
                    "port": 16823,  // 服务器端口
                    "users": [
                        {
                            "id": "b831381d-6324-4d53-ad4f-8cda48b30811",  // 用户 ID，必须与服务器端配置相同
                            "alterId": 64 // 此处的值也应当与服务器相同,
                        }
                    ]
                }
            ]
        }
    }
}
```


### server {#server}

```js
{
    "log": {
        "loglevel": "warning",
        "access": "/var/log/v2ray/access.log", // 这是 Linux 的路径
        "error": "/var/log/v2ray/error.log"
    },
    "inbound": {
        "port": 16823, // 服务器监听端口
        "protocol": "vmess",    // 主传入协议
        "settings": {
            "clients": [
                {
                    "id": "b831381d-6324-4d53-ad4f-8cda48b30811",  // 用户 ID，客户端与服务器必须相同
                    "alterId": 64  //加强防探测能力,理论上 alterId 越大越好，但越大就约占内存(只针对服务器，客户端不占内存) ,30 到 100 之间
                }
            ]
        }
    },
    "outbound": {
        "protocol": "freedom",  // 主传出协议
        "settings": {}
    }
}
```


## rules {#rules}


### 预定义域名列表 geosite: {#预定义域名列表-geosite}

以 geosite: 开头，后面是一个预定义域名列表名称，如 geosite:google ，意思是包含了 Google 旗下绝大部分域名；或者 geosite:cn，意思是包含了常见的大陆站点域名。

常用名称及域名列表：

```nil
category-ads：包含了常见的广告域名。
category-ads-all：包含了常见的广告域名，以及广告提供商的域名。
cn：相当于 geolocation-cn 和 tld-cn 的合集。
apple：包含了 Apple 旗下绝大部分域名。
google：包含了 Google 旗下绝大部分域名。
microsoft：包含了 Microsoft 旗下绝大部分域名。
facebook：包含了 Facebook 旗下绝大部分域名。
twitter：包含了 Twitter 旗下绝大部分域名。
telegram：包含了 Telegram 旗下绝大部分域名。
geolocation-cn：包含了常见的大陆站点域名。
geolocation-!cn：包含了常见的非大陆站点域名，同时包含了 tld-!cn。
tld-cn：包含了 CNNIC 管理的用于中国大陆的顶级域名，如以 .cn、.中国 结尾的域名。
tld-!cn：包含了非中国大陆使用的顶级域名，如以 .hk（香港）、.tw（台湾）、.jp（日本）、.sg（新加坡）、.us（美国）.ca（加拿大）等结尾的域名。
```

更多域名类别，请查看 [data目录](https://github.com/v2fly/domain-list-community/tree/master/data)


#### 域名 domain: {#域名-domain}

由 domain: 开始，后面是一个域名。例如 domain:baiyunju.cc ，匹配 www.baiyunju.cc 、baiyunju.cc，以及其他 baiyunju.cc 主域名下的子域名。

前缀 domain:可以省略，只输入域名，其实也就成了纯字符串了。


#### 完整匹配 full: {#完整匹配-full}

由 full: 开始，后面是一个域名。例如 full:baiyunju.cc 只匹配 baiyunju.cc，但不匹配 www.baiyunju.cc 。


#### 纯字符串 {#纯字符串}

比如直接输入 sina.com, 可以分行，也可以不分行以“,”隔开，可以匹配 sina.com、sina.com.cn 和 www.sina.com，但不匹配 sina.cn。


#### 正则表达式 regexp: {#正则表达式-regexp}

由 regexp: 开始，后面是一个正则表达式。例如 regexp:\\.goo.\*\\.com$ 匹配 www.google.com、fonts.googleapis.com，但不匹配 google.com。


### 从外部文件中加载域名规则 ext: {#从外部文件中加载域名规则-ext}

比如 ext:<tag，必须以> ext:（全部小写）开头，后面跟文件名（不含扩展名）file 和标签 tag，文件必须存放在 V2Ray 核心的资源目录中，文件格式与 geosite.dat 相同，且指定的标签 tag 必须在文件中存在。

说明：普通用户常用的也就是上面的“纯字符串”规则写法，比如，在代理（或直连）栏下填写 baiyunju.cc,　就可以让网站通过代理（或直连）上网。


### IP 路由规则 {#ip-路由规则}


#### geoip: {#geoip}

以 geoip:（全部小写）开头，后面跟双字符国家代码，如 geoip:cn ，意思是所有中国大陆境内的 IP 地址，geoip:us 代表美国境内的 IP 地址。


#### 特殊值： {#特殊值}

geoip:private，包含所有私有地址，如 127.0.0.1（本条规则仅支持 V2Ray 3.5 以上版本）。


#### IP： {#ip}

如 127.0.0.1，20.194.25.232


#### CIDR： {#cidr}

如 10.0.0.0/8。

从外部文件中加载 IP 规则：
如 ext:<tag，必须以> ext:（全部小写）开头，后面跟文件名（不含扩展名）file 和标签 tag，文件必须存放在 V2Ray 核心的资源目录中，文件格式与 geoip.dat 相同，且指定的 tag 必须在文件中存在。


### 路由域名规则 {#路由域名规则}


#### 预定义域名列表 {#预定义域名列表}

以 geosite: 开头，后面跟一个名称，例如 geosite:google 或 geosite:cn 名称 及 域名列表 请参考 预定义域名列表


#### 子域名 {#子域名}

由 "domain:" 开始，后面跟一个域名。当此域名是目标域名或其子域名时，该规则生效。例如 "domain:v2ray.com" 匹配 "www.v2ray.com"、"v2ray.com"，但不匹配 "xv2ray.com"。


#### 完全匹配 {#完全匹配}

由 "full:" 开始，后面跟一个域名。当此域名完整匹配目标域名时，该规则生效。例如 "full:v2ray.com" 匹配 "v2ray.com" 但不匹配 "www.v2ray.com"。


#### 纯字符串 {#纯字符串}

当此字符串匹配目标域名中任意部分，该规则生效。比如 "sina.com" 可以匹配 "sina.com"、"sina.com.cn" 和 "www.sina.com"，但不匹配 "sina.cn"。


#### 正则表达式 {#正则表达式}

由 "regexp:" 开始，余下部分是一个正则表达式。当此正则表达式匹配目标域名时，该规则生效。例如 "regexp:\\\\.goo.\*\\\\.com$" 匹配 "www.google.com"、"fonts.googleapis.com"，但不匹配 "google.com"。


#### 从文件中加载域名 {#从文件中加载域名}

形如 "ext:<tag"，必须以> ext:（小写）开头，后面跟 文件名 和 标签 ，文件存放在与 v2ray 核心相同的路径中，文件格式与 geosite.dat 相同，标签 必须在文件中声明。


## reverse/NAT-DNSS {#reverse-nat-dnss}


### 说明 {#说明}


#### 环境 {#环境}

-   主机 A：没有公网 IP，无法在公网上直接访问。
-   主机 B：它可以由公网访问。


### 配置 {#配置}


#### 内网主机 A {#内网主机-a}

```js
{
  "reverse":{
    // 这是 A 的反向代理设置，必须有下面的 bridges 对象
    "bridges":[
      {
        "tag":"bridge", // 关于 A 的反向代理标签，在路由中会用到
        "domain":"private.cloud.com" // A 和 B 反向代理通信的域名，可以自己取一个，可以不是自己购买的域名，但必须跟下面 B 中的 reverse 配置的域名一致
      }
    ]
  },
  "outbounds": [
    {
      //A连接B的outbound
      "tag":"tunnel", // A 连接 B 的 outbound 的标签，在路由中会用到
      "protocol":"vmess",
      "settings":{
        "vnext":[
          {
            "address":"serveraddr.com", // B 地址，IP 或 实际的域名
            "port":16823,
            "users":[
              {
                "id":"b831381d-6324-4d53-ad4f-8cda48b30811",
                "alterId":64
              }
            ]
          }
        ]
      }
    },
    // 另一个 outbound，最终连接私有网盘
    {
      "protocol":"freedom",
      "settings":{
      },
      "tag":"out"
    }
  ],
  "routing":{
    "rules":[
      {
        // 配置 A 主动连接 B 的路由规则
        "type":"field",
        "inboundTag":[
          "bridge"
        ],
        "domain":[
          "full:private.cloud.com"
        ],
        "outboundTag":"tunnel"
      },
      {
        // 反向连接访问私有网盘的规则
        "type":"field",
        "inboundTag":[
          "bridge"
        ],
        "outboundTag":"out"
      }
    ]
  }
}
```


#### 外网主机 B {#外网主机-b}

```js
{
  "reverse":{  //这是 B 的反向代理设置，必须有下面的 portals 对象
    "portals":[
      {
        "tag":"portal",
        "domain":"private.cloud.com"        // 必须和上面 A 设定的域名一样
      }
    ]
  },
  "inbounds": [
    {
      // 接受 C 的inbound
      "tag":"external", // 标签，路由中用到
      "port":80,
      // 开放 80 端口，用于接收外部的 HTTP 访问
      "protocol":"dokodemo-door",
        "settings":{
          "address":"127.0.0.1",
          "port":80, //假设 NAS 监听的端口为 80
          "network":"tcp"
        }
    },
    // 另一个 inbound，接受 A 主动发起的请求
    {
      "tag": "tunnel",// 标签，路由中用到
      "port":16823,
      "protocol":"vmess",
      "settings":{
        "clients":[
          {
            "id":"b831381d-6324-4d53-ad4f-8cda48b30811",
            "alterId":64
          }
        ]
      }
    }
  ],
  "routing":{
    "rules":[
      {  //路由规则，接收 C 请求后发给 A
        "type":"field",
        "inboundTag":[
          "external"
        ],
        "outboundTag":"portal"
      },
      {  //路由规则，让 B 能够识别这是 A 主动发起的反向代理连接
        "type":"field",
        "inboundTag":[
          "tunnel"
        ],
        "domain":[
          "full:private.cloud.com"
        ],
        "outboundTag":"portal"
      }
    ]
  }
}
```


### bridge / portal {#bridge-portal}

-   主机 A 中配置一个 V2Ray，称为 bridge
-   主机 B 中配置一个 V2Ray，称为 portal。
-   bridge 会向 portal 主动建立连接。
-   portal 会收到两种连接:
    -   一是由 bridge 发来的连接，
    -   二是公网用户发来的连接。
-   portal 会自动将两类连接合并,于是 bridge 就可以收到公网流量了

**一个 V2Ray 既可以作为 bridge，也可以作为 portal，也可以同时两者，以适用于不同的场景需要。**


### Ref {#ref}

-   [Reverse 反向代理](https://www.v2fly.org/config/reverse.html#reverseobject)
-   [V2Ray 白话文指南-反向代理/内网穿透](https://www.bookset.io/read/v2ray-guide/94bb3d54ac5738ed.md)
-   [使用 V2ray 反向代理实现内网穿透](https://www.bookset.io/read/v2ray-guide/94bb3d54ac5738ed.md)
-   [反向代理/内网穿透](https://toutyrater.github.io/app/reverse2.html)


## Notes {#notes}

-   VMess 协议的认证基于时间，一定要保证服务器和客户端的系统时间相差要在一分钟以内。
-   在 V2Ray 中，星号 \* 不具备通配符的意义，只是一个普通的字符而已
-   sniffing (V2Ray 3.32+): 尝试探测流量类型。
    -   enabled: 是否开启流量探测。
    -   destOverride: 当流量为指定类型时，按其中包括的目标地址重置当前连接的目标。
    -   可选值为 "http" 和 "tls"。
-   客户端和服务器之间的版本要一致
    -   尤其是在 4.36 以上版本时
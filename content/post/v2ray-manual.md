+++
title = "v2ray"
date = 2022-03-05T17:20:00+08:00
lastmod = 2022-03-05T20:56:58+08:00
categories = ["VPS"]
draft = false
+++

## 简介 {#简介}

-   [V2Ray 用户手册](https://www.v2ray.com/)
-   [v2ray简易手册](https://selierlin.github.io/v2ray/)
-   [V2Ray 项目地址](https://github.com/v2ray/v2ray-core)


## VS Shadowsocks {#vs-shadowsocks}

-   Shadowsocks 只是一个简单的代理工具，而 V2Ray 定位为一个平台，任何开发者都可以利用 V2Ray 提供的模块开发出新的代理软件。
-   V2Ray 本身只是一个内核，V2Ray 上的图形客户端大多是调用 V2Ray 内核套一个图形界面的外壳
-   V2Ray 不像 Shadowsocks 那样有统一规定的 URL 格式，所以各个 V2Ray 图形客户端的分享链接/二维码不一定通用。
-   V2Ray 对于时间有比较严格的要求，要求服务器和客户端时间差绝对值不能超过 2 分钟,还好 V2Ray 并不要求时区一致。
-   与 Shadowsocks 不同，从软件上 V2Ray 不区分服务器版和客户端版，也就是说在服务器和客户端运行的 V2Ray 是同一个软件，区别只是配置文件的不同。
-   可以用 V2Ray 配置成 Shadowsocks 服务器或者 Shadowsocks 客户端都是可以的，兼容 Shadowsocks-libev.


## TLS(Transport Layer Security) {#tls--transport-layer-security}

译作: **传输层安全性协议** ([wikipedia:传输层安全性协议](https://wuu.wikipedia.org/wiki/%E4%BC%A0%E8%BE%93%E5%B1%82%E5%AE%89%E5%85%A8%E6%80%A7%E5%8D%8F%E8%AE%AE))

前身 \*安全套接层\*（Secure Sockets Layer，缩写：SSL）.


## WebSocket {#websocket}

-   HTTP 协议有一个缺陷：通信只能由客户端发起。
-   WebSocket:服务器可以主动向客户端推送信息，客户端也可以主动向服务器发送信息，属于服务器推送技术的一种.

[WebSocket教程](https://www.ruanyifeng.com/blog/2017/05/websocket.html)


## Shadowsocks {#shadowsocks}

V2Ray 集成有 Shadowsocks 模块的，用 V2Ray 配置成 Shadowsocks 服务器或者 Shadowsocks 客户端都是可以的，兼容 Shadowsocks-libev。


## Vmess {#vmess}

VMess 协议是由 V2Ray 原创并使用于 V2Ray 的加密传输协议.


## 系统安装 {#系统安装}

V2Ray 的安装有脚本安装、手动安装、编译安装 3 种方式.

-   脚本安装

<!--listend-->

```shell
wget https://install.direct/go.sh # 下载脚本

sudo bash go.sh

sudo systemctl start v2ray
```

配置文件路径为 `/etc/v2ray/config.json`

V2Ray 的方法是 **再次执行安装脚本** ！


## docker 安装 {#docker-安装}

-   docker install v2ray

<!--listend-->

```shell
# docker pull v2ray/official
# docker pull v2ray/official:latest

# v2ray change name v2fly
docker pull v2fly/v2fly-core

mkdir /etc/v2ray
# mkdir /var/log/v2ray

docker container start v2ray //启动V2ray
docker container stop v2ray //停止V2ray
docker container restart v2ray //重启V2ray

docker run -d --name v2ray -v /etc/v2ray:/etc/v2ray -p 8888:8888 v2fly/v2fly-core  v2ray -config=/etc/v2ray/config.json

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
docker run -it -d --name v2ray -v /etc/v2ray:/etc/v2ray -p 8888:8888 v2ray/official v2ray -config=/etc/v2ray/config.json
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
        -


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


## 域名路由规则 {#域名路由规则}


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


## [反向代理/内网穿透](https://toutyrater.github.io/app/reverse2.html) {#反向代理-内网穿透}


## Notes {#notes}

-   VMess 协议的认证基于时间，一定要保证服务器和客户端的系统时间相差要在一分钟以内。
-   在 V2Ray 中，星号 \* 不具备通配符的意义，只是一个普通的字符而已
-   sniffing (V2Ray 3.32+): 尝试探测流量类型。
    -   enabled: 是否开启流量探测。
    -   destOverride: 当流量为指定类型时，按其中包括的目标地址重置当前连接的目标。
    -   可选值为 "http" 和 "tls"。
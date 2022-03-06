+++
title = "v2ray(WebSocket+Nginx+CDN+TSL)"
date = 2022-03-05T20:58:00+08:00
lastmod = 2022-03-06T17:07:51+08:00
tags = ["v2ray"]
categories = ["VPS"]
draft = false
+++

目前官方推荐的协议组合方式：

-   VMess over Websocket with TLS
-   VMess over TLS
-   VMess over HTTP/2 （使用 TLS 的 HTTP/2，并非 h2c）
-   Shadowsocks(AEAD) over Websocket with TLS


## v2ray(WebSocket) {#v2ray--websocket}

```shell

# install docker
apt install docker

# docker install v2ray, new version chang repository from v2ray to vwfly
docker pull v2fly/v2fly-core

# create config & log directory of v2ray
mkdir /etc/v2ray
mkdir /var/log/v2ray

# configure
/etc/v2ray/config.json

docker run -d --name v2ray -v /etc/v2ray:/etc/v2ray -p 8888:8888 v2fly/v2fly-core  v2ray -config=/etc/v2ray/config.json

docker container start v2ray
docker container stop v2ray
docker container restart v2ray
docker rm v2ray
```


### `/etc/v2ray/config.json` {#etc-v2ray-config-dot-json}

-   client

<!--listend-->

```js
{
    "log": {
        "loglevel": "warning",
        "access": "/var/log/v2ray/access.log",
        "error": "/var/log/v2ray/error.log"
    },
    "routing": {
        "domainStrategy": "IPIfNonMatch",
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
            },
            {
                "type": "field",
                "outboundTag": "adblock",
                "domain": [
                    "tanx.com",
                    "googeadsserving.cn",
                    "baidu.com"
                ]
            },
            {
                "type": "field",
                "ip": ["geoip:private"],
                "outboundTag": "direct"
            }
        ]
    },
    "inbounds": [
        {
            "listen": "127.0.0.1",
            "port": "1080",
            "protocol": "socks",
            "settings": {
                "auth": "noauth",
                "udp": true,
                "ip": "127.0.0.1"
            }
        },
        {
            "listen": "127.0.0.1",
            "port": "1081",
            "protocol": "http"
        }
    ],
    "outbounds": [
        {
            "protocol": "vmess",
            "settings": {
                "vnext": [
                    {
                        "address": "vps-ip",
                        "port": 443,
                        "users": [
                            {
                                "id": "1fe91e84-7046-41c7-80f7-00a68fe1eb26",
                                "alterId": 0 // must 0, other number tested can't link.
                            }
                        ]
                    }
                ]
            },
            "streamSettings": {
                "network": "ws"
                "security": "none",
                "path": "/ray"
            },
            "tag": "proxy"
        },
        {
            "protocol": "freedom",
            "tag": "direct"
        }
    ],
    "outboundDetour": [
        {
            "protocol": "freedom",
            "settings": {},
            "tag": "direct"
        },
        {
            "protocol": "blackhole",
            "settings": {},
            "tag": "adblock"
        }
    ]
}
```

-   server

<!--listend-->

```js
{
    "log": {
        "loglevel": "warning",
        "access": "/var/log/v2ray/access.log",
        "error": "/var/log/v2ray/error.log"
    },
    "routing": {
        "domainStrategy": "IPIfNonMatch",
        "rules": [
            {
                "type": "field",
                "ip": [
                    "geoip:private"
                ],
                "outboundTag": "block"
            },
            {
                "type": "field",
                "outboundTag": "block",
                "protocol": [
                    "bittorrent"
                ]
            }
        ]
    },
    "inbounds": [
        {
            "sniffing": {
                "enabled": true,
                "destOverride": [
                    "http",
                    "tls"
                ]
            },
            "port": 443,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "1fe91e84-7046-41c7-80f7-00a68fe1eb26",
                        "alterId": 0  // must 0, other number tested can't link.
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "path": "/ray"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        },
        {
            "protocol": "blackhole",
            "tag": "block"
        }
    ]
}
```


## CDN {#cdn}

可以用 freenom 注册免费域名.

在 freenom 中将域名解析服务器更换为 cloudflare 的服务器, 并打开 cloudflare 的 CND 设置.


### cloudflare {#cloudflare}


## Nginx {#nginx}

```shell
# install ngix
apt -y install nginx

# start ngix
systemctl start ngix

# test nginx configuration
nginx -t

nginx -s reload
```


### /etc/nginx.conf {#etc-nginx-dot-conf}

```cfg
user www-data;
w orker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;
worker_rlimit_nofile  655350;
events {
  use epoll;
  worker_connections 65536;
}

http {
  sendfile on;
  tcp_nopush on;
  tcp_nodelay on;
  keepalive_timeout 65;
  types_hash_max_size 2048;
  include /etc/nginx/mime.types;
  default_type application/octet-stream;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
  ssl_prefer_server_ciphers on;
  access_log /var/log/nginx-access.log;
  error_log /var/log/nginx-error.log;

  gzip on;
  server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
      try_files $uri $uri/ =404;
    }

    location /bannedbook { # 与 V2Ray 配置中的 path 保持一致
      proxy_redirect off;
      proxy_pass http://127.0.0.1:10000; #假设WebSocket监听在环回地址的10000端口上
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";
      proxy_set_header Host $http_host;

      # Show realip in v2ray access.log
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
  }
}
```


### /etc/nginx/sites-available/default {#etc-nginx-sites-available-default}

-   [reference](https://1kb.day/posts/tor_obfs4_proxy.html)

<!--listend-->

```js
server {
    listen 80;
    listen [::]:80; //这是IPv4和IPv6的80端口监听
    server_name daotoyi.tk; //域名

    // 下面是真正的ws转发给v2ray
    location /ray {   //与V2Ray配置中的path保持一致
        proxy_redirect off;
        proxy_pass http://127.0.0.1:8888; //假设WebSocket监听在环回地址的8888端口上
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $http_host;
        }
}

server {
    listen 443 ssl http2;  //这是IPv4和IPv6的443端口监听及ssl和http2支持
    listen [::]:443 ssl http2;
    server_name daotoyi.tk;   //域名
    ssl_certificate /etc/letsencrypt/live/xxxx.com/fullchain.pem;  //证书路径，xxxx.xxx改成你的域名
    ssl_certificate_key /etc/letsencrypt/live/xxxx.com/privkey.pem;
    location /ray {     // path路径
        proxy_redirect off;
        proxy_pass http://127.0.0.1:8888;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $http_host;
        // 下面是realip日志，在access.log里面，可留可删除，随意
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
}
```


## TSL {#tsl}

要 TLS 就必须得有域名，得有个反代(如 Nginx).

```shell
systemctl stop nginx

certbot certonly --renew-by-default --email [your-email] -d [xxxx.com](damain) -d www.xxx.com

systemctl start nginx
```


### Certbot {#certbot}

使用自动证书机器人 Certbot,自动签发 Let’s Encrypt 的免费证书,只是需要三个月一续,机器人自动帮忙搞定


### Cloudflare {#cloudflare}

客户端 v2ray 配置 `security` :

```js
"streamSettings": {
    "network": "ws",
    "security": "tls",
    "wsSettings": {
        "path": "/ray"
    }
}
```

如果开启了 tls，cloudflare 到我们的服务器之间是需要进行全链路 ssl，否则会导致访问失败的情况


### note {#note}

注: 生成证书前请关闭服务器的 Apache 或 Nginx,否则会生成失败。


## Reference {#reference}

-   [V2Ray之TLS+WebSocket+Nginx+CDN配置方法](https://fanqiang.gitbook.io/fanqiang/v2ss/v2ray-zhi-tls+websocket+nginx+cdn-pei-zhi-fang-fa#v2ray-wei-zhuang-wang-zhan)
-   [V2Ray使用Nginx实现WebSocket+TLS+Web代理](https://1kb.day/posts/v2ray_tls_proxy.html)
-   [V2Ray (WebSocket + TLS + Web + Cloudflare) 手动配置详细说明](https://ericclose.github.io/V2Ray-TLS-WebSocket-Nginx-with-Cloudflare.html)
-   [V2ray WS TLS自动续签证书+订阅](http://elmagnifico.tech/2020/06/07/V2ray-WS-TLS/)


## Camouflage website {#camouflage-website}

隐藏 vps, 防止被墙:

-   CND
-   Nginx
-   TSL

为了隐藏和伪装的更逼真，弄一些英文网页放到 vps 的/var/www/html 目录下，当然，必须包括一个 index.html ,


## Note {#note}

-   traffic route

v2ray(port 80/443) --&gt; CND --&gt; Nginx(80/443-&gt;8888) --&gt; v2ray(8888:8888)

-   traffic route(simple)

v2ray(port 8888) --&gt; (8888:8888)

-   "alterId": 0

must 0, other number tested can't link.
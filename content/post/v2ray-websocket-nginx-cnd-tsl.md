+++
title = "v2ray 搭建笔记"
description = "WebSocket+TSL+CDN+Nginx"
date = 2022-03-05T20:58:00+08:00
lastmod = 2022-04-02T08:27:16+08:00
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


### startup {#startup}

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


### client {#client}

`/etc/v2ray/config.json`


#### port:80 {#port-80}

```js
{
  "log": {
    "access": "",
    "error": "",
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "tag": "socks",
      "port": 10808,
      "listen": "127.0.0.1",
      "protocol": "socks",
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "settings": {
        "auth": "noauth",
        "udp": true,
        "allowTransparent": false
      }
    },
    {
      "tag": "http",
      "port": 10809,
      "listen": "127.0.0.1",
      "protocol": "http",
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "settings": {
        "udp": false,
        "allowTransparent": false
      }
    }
  ],
  "outbounds": [
    {
      "tag": "proxy",
      "protocol": "vmess",
      "settings": {
        "vnext": [
          {
            "address": "107.xxx.xxx.116",
            "port": 80,
            "users": [
              {
                "id": "1fe91e84-7046-41c7-80f7-00a68fe1eb26",
                "alterId": 0,
                "email": "t@t.tt",
                "security": "auto"
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/daotoyi"
        }
      },
      "mux": {
        "enabled": false,
        "concurrency": -1
      }
    },
    {
      "tag": "direct",
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag": "block",
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      }
    }
  ],
  "routing": {
    "domainStrategy": "IPIfNonMatch",
    "domainMatcher": "linear",
    "rules": [
      {
        "type": "field",
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "enabled": true
      },
      {
        "type": "field",
        "port": "0-65535",
        "outboundTag": "proxy",
        "enabled": true
      }
    ]
  }
}
```


#### port:433 {#port-433}

```js
{
  "log": {
    "access": "",
    "error": "",
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "tag": "socks",
      "port": 10808,
      "listen": "127.0.0.1",
      "protocol": "socks",
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "settings": {
        "auth": "noauth",
        "udp": true,
        "allowTransparent": false
      }
    },
    {
      "tag": "http",
      "port": 10809,
      "listen": "127.0.0.1",
      "protocol": "http",
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "settings": {
        "udp": false,
        "allowTransparent": false
      }
    }
  ],
  "outbounds": [
    {
      "tag": "proxy",
      "protocol": "vmess",
      "settings": {
        "vnext": [
          {
            "address": "107.xxx.xxx.116",
            "port": 443,
            "users": [
              {
                "id": "1fe91e84-7046-41c7-80f7-00a68fe1eb26",
                "alterId": 0, // must 0, other number tested can't link.
                "email": "t@t.tt",
                "security": "auto"
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "allowInsecure": true
        },
        "wsSettings": {
          "path": "/daotoyi"
        }
      },
      "mux": {
        "enabled": false,
        "concurrency": -1
      }
    },
    {
      "tag": "direct",
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag": "block",
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      }
    }
  ],
  "routing": {
    "domainStrategy": "IPIfNonMatch",
    "domainMatcher": "linear",
    "rules": [
      {
        "type": "field",
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "enabled": true
      },
      {
        "type": "field",
        "port": "0-65535",
        "outboundTag": "proxy",
        "enabled": true
      }
    ]
  }
}
```


### server {#server}

`/etc/v2ray/config.json`

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
                "wsSettings": {
                    "path": "/daotoyi"
                }
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


## CDN/TLS {#cdn-tls}

可以用 freenom 注册免费域名.

在 freenom 中将域名解析服务器更换为 cloudflare 的服务器, 并打开 cloudflare 的 CND 设置.


### cloudflare {#cloudflare}

要 TLS 就必须得有域名，得有个反代(如 Nginx).

```shell
systemctl stop nginx

certbot certonly --renew-by-default --email [your-email] -d [xxxx.com](damain) -d www.xxx.com

systemctl start nginx
```


### Certbot {#certbot}

使用自动证书机器人 Certbot,自动签发 Let’s Encrypt 的免费证书,只是需要三个月一续,机器人自动帮忙搞定


#### Before {#before}

```bash
# 安装 cerbot
[root@  ~]# yum install certbot
[root@  ~]# yum install python3-certbot-nginx

# 使用certbot --nginx命令获取证书
# certbot会自动获取证书，并修改/etc/nginx/nginx.conf文件的配置
cerbot --nginx

# 新证书测试，这只是个测试，并不保存任何文件
certbot renew --dry-run

# 更新证书
certbot renew
```

使用 Linux 的计划任务自动更新证书(新版本会自动更新）

```conf-unix
[root@ ~]# cat /etc/crontab
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root

# For details see man 4 crontabs

# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name  command to be executed

0 0 */1 * * root /usr/bin/certbot renew
#配置示例，请自行验证
```


#### Now {#now}

-   <https://snapcraft.io/install/certbot/rhel>

<!--listend-->

```bash
# 在 CentOS/Redaht7  中添加 EPEL
sudo yum install -y epel-release

# 在 CentOS/Redaht8  中添加 EPEL
# sudo dnf install epel-release
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo dnf upgrade

yum install -y snapd
systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
certbot --nginx # Certbot自动编辑Nginx配置
certbot certonly --nginx # 仅获得证书, 不配置Nginx
# 测试自动续订
certbot renew --dry-run
```

**Certbot 包带有 cron 作业或 systemd 计时器，它将在证书过期之前自动续订证书。除非更改配置，否则不需要再次运行 Certbot。**


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

如果服务器开启了 tls，cloudflare 到我们的服务器之间是需要进行全链路 ssl，否则会导致访问失败的情况

点击 cloudflare 的 SSL/TLS 菜单，在 SSL 的那一栏，将右侧的下拉框设置为 Full（Full 表示客户端-&gt;CDN，CDN-&gt;服务器的数据传输都加密），默认为 Flexible（ **Flexible 表示客户端-&gt;CDN 加密，CDN-&gt;服务器不加密** ）

若因为服务器已经开启了 tls，所以需要设置为 Full。


### Note {#note}

注: 生成证书前请关闭服务器的 Apache 或 Nginx,否则会生成失败。


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


### /etc/nginx/nginx.conf {#etc-nginx-nginx-dot-conf}

```cfg
user nginx;
worker_processes auto;
# pid /run/nginx.pid;
# include /etc/nginx/modules-enabled/*.conf;
worker_rlimit_nofile  655350;

events {
  use epoll;
  multi_accept on;
  worker_connections 65536;
}

http {
  sendfile on;
  tcp_nopush on;
  tcp_nodelay on;
  keepalive_timeout 65;
  keepalive_requests 10000;
  types_hash_max_size 2048;

  access_log /var/log/nginx-access.log;
  error_log /var/log/nginx-error.log;

  # gzip on;
  server {
    if ($host = daotoyi.tk) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80 default_server;
    listen [::]:80 default_server;
    server_name daotoyi.tk;

    root /var/www/daotoyi;
    index index.html index.htm index.nginx-debian.html;

    location /daotoyi { # match path in V2Ray configuration
      proxy_redirect off;
      proxy_pass http://127.0.0.1:8888;
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";
      proxy_set_header Host $http_host;

      # Show realip in v2ray access.log
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}

  server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name daotoyi.tk;

    ssl_session_timeout 1d;
    ssl_session_cache shared:MozSSL:10m;
    ssl_session_tickets off;

    ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
    # ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
    ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
    ssl_prefer_server_ciphers off;

    ssl_certificate /etc/letsencrypt/live/daotoyi.tk/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/daotoyi.tk/privkey.pem; # managed by Certbot

    location /daotoyi {
        if ($http_upgrade != "websocket") { # WebSocket协商失败时返回404
                return 404;
         }
        proxy_redirect off;
        proxy_pass http://127.0.0.1:8888;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $http_host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
  }
}
```


### firewall {#firewall}

```bash
# 查看端口分配
netstat -ntlp
# Active Internet connections (only servers)
# Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
# tcp        0      0 0.0.0.0:443             0.0.0.0:*               LISTEN      103118/nginx: maste
# tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      103118/nginx: maste
# tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      740/sshd
# tcp        0      0 0.0.0.0:8888            0.0.0.0:*               LISTEN      66848/docker-proxy
# tcp6       0      0 :::443                  :::*                    LISTEN      103118/nginx: maste
# tcp6       0      0 :::80                   :::*                    LISTEN      103118/nginx: maste
# tcp6       0      0 :::22                   :::*                    LISTEN      740/sshd
# tcp6       0      0 :::8888                 :::*                    LISTEN      66852/docker-proxy

# 配置端口
firewall-cmd --zone=public --add-port=80/tcp --permanent

systemctl restart firewalld.service
```


## BBR {#bbr}

Google 设计，于 2016 年发布的拥塞算法。以往大部分拥塞算法是基于丢包来作为降低传输速率的信号，而 BBR 则基于模型主动探测。

仅仅安装 v2ray，跨境上网的速度并不快，比如看 youtube 视频会卡，所以请务必再安装谷歌开发的加速器 BBR

```shell
  # 下载bbr安装脚本
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh
# 将脚本变成可执行
chmod +x bbr.sh
# 运行脚本
./bbr.sh
# 查看bbr是否安装成功
lsmod | grep bbr
```


## Reference {#reference}

-   [Project V](https://www.v2fly.org/)
-   [V2Ray之TLS+WebSocket+Nginx+CDN配置方法](https://fanqiang.gitbook.io/fanqiang/v2ss/v2ray-zhi-tls+websocket+nginx+cdn-pei-zhi-fang-fa#v2ray-wei-zhuang-wang-zhan)
-   [V2Ray使用Nginx实现WebSocket+TLS+Web代理](https://1kb.day/posts/v2ray_tls_proxy.html)
-   [V2Ray (WebSocket + TLS + Web + Cloudflare) 手动配置详细说明](https://ericclose.github.io/V2Ray-TLS-WebSocket-Nginx-with-Cloudflare.html)
-   [V2ray WS TLS自动续签证书+订阅](http://elmagnifico.tech/2020/06/07/V2ray-WS-TLS/)
-   [V2Ray使用Nginx实现WebSocket+TLS+Web代理](https://1kb.day/posts/v2ray_tls_proxy.html)


## Camouflage {#camouflage}

隐藏 vps, 防止被墙:

-   TSL
-   CND
-   Nginx

为了隐藏和伪装的更逼真，弄一些英文网页放到 vps 的/var/www/html 目录下，当然，必须包括一个 index.html ,


## Note {#note}


### traffic route {#traffic-route}

-   v2ray(port 80/443) --&gt; CND --&gt; Nginx(80/443-&gt;8888) --&gt; v2ray(8888:8888)


### traffic route(simple) {#traffic-route--simple}

-   v2ray(port 8888) --&gt; (8888:8888)


### "alterId": 0 {#alterid-0}

-   must 0, other number tested can't link.


### 8888 reference : {#8888-reference}

```bash
docker run -d --name v2ray -v /etc/v2ray:/etc/v2ray -p 8888:8888 v2fly/v2fly-core  v2ray -config=/etc/v2ray/config.json
```


## Conclusion {#conclusion}

{{< figure src="https://cdn.jsdelivr.net/gh/jamesxwang/cdn/img/v2ray/process.png" >}}

请求链路如下：

-   浏览器输入网址
-   SwitchyOmega 代理至本地 10808 端口
-   本机 V2Ray 监听 10808 端口
-   将流量通过 VMESS 和 WebSocket 协议请求 example.com/v2ray
-   Nginx 反向代理到 8888 端口（docker 安装时需要与映射端口一致）
-   服务端 V2Ray 验证 id 和 alterId
-   转发请求

另外，还可通过 CDN 加速拯救被 ban ip，但可能会降低速度。

v2ray(websocks+tsl+cnd+nginx)几种组合：

| config          |               | type1    | type2                 | type3      |
|-----------------|---------------|----------|-----------------------|------------|
| v2ray clients   | address       | ip       | ip                    | daotoyi.tk |
|                 | port          | 80       | 443                   | 433        |
|                 | security      | auto     | auto                  | auto       |
|                 | alterid       | 0        | 0                     | 0          |
|                 | network       | ws       | ws                    | ws         |
|                 | tls           | -        | tls                   | tls        |
|                 | allowinsecure | -        | ?farlse               | -/false    |
| cnd(cloudflare) | SSL           | flexible | full(strict:trued CA) | &lt;- same |
| v2ray sever     | alterid       | 0        | 0                     | 0          |
|                 | security      | none     | none                  | none       |
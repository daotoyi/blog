---
title: "Xray+XTLS+VLESS(前端 Nginx SNI 分流)"
description: "Vless xtls & Trojan xtls & Vless ws & Vless gRPC & Trojan gRPC"
date: "2022-07-29 07:31:00"
lastmod: "2022-07-29 07:32:05"
categories: ["VPS"]
draft: false
toc: true
---

## 简述 {#简述}

Nginx 和 Xray 共用 443 端口，一般就两种方案:

-   Xray 做前端
    -   监听 443 端口，给 Vless 用
    -   利用 vless+tcp+tls 强大的回落/分流特性，实现 Trojan 和 Nginx 共用 443 端口。
-   Nginx 做前端
    -   监听 443 端口，给网站用
    -   利用 Nginx SNI，实现 Vless 、Trojan 和 gRPC 共用 443 端口。


## nginx 前端 {#nginx-前端}

前端 Nginx 用 SNI 分流，后端使用 Xray(vless+xtls &amp; vless+ws &amp; trojan+xtls &amp; Vless+gRPC)

-   利用 Nginx 支持 SNI 分流特性，对 Vless+tcp 与 Trojan+tcp 进行 SNI 分流（四层转发），实现共用 443 端口。
-   支持 Vless+tcp 与 Trojan+tcp 完美共存，支持各自 xtls 应用，但需多个域名来标记分流。
-   Vless 和 Trojan 均使用进程监听，提高性能，并启用 PROXY protocol。


## xray 配置 {#xray-配置}

```js
{
  "log": {
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "listen": "/dev/shm/vless.sock",
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "1fe91e84-7046-41c7-80f7-00a68fe1eb26",
            "flow": "xtls-rprx-direct"
          }
        ],
        "decryption": "none",
        "fallbacks": [
          {
            "alpn": "h2",
            "dest": "/dev/shm/h2c.sock",
            "xver": 2
          },
          {
            "dest": "/dev/shm/h1.sock",
            "xver": 2
          },
          {
            "path": "/vlessws",
            "dest": "@vless-ws",
            "xver": 2
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "alpn": [
            "h2",
            "http/1.1"
          ],
          "minVersion": "1.2",
          "cipherSuites": "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256:TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384:TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256",
          "certificates": [
            {
              "certificateFile": "/etc/ssl/fullchain.cer",
              "keyFile": "/etc/ssl/domain.com.key",
              "ocspStapling": 3600
            }
          ]
        },
        "tcpSettings": {
          "acceptProxyProtocol": true
        }
      }
    },
    {
      "listen": "@vless-ws",
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "1fe91e84-7046-41c7-80f7-00a68fe1eb26"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "acceptProxyProtocol": true,
          "path": "/vlessws"
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    },
    {
      "listen": "/dev/shm/trojan.sock",
      "protocol": "trojan",
      "settings": {
        "clients": [
          {
            "password":"Your password",
            "flow": "xtls-rprx-direct"
          }
        ],
        "fallbacks": [
          {
            "alpn": "h2",
            "dest": "/dev/shm/h2c.sock",
            "xver": 2
          },
          {
            "dest": "/dev/shm/h1.sock",
            "xver": 2
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "xtls",
        "xtlsSettings": {
          "alpn": [
            "h2"
          ],
          "minVersion": "1.2",
          "cipherSuites": "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256:TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384:TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256",
          "certificates": [
            {
              "certificateFile": "/etc/ssl/fullchain.cer",
              "keyFile": "/etc/ssl/domain.com.key",
              "ocspStapling": 3600
            }
          ]
        },
        "tcpSettings": {
          "acceptProxyProtocol": true
        }
      }
    },
    {
      "listen": "/dev/shm/vgrpc.sock",
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "1fe91e84-7046-41c7-80f7-00a68fe1eb26"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "grpc",
        "security": "none",
        "grpcSettings": {
          "serviceName": "vdngrpc" # match with config in Nginx
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    },
    {
      "listen": "/dev/shm/tgrpc.sock",
      "protocol": "trojan",
      "settings": {
        "clients": [
          {
            "password": "xxxxxx"
          }
        ]
      },
      "streamSettings": {
        "network": "grpc",
        "security": "none",
        "grpcSettings": {
          "serviceName": "tdngrpc"
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
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

Vless+ws 采用的是回落/分流方式实现，不是用 Nginx 反向代理实现，所以在接下来的 Nginx 配置中不需要 ServiceName 与 Xray 配置相对应


## nginx 配置 {#nginx-配置}


### nginx.conf {#nginx-dot-conf}

/etc/nginx/nginx.conf

```cfg
user  root;
worker_processes auto;

error_log  /var/log/nginx/error.log;

pid       /run/nginx.pid;

events {
    worker_connections 1024;
}

stream {
    map $ssl_preread_server_name $backend_name {
        v.domain.com  vless;
        t.domain.com trojan;
        domain.com      web;
        default         web;
    }

    upstream vless {
        server unix:/dev/shm/vless.sock;
    }

    upstream trojan {
        server unix:/dev/shm/trojan.sock;
    }

    upstream web {
        server unix:/dev/shm/web.sock;
    }

    server {
        listen 443;
        listen [::]:443;
        ssl_preread on;
        proxy_protocol on;
        proxy_pass  $backend_name;
    }
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for" '
                      '$proxy_protocol_addr:$proxy_protocol_port';

  access_log  /var/log/nginx/access.log  main;

    sendfile on;
    keepalive_timeout 65;
    include /etc/nginx/conf.d/*.conf;
}
```


### default.conf {#default-dot-conf}

/etc/nginx/conf.d/default.conf

```cfg
server {
    listen 80;
    listen [::]:80;
    return 301 https://domain.com$request_uri;
}

server {
    listen unix:/dev/shm/h1.sock proxy_protocol;
    listen unix:/dev/shm/h2c.sock proxy_protocol;
    set_real_ip_from unix:;
    return 301 https://domain.com$request_uri;
}

server {
    listen unix:/dev/shm/web.sock ssl http2 proxy_protocol;
    server_name domain.com www.domain.com;
    if ($host != domain.com) { return 301 https://domain.com$request_uri; }
    set_real_ip_from unix:;
    ssl_certificate /etc/ssl/fullchain.cer;
    ssl_certificate_key /etc/ssl/domain.com.key;
    ssl_session_cache    shared:SSL:1m;
    ssl_session_timeout  5m;
    ssl_session_tickets  off;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers  TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-ECDSA-CHACHA20-POLY1305;
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;

    location / {
    proxy_pass http://unix:/run/cloudreve.sock;
    client_max_body_size 20000m;
    proxy_redirect     off;
    proxy_buffer_size          64k;
    proxy_buffers              32 32k;
    proxy_busy_buffers_size    128k;
    }

    location /vdngrpc { # 修改为自己的服务名称 与xray配置里一致
    if ($request_method != "POST") {
            return 404;
        }
        client_body_buffer_size 1m;
        client_body_timeout 1h;
        client_max_body_size 0;
        grpc_read_timeout 1h;
        grpc_send_timeout 1h;
        grpc_pass grpc://unix:/dev/shm/vgrpc.sock;
    }

    location /tdngrpc { # 修改为自己的服务名称 与xray配置里一致
    if ($request_method != "POST") {
            return 404;
        }
        client_body_buffer_size 1m;
        client_body_timeout 1h;
        client_max_body_size 0;
        grpc_read_timeout 1h;
        grpc_send_timeout 1h;
        grpc_pass grpc://unix:/dev/shm/tgrpc.sock;
    }
}
```


## Ref {#ref}

-   [!!!Nginx SNI分流（端口复用）使用Xray+VLESS+XTLS](https://qoant.com/2021/05/xray-nginx-sni/) (ngix-&gt;443-&gt;xray)
-   [!!! Nginx SNI+Xray(Vless xtls &amp; Trojan xtls &amp; Vless ws &amp; Vless gRPC &amp; Trojan gRPC)](https://cnix.win/87.html) (ngix-&gt;443-&gt;xray)
-   [XTROJAN黑科技-xray](https://xtrojan.net/tag/xray/page/2)
---
title: "Nginx 反向代理和 Acme 证书配置"
date: "2023-10-17 10:38:00"
lastmod: "2023-11-13 08:34:24"
categories: ["Internet"]
draft: false
---

## nginx {#nginx}

-   nginx

<!--listend-->

```cfg
ocker run -d \
  --restart=unless-stopped \
  --name nginx \
  --net host \
  --label nginx \
  -v /home/ubuntu/data/nginx/certs:/etc/nginx/certs \ # 可选
  -v /home/ubuntu/data/nginx/log:/var/log/nginx \
  -v /home/ubuntu/data/nginx/www:/var/www \
  -v /home/ubuntu/data/nginx/conf.d:/etc/nginx/conf.d \
  nginx
```

/etc/nginx/certs 目录用于 SSL。

-   nginx/conf.d; vim domainxx.conf

<!--listend-->

```cfg
server {
    listen       80;
    server_name  <domain.com>;

    location / {
        proxy_pass http://<docker net>:<port>;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

proxy_set_header 的一系列内容必须添加。如果不添加这些内容，会导致网站加载速度异常缓慢，而且像 css, js 文件都有可能不被加载出来。

-   docker exec nginx nginx -s reload


## Acme.sh {#acme-dot-sh}

签发 SSL 证书需证明这个域名的所有权，一般有两种方式验证: http 和 dns 验证。使用 acme.sh 能够定时自动续签，非常方便。部署步骤为:

获取 DNS 解析 api。泛域名证书貌似只能使用 DNS 验证的方式，这种方式要获取 DNS 验证 api，不同服务器商家各有不同，腾讯云的在 API 密钥 - DNSPod。在该页面的 DNSPod Token 中创建密钥。
使用 Dcoker 来安装 acme 容器。对应的密钥、域名要更改

```cfg
docker run -d \
  --restart=unless-stopped \
  --name acme \
  --net host \
  -v /home/ubuntu/data/acme:/acme.sh \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v /home/ubuntu/data/nginx/certs:/etc/nginx/certs \
  -e DP_Id="ID" \
  -e DP_Key="Key" \
  -e DEPLOY_DOCKER_CONTAINER_LABEL="nginx" \
  -e DEPLOY_DOCKER_CONTAINER_KEY_FILE='/etc/nginx/certs/<domain.com>/cert.pem' \
  -e DEPLOY_DOCKER_CONTAINER_FULLCHAIN_FILE='/etc/nginx/certs/<domain.com>/fullchain.pem' \
  -e DEPLOY_DOCKER_CONTAINER_RELOAD_CMD='nginx -s reload' \
  neilpang/acme.sh daemon
```

```bash
# 生成证书。证书默认是使用 zerossl 方式生成。zerossl 需先注册。
docker exec -i acme acme.sh --register-account -m email@mail.com

# 生成泛域名证书。如果不使用 zero ssl 则用第二条 letsencrypt。
# zero ssl
docker exec -i acme acme.sh --issue --dns dns_dp -d <domain.com> -d <*.domain.com> --force --dnssleep

# letsencrypt，好像不需要注册
docker exec -i acme acme.sh --issue --dns dns_dp -d <domain.com> -d <*.domain.com> --force --dnssleep --set-default-ca --server letsencrypt

# 部署证书。
docker exec -i acme acme.sh --deploy -d <domain.com> --deploy-hook docker
```

使用 SSL 证书后，Nginx 的配置需要做修改。注意更换容器 IP 和域名。

```cfg
server {
    listen      80;
    listen [::]:80;
    server_name  blog.domain.com;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name blog.domain.com;
    location / {
        proxy_pass http://172.18.0.5:80;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_redirect off;
        proxy_set_header X-Real-Port $remote_port;
        proxy_set_header HTTP_X_FORWARDED_FOR $remote_addr;
        proxy_set_header X-NginX-Proxy true;
        proxy_set_header Accept-Encoding "";
    }

    ssl_certificate /etc/nginx/certs/<domain.com>/fullchain.pem;
    ssl_certificate_key /etc/nginx/certs/<domain.com>/cert.pem;
    add_header Strict-Transport-Security "max-age=63072000" always;
}
```

ssl_certificate 和 ssl_certificate_key 是 Nginx 配置文件中的两个指令，它们分别用于指定服务器证书和私钥文件的位置。

修改完成后重启 Nginx: `docker exec nginx nginx -s reload`


## reference {#reference}

-   [Nginx (反向代理) 和 Acme (证书配置)](https://mp.weixin.qq.com/s/3Bp7Ii7PqbbAU3HNd3a1kg)
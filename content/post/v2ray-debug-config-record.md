---
title: "v2ray 趟坑"
date: "2022-04-01 16:43:00"
lastmod: "2022-04-30 12:50:20"
tags: ["v2ray"]
categories: ["VPS"]
draft: false
---

## port {#port}


### 443 端口 {#443-端口}

-   速度没有 80 端口快
-   得配套设置 security："tsl",设置跳过证书验证（allowInsecure：true）


### 80 端口 {#80-端口}

-   不能设置 secrity:"tsl",否则无法连通。


### 8888 端口 {#8888-端口}

-   Nginx 反向代理到 8888 端口（docker 安装时需要与映射端口一致）


## selinux {#selinux}

在 Centos7 上，selinux 阻止数据转发给 v2ray 服务端。（在/var/log/nginx/ 查看 access.log 可以看到很多的 Permission Denied）

```bash
setsebool -P httpd_can_network_connect 1
```


## 502 Bad Gateway {#502-bad-gateway}

&gt; websocket: bad handshake


## Connection refused {#connection-refused}


### slinux 影响 {#slinux-影响}


### v2ray 未启动 {#v2ray-未启动}


## failed to find an available destination {#failed-to-find-an-available-destination}

配置文件问题：

入坑：漏掉 json 键，折腾了小一周时间……

```js
"wsSettings": {
    "path": "/daotoyi"
}
```
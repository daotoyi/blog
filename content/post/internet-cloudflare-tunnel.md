---
title: "Cloudflare Tunnel"
date: "2022-10-22 08:31:00"
lastmod: "2022-10-22 08:31:36"
categories: ["Internet"]
draft: false
---

## CF Tunnel {#cf-tunnel}


### CF Tunnel 介绍 {#cf-tunnel-介绍}

> Cloudflare Tunnel provides you with a secure way to connect your resources to Cloudflare without a publicly routable IP address.

这是 Cloudflare 在他的产品介绍页里面介绍 Tunnel 这个功能的描述，很直观， **Tunnel 的作用就是那你可以在公网连接上你没有公网网络的资源** 。这里的资源可以是主机，虚拟机或者容器，甚至是 HTTP 服务之类的。


### Tunnel 使用概述 {#tunnel-使用概述}

Tunnel 的使用根据不同的服务类型使用方式也是不一样的：

-   如果你是暴露 HTTP 服务，那么只需要在服务端运行 cloudflared 程序即可.
-   如果你是暴露 SSH 服务，那么除了需要在服务端运行 cloudflared 程序，在客户端也需要运行 cloudflared 程序


### 安装 cloudflared {#安装-cloudflared}

```bash
[root@liqiang.io]# brew install cloudflare/cloudflare/cloudflared
```


### 配置 cloudflared {#配置-cloudflared}

```bash
[root@liqiang.io]# cloudflared tunnel login
```

执行这个命令之后，它会生成一个链接然后你在浏览器上打开这个链接，然后登陆你的账号，如果有域名的话，选择一下绑定的域名就可以了，没域名或者不想绑定可以跳过。


## 服务端 {#服务端}


### 创建 Tunnel {#创建-tunnel}

```bash
[root@liqiang.io]# cloudflared tunnel create default
# 记住这个命令返回的那个 UUID，如果没记住的话，问题也不大，有两种方式可以看到他：

[root@liqiang.io]# cloudflared tunnel list
You can obtain more detailed information for each tunnel with `cloudflared tunnel info <name/uuid>`
ID                                   NAME      CREATED              CONNECTIONS
1c025733-a2ec-4ec5-8d3a-9c9d6775e49b default   2022-09-28T00:33:33Z 2xNRT, 2xSIN
[root@liqiang.io]# ls -al ~/.cloudflared
total 20
drwx------  2 liqiang.io liqiang.io 4096 Sep 28 08:44 .
drwxr-xr-x 55 liqiang.io liqiang.io 4096 Sep 28 21:34 ..
-rw-------  1 liqiang.io liqiang.io  161 Sep 28 08:33 1c025733-a2ec-4ec5-8d3a-9c9d6775e49b.json
```


### 配置 Tunnel {#配置-tunnel}


#### 配置 SSH 服务 {#配置-ssh-服务}

```bash
[root@liqiang.io]# cat ~/.cloudflared/config.yml
ingress:
  - hostname: ssh.liqiang.io
    service: ssh://localhost:22
  - service: http_status:404
tunnel: 1c025733-a2ec-4ec5-8d3a-9c9d6775e49b
credentials-file: /root/.cloudflared/1c025733-a2ec-4ec5-8d3a-9c9d6775e49b.json
```

这就是一个 SSH 服务的配置，这里有几个细节需要介绍一下：

-   文件名默认为 config.yml，位置为你的 HOME 目录下的 .cloudflared 目录中；
-   当然，你也可以自定义文件名，但是这样的话，启动时就需要指定文件路径了，因为 cloudflared 默认查找的文件名只会是 config.yml
-   SSH 服务的配置必须有一个默认的配置兜底：- service: http_status:404
-   tunnel 的值就是前面让你记起来的值


#### 配置 HTTP 服务 {#配置-http-服务}

```bash
[root@liqiang.io]# cat ~/.cloudflared/config.yml
url: http://localhost:2223
tunnel: 1c025733-a2ec-4ec5-8d3a-9c9d6775e49b
credentials-file: /root/.cloudflared/1c025733-a2ec-4ec5-8d3a-9c9d6775e49b.json
```


### 上报路由配置 {#上报路由配置}

前面你只是在本地上配置了应用的信息，但是 Cloudflare 还不知道啊，所以你需要在 Cloudflare 上注册你的 DNS 信息：

```bash
[root@liqiang.io]# cloudflared tunnel route dns 1c025733-a2ec-4ec5-8d3a-9c9d6775e49b default
```

这里表示的是你想注册一个域名为 default 的公网服务，这里的域名的后缀取决于你有没有绑定域名，如果有的话就是你绑定的域名，没有的话就是 Cloudflare 给你分配的，例如：default.cdn.cloudflare.net


### 启动服务 {#启动服务}

```bash
[root@liqiang.io]# cloudflared tunnel run
```


## 客户端 {#客户端}


### HTTP 服务 {#http-服务}

如果你暴露的是 HTTP 服务，那么无需额外的配置，只需要访问域名就可以了，例如我的就是示例域名：default.liqiang.io，直接访问你就可以看到暴露出来的 HTTP 服务了。


### SSH 服务 {#ssh-服务}

```bash
[root@liqiang.io]# cat ~/.ssh/config
Host default.liqiang.io
  ProxyCommand /root/cloudflared access ssh --hostname %h

#直接访问这个 SSH 服务了:
[root@liqiang.io]# ssh root@default.liqiang.io
```


## Ref {#ref}

-   [如何使用 Cloudflare Tunnel 免费服务将家庭网络中的设备暴露到公网](https://mp.weixin.qq.com/s/e2qS9kWpmQivsAFOQ93UUQ)
-   [通过 Cloudflare Tunnel 开放 VM](https://liqiang.io/post/export-vm-with-cloudfalre-tunnel)(原文）
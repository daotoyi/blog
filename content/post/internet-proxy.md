---
title: "网络代理简介"
description: "Transparent/Forward/Rerverse Proxy"
date: "2022-04-04 22:37:00"
lastmod: "2022-04-30 12:35:54"
categories: ["Internet"]
draft: false
---

## 透明代理(Transparent Proxy) {#透明代理--transparent-proxy}

是另一种类型的 HTTP 代理，它们不会修改通过它们发送的请求。

透明意味着代理本身对用户是不可见( invisible )的，也就是说用户侧不需要进行代理设置(区别于前向代理)，请求的目标也是真实的服务器(区别于反向代理)。

Linux 通过 IP_TRANSPARENT 和 TPROXY 可以轻松地实现透明代理。


## 前/正向代理(Forward Proxy) {#前-正向代理--forward-proxy}


## 反向代理(Reverse Proxy) {#反向代理--reverse-proxy}

以代理服务器来接受 internet 上的连接请求，然后将请求转发给内部网络上的服务器，并将从服务器上得到的结果返回给 internet 上请求的客户端，此时代理服务器对外表现为一个反向代理服务器。

反向代理，架设在服务器端；


## 前向代理 VS 反向代理 {#前向代理-vs-反向代理}

区分它们主要看代理在请求中扮演的角色是客户端还是服务器。

{{< figure src="https://switch-router.gitee.io/assets/img/transparent-proxy/forward-reverse.png" >}}

-   正向代理，代理客户端，服务端不知道实际发起请求的客户端；

-   反向代理，代理服务端，客户端不知道实际提供服务的服务端；
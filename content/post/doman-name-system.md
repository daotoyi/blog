---
title: "Domain name system 解析"
date: "2022-02-07 08:44:00"
lastmod: "2022-04-30 12:34:27"
tags: ["domain"]
categories: ["Internet"]
draft: false
---

-   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2022-02-12 周六 08:44]</span></span>


## DNS（Domain Name System[域名系统]) {#dns-domain-name-system-域名系统}

万维网上作为域名和 IP 地址相互映射的一个[分布式数据库]能够使用户更方便的访问互联网，而不用去记住能够被机器直接读取的 IP 数串。


## A (Address) 记录 {#a--address--记录}

用来指定域名对应的 IP 地址记录。

当多个域名都指向一个网站服务器上时，需要将这些子域名（顶级域名下面的二级域名、三级域名都称之为子域名）设置并指向自己的网站服务器上的，这个动作一般称之为 A 记录，又称 IP 指向。


## CNAME 别名记录 {#cname-别名记录}

将多个名字映射到另外一个域名。

****简单来说，A记录就是把一个域名解析到一个 IP 地址，而 CNAME 记录就是把域名解析到另外一个域名。****

1.  CNAME 提供了单一服务器和海量服务器的在管理访问上的灵活性。单一服务器的场景下，通过将大量子域名指向到 CNAME，再由 CNAME 指向到单一域名，解决了服务器更换、迁移带来的大量域名重新指向的问题。

2.  CNAME 配合负载均衡系统，还可以实现将大量访问需求通过 CNAME 指向到多台服务器，以提高用户访问的速度。


## CDN（内容分发网络） {#cdn-内容分发网络}

主要功能是将原本离用户比较远的源站服务器，通过丰富的节点（缓存服务器）放到离用户最近的地方，实现用户对互联网上资源的快速访问。


## A - CNAME - CND 流程 {#a-cname-cnd-流程}

<style>.org-center { margin-left: auto; margin-right: auto; text-align: center; }</style>

<div class="org-center">

[点击此处查看](https://img-blog.csdnimg.cn/276cac54b8c547b99bde38e8b66777c6.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0REX29yeg==,size_16,color_FFFFFF,t_70)

</div>
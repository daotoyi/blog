---
title: "Github Pages 托管静态网页绑定自定义域名"
date: "2022-02-07 08:29:00"
lastmod: "2024-01-01 16:23:52"
categories: ["Github"]
draft: false
---

## Git Pages {#git-pages}

只能为每个 GitHub 帐户创建一个用户或组织站点；而项目站点没有限制。

-   用户或组织站点
    新建 username.github.io 仓库，将静态网页文件所在分支托管到 Github Pages。

-   项目站点
    新建项目仓库,名称不受限.


## Domain name {#domain-name}

购买域名（aliyun 及 cloud.tencent 默认有免费的解析）

添加域名解析，有两种类型:

-   A

　A，直接指向 ip，后面的记录值填 ping github page 得到的 ip 地址，但有时候 IP 地址会更改，导致最后解析不正确. 推荐 CNAME 方法

-   CNAME

　CNAME，主机记录写@，后面记录值 xxxx.github.io；再添加一条 CNAME，主机记录写 www，后面记录值和前面一样

以下是腾讯云域名(daotoyi.cn)记录:

|   | 主机记录 | 记录类型 | 线路类型 | 记录值            | TTL | note       |
|---|------|------|------|----------------|-----|------------|
| 1 | @      | A     | 默认 | 185.199.109.153   | 600 | type-1     |
| 2 | @      | CNAME | 默认 | daotoyi.github.io | 600 | type-2     |
|   | 二级域名 |       |      |                   |     |            |
| 3 | www    | CNAME | 默认 | daotoyi.github.io | 600 | 1+3 or 2+3 |
| 4 | jekyll | CNAME | 默认 | daotoyi.github.io | 600 |            |

CNAME 方法用/不用 www 都能访问网站（www 的方式，会先解析成<http://xxxx.github.io，然后根据cname再变成http//xxx.com%EF%BC%8C%E5%8D%B3%E4%B8%AD%E9%97%B4%E6%98%AF%E7%BB%8F%E8%BF%87%E4%B8%80%E6%AC%A1%E8%BD%AC%E6%8D%A2%E7%9A%84>）

-   ****绑定完成后的页面请求流程：****

访问 xxx.com，由于是 cname，会先找 xxxx.github.io(对应表中 3)，最后由主机记录@找到 ip 进行访问(表中对应 1 或者 2)

-   ****二级域名绑定(项目站点)****
    1.  (Source)在 仓库 settings 页面设置 GitHub Pages 托管分支
    2.  (Theme Chooser),必须选择一个主题(后期可以更改),\*\*否则可能无法加载\*\*.(手动无语)
    3.  (Custom domain),设置站点解析的二级域名.(如 jekyll.daotoyi.cn)[对应表格中 4]


## ssl {#ssl}

-   使用腾讯云域名片带 1 任何人 SSL 证书.
-   使用 cloudflare.
    -   cloudflare CDN 在国内没有 CDN 节点，但是整体效果是完爆 github.io
    -   要注意的是免费版本是有请求次数限制的，每天 10W 次.


## Firebase {#firebase}

Firebase 记录浏览量与点赞数.

Firebase[1] 是一个由谷歌开发的平台，它提供了多种工具和服务，包括：云端数据库、身份验证、数据分析、托管等功能，帮助开发人员更快、更方便地创建和运行应用程序。


## Cusdis {#cusdis}

Cusdis[3] 是 Disqus 的开源项目、轻量级（约 5kb gzip）、隐私友好的绝佳替代品，主要用于纯静态化网站。Cusdis 并非旨在成为 Disqus 的完整替代品。它的目的是为小型网站（例如您的静态博客）实现一个极简主义和可嵌入的评论系统。

优点：

-   Cusdis 是开源的并且可以自我托管
-   SDK 是轻量级的（~5kb gzipped）
-   **Cusdis 不需要用户登录即可发表评论，不使用 Cookie**

缺点：

-   没有垃圾邮件过滤必须手动审核评论，在批准之前不会显示评论（也可看作优点）


## ref {#ref}

-   [如何搭建零成本个人博客（二）](https://mp.weixin.qq.com/s/R3e21pacpoBwk4lq-au2ug)
+++
title = "Github-pages 托管静态网页绑定自定义域名"
date = 2022-02-07T08:29:00+08:00
lastmod = 2022-03-26T09:49:00+08:00
categories = ["Github"]
draft = false
+++

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
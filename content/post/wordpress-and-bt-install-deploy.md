+++
title = "WordPress 笔记"
date = 2022-03-15T22:26:00+08:00
lastmod = 2022-03-20T13:28:11+08:00
tags = ["WordPress"]
categories = ["VPS"]
draft = false
+++

## VPS Panel Compare {#vps-panel-compare}

-   最强大、最完善建站工具：WordPress (CMS)
-   最受初学者欢迎的建站工具：Wix
-   最设计优良的建站工具：Squarespace
-   最容易使用的建站工具：Weebly
-   最适合定制的建站工具：Duda
-   最适合电商的建站工具：Shopify
-   最好的免费建站工具：Google Sites (New)
-   最强大的页面自定义建站工具：Webflow
-   附带邮件营销功能的建站工具：Constant Contact Website Builder
-   最适合大型商店的建站工具：BigCommerce

{{< figure src="https://raw.githubusercontent.com/daotoyi/picsbed/main/img/202203141616408.png" >}}


## WordPress 3 types {#wordpress-3-types}

-   WordPress.com
    此平台由 WordPress.com 开发人员团队完全托管。换句话说，要使用此免费软件，您要做的就是注册一个帐户并开始发布内容。其他一切都为您处理。
-   高级 WordPress.com
    可以选择升级您的免费 WordPress.com 帐户。套餐的价格从每月 4 美元到 45 美元不等，并具有多种该更高级的功能。
-   WordPress.org
    此平台是自托管的，你可以从这个网站下载到 WordPress 安装包，然后自己购买域名和主机服务器。WordPress 程序是完全免费使用的，使用这种方法建站，您还要负责所有站点维护，包括软件更新、速度优化和站点安全等等，换句话来说，自由度非常大。


## Install {#install}


### 安装在虚拟机上 {#安装在虚拟机上}

-   [虚拟机建站](https://www.haah.net/collection/vm-station)
    -   [SSH 连接 Linux 安装宝塔面板](https://www.haah.net/archives/2681.html)
    -   [宝塔面板安装完的一些列操作](https://www.haah.net/archives/2728.html)
    -   [宝塔面板搭建服务器网站环境（超详细）](https://www.haah.net/archives/2746.html)
    -   [宝塔面板安装WordPress（超详细)](https://www.haah.net/archives/2815.html)


### 安装在云平台上 {#安装在云平台上}

-   参考安装在虚拟机即可


## Notes {#notes}

-   宝塔面板登陆地址为
    -   ip:port
    -   ip:port/xxxxxxxx
        -   xxxxxxxx:新装机器都会随机一个 8 位字符的安全入口名称
        -   可以在面板设置处修改
        -   查看面板入口：/etc/init.d/bt default
        -   【关闭安全入口】将使您的面板登录地址被直接暴露在互联网上，非常危险，请谨慎操作

-   WordPress 后台登录地址为
    -   ip/wp-admin/
    -   域名/wp-admin/
    -   例如：<http://192.168.91.130/wp-admin/> 或者<http://www.baidu.com/wp-admin/>

-   WordPress 首页地址为
    -   ip
    -   域名
    -   例如：<http://192.168.91.130/> 或者 <http://www.baidu.com/>

-   虚拟机安装 WP
    -   安装完成会生成一个外网访问地址和一个内网访问地址
    -   WP 的域名设置为 127.0.0.1,在主机上通过内网地址登陆访问.
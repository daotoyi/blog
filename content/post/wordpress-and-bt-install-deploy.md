+++
title = "WordPress 笔记"
date = 2022-03-15T22:26:00+08:00
lastmod = 2022-04-03T17:38:55+08:00
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


### 安装在 docker 上 {#安装在-docker-上}


#### install database {#install-database}

mariadb 是 mysql 的替代品,几乎兼容(mysql 被 orcal 收购后有商业化不开源的风险)

```bash
# mariadb
docker run --name wpdb --env MYSQL_ROOT_PASSWORD=wordpress -d mariadb
docker exec -it wpdb bash

# set password
# /# mysql -u root -p
# Enter password:
```


#### install wordpress {#install-wordpress}

```bash
# 1)使用官方的wordpress, 镜像is oud.io
docker pull daocloud.io/daocloud/dao-wordpress:latest

# 2)use wordpress官方镜像
docker pull wordpress

# startup
docker run --name WordPress --link wpdb:mysql -p 8080:80 -d wordpress

# http://localhost:8080（或 http://host-ip:8080） 访问站点
# http://ip:8080/wp-admin/install.php
```

-   使用外部数据库的话

<!--listend-->

```bash
$ docker run --name some-wordpress -e WORDPRESS_DB_HOST=10.1.2.3:3306  -e WORDPRESS_DB_USER=... -e WORDPRESS_DB_PASSWORD=... -d wordpress
```

> `WORDPRESS_DB_HOST` 数据库主机地址（默认为与其 link 的 mysql 容器的 IP 和 3306 端口：:3306）
> `WORDPRESS_DB_USER` 数据库用户名（默认为 root）
> `WORDPRESS_DB_PASSWORD` 数据库密码（默认为与其 link 的 mysql 容器提供的 MYSQL_ROOT_PASSWORD 变量的值）
> `WORDPRESS_DB_NAME` 数据库名（默认为 wordpress）
> `WORDPRESS_TABLE_PREFIX` 数据库表名前缀（默认为空，您可以从该变量覆盖 wp-config.php 中的配置）


#### docker compose {#docker-compose}

<!--list-separator-->

-  docker-compose.yml

    ```yaml
    version: '3.3'
    services:
       db:
         image: mysql:5.7
         volumes:
           - db_data:/var/lib/mysql
         restart: always
         environment:
           MYSQL_ROOT_PASSWORD: somewordpress
           MYSQL_DATABASE: wordpress
           MYSQL_USER: wordpress
           MYSQL_PASSWORD: wordpress
       wordpress:
         depends_on:
           - db
         image: wordpress:latest
         ports:
           - "8000:80"
         restart: always
         environment:
           WORDPRESS_DB_HOST: db:3306
           WORDPRESS_DB_USER: wordpress
           WORDPRESS_DB_PASSWORD: wordpress
           WORDPRESS_DB_NAME: wordpress
    volumes:
        db_data: {}
    ```

<!--list-separator-->

-  useage

    ```bash
    docker-compose up -d   # startup
    docker-compose -f docker-compose.wordpress.yml up -d #后台运行

    docker-compose down    # stop
    docker-compose -f docker-compose.wordpress.yml down #停止并删除服务
    ```

<!--list-separator-->

-  Note

    -   `docker-compose down`

    当 Docker 容器停止时，它也会被删除; 这就是 Docker 的设计工作方式。但是，您的 WordPress 文件和数据将被保留，因为 docker-compose.yml 文件已配置为为该数据创建持久命名卷。

    -   `docker-compose down --volumes`

    如果要删除此数据并从 WordPress 站点重新开始，可以将--volumes 标志添加到上一个命令。这将永久删除您到目前为止所做的 WordPress 帖子和自定义。


## Backup {#backup}

-   [最好的WordPress网站备份插件（2020版）](https://www.guoyuguang.com/best-wordpress-website-backup-plugins/)


## Notes {#notes}


### 宝塔面板登陆地址为 {#宝塔面板登陆地址为}

-   ip:port
-   ip:port/xxxxxxxx
    -   xxxxxxxx:新装机器都会随机一个 8 位字符的安全入口名称
    -   如: <http://192.168.220.149:8888/5996ef82/>
    -   可以在面板设置处修改
    -   查看面板入口：/etc/init.d/bt default
    -   【关闭安全入口】将使您的面板登录地址被直接暴露在互联网上，非常危险，请谨慎操作


### WordPress 后台登录地址为 {#wordpress-后台登录地址为}

-   ip/wp-admin/
-   域名/wp-admin/
-   例如：<http://192.168.220.149/wp-admin/> 或者<http://www.baidu.com/wp-admin/>


### 访问 WordPress {#访问-wordpress}

安装完成后,需要在宝塔面板的 "网站 - 默认站点"中选择站点,否则可能访问不成功.


### WordPress 首页地址为 {#wordpress-首页地址为}

-   ip
-   域名
-   例如：<http://192.168.220.149/> 或者 <http://www.baidu.com/>


### 虚拟机安装 WP {#虚拟机安装-wp}

-   安装完成会生成一个外网访问地址和一个内网访问地址
-   WP 的域名设置为 127.0.0.1,在主机上通过内网地址登陆访问.
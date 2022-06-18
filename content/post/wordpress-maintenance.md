---
title: "WorPress 运维"
date: "2022-05-23 10:29:00"
lastmod: "2022-06-13 07:42:13"
categories: ["VPS"]
draft: false
---

## 结构配置 {#结构配置}


### [wordpress目录文件结构](https://www.cnblogs.com/wxcbg/p/6005208.html) {#wordpress目录文件结构}

-   wp-admin/
    -   登陆 wordpress 后看到的界面，包括所有的后台文件
-   wp-content/
    -   包含所有的内容，包括插件 ， 主题和上传的内容
    -   Plugins 文件夹包含所有插件
    -   Uploads 文件夹，所有上传图片，视频和附件。
    -   languages 是关于语言的
-   wp-includes/
    -   包括持有的所有文件和库，是必要的 WordPress 管理，编辑和 JavaScript 库，CSS 和图像 fiels
-   wp-blog-header.php
    -   根据博客参数定义博客页面显示内容。
-   wp-config.php
    -   这是真正把 WordPress 连接到 MySQL 数据库的配置文件。


### [wo-config.php](https://www.ixuans.com/159.html) {#wo-config-dot-php}


### [zh-cn:将 WordPress 文件置于独立子目录](https://codex.wordpress.org/zh-cn:%E5%B0%86_WordPress_%E6%96%87%E4%BB%B6%E7%BD%AE%E4%BA%8E%E7%8B%AC%E7%AB%8B%E5%AD%90%E7%9B%AE%E5%BD%95) {#zh-cn-将-wordpress-文件置于独立子目录}


## [（迁移）更改WordPress网站URL地址](https://www.wbolt.com/wordpress-change-url.html) {#迁移-更改wordpress网站url地址}


### 通过管理仪表盘更改 WordPress URL {#通过管理仪表盘更改-wordpress-url}

-   设置 &gt; 常规
    -   WordPress 地址 (URL)：到达您网站的地址。
    -   站点地址 (URL)：您的 WordPress 核心文件的地址。


### 在 wp-config.php 文件中更改 {#在-wp-config-dot-php-文件中更改}

```php
define( 'WP_HOME', 'http://yoursiteurl.com' );
define( 'WP_SITEURL', 'http://yoursiteurl.com' );
```


### 直接在数据库中更改 {#直接在数据库中更改}

-   phpMyAdmin
-   site url 和 home 字段


### 使用 WP-CLI 更改 {#使用-wp-cli-更改}

-   [WP-CLI v2 – 通过终端管理WordPress](https://www.wbolt.com/wp-cli.html)

<!--listend-->

```bash
docker exec -it wordpress  sh

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

wp option update home 'https://metacover.tk' --allow-root
wp option update siteurl 'https://metacover.tk' --allow-root
```


### 更改 WordPress 登录 URL {#更改-wordpress-登录-url}

登录 URL 通常是您的域名，后跟/wp-admin 或/wp-login。但是可以将其更改为更简单的内容，以便为您的用户和客户提供更好的用户体验，或者为您的网站管理员打上烙印并删除对 WordPress 的明显引用。


###  {#d41d8c}


## [WordPress 安装主题、插件、更新时需要FTP的解决办法](https://www.wpcom.cn/tutorial/101.html) {#wordpress-安装主题-插件-更新时需要ftp的解决办法}


## [WordPress更新和安装插件是需要输入服务器的FTP登录凭证](https://blog.csdn.net/qq_36089184/article/details/90767231) {#wordpress更新和安装插件是需要输入服务器的ftp登录凭证}


### 第一种 修改属组 {#第一种-修改属组}

我当前使用的 WordPress 文件夹所在的路径是 Apache2 默认的路径，即：/var/www/html，所以执行以下两条命令即可：

```cfg
sudo chown-R www-data /var/www/html
sudo chmod-R 775 /var/www/html
```


### 第二种 {#第二种}

在 WordPress 的 wp-config.php 文件里加入下面代码，

```donf
define("FS_METHOD", "direct");
define("FS_CHMOD_DIR", 0777);
define("FS_CHMOD_FILE", 0777);
```


### 第三种 {#第三种}

把 apache2 的运行用户改为你的当前用户


### 第四种 {#第四种}

把你的当前用户添加到 www-data 用户组


## [如何修复WordPress提示“安装失败：无法创建目录”错误](https://www.wbolt.com/installation-failed-could-not-create-directory.html) {#如何修复wordpress提示-安装失败-无法创建目录-错误}


## [apache2 wordpress建站并设置https访问](http://fisherlee.github.io/2018-09-26/apache2-wp-https/) {#apache2-wordpress建站并设置https访问}


## Avatar {#avatar}


### [如何通过Gravatar设置WordPress博客头像](https://www.wbolt.com/how-to-set-avatar-for-wordpress.html) {#如何通过gravatar设置wordpress博客头像}


### [WordPress用户资料添加自定义用户头像功能](https://www.wpdaxue.com/wordpress-custom-avatar.html) {#wordpress用户资料添加自定义用户头像功能}


### [如何修改WordPress的用户默认头像？](http://tencent.yundashi168.com/593.html) {#如何修改wordpress的用户默认头像}


### Gravatar 头像不生效 {#gravatar-头像不生效}

-   注册的电子邮件地址不同-如果在 Gravatar 中注册的电子邮件地址和 WordPress 中设置的电子邮件地址不同，则无法显示 Gravatar 的头像。
-   设置了头像隐藏-如果你在 WordPress 仪表盘的“设置-讨论”中将头像显示的确认勾取消了，则头像也是不会显示的。
-   Gravatar 头像需要一定时间更新-如果你是才设置的 Gravatar 头像，则需要等 10 分服务器来更新数据。


## nginx 代理容器访问 wordpress 容器 {#nginx-代理容器访问-wordpress-容器}


### [Docker容器互访三种方式](https://www.cnblogs.com/shenh/p/9714547.html) {#docker容器互访三种方式}

-   方式一、虚拟 ip 访问
    -   重启 ip 可能会变化
-   方式二、link
    -   此方法对容器创建的顺序有要求，如果集群内部多个容器要互访，使用就不太方便。
    -   后续可能取消
-   方式三、创建 bridge 网络
    -   --network-alias 网络别名
    -   访问容器中服务  &lt;网络别名&gt;：&lt;服务端口号&gt;
    -   使用的是网络别名，可以不用顾虑 ip 是否变动，只要连接到 docker 内部 bright 网络即可互访
    -   bridge 也可以建立多个，隔离在不同的网段。


### nginx docker 访问 wordpress 实例 {#nginx-docker-访问-wordpress-实例}

-   docker-compose.yml

    ```yaml
    wordpress:
      depends_on:
    ​    - mariadb
      image: wordpress
      container_name: wordpress
      # ports:
        # - "8080:80"
      restart: always
      networks:
        wpnetwork:
          aliases:
    ​        - wpnet-wp
    ```
-   nginx.conf

    ```yaml
    location / {
        proxy_pass http://wpnet-wp:80/;
    }
    ```

    -   **<http://wpnet-wp:80/>** 对应 worpress 容器的网络别名

-   docker ps

    ```bash
    # docker ps
    CONTAINER ID   IMAGE           COMMAND                  CREATED        STATUS        PORTS                                       NAMES
    bc9b31361ad0   mariadb         "docker-entrypoint.s…"   10 hours ago   Up 10 hours   3306/tcp                                    mariadb
    a76c725b339d   wordpress       "docker-entrypoint.s…"   11 hours ago   Up 11 hours   80/tcp                                      wordpress
    dbe403beb021   nginx           "/docker-entrypoint.…"   11 hours ago   Up 11 hours   0.0.0.0:80->80/tcp, :::80->80/tcp           nginx
    ```

    -   mariadb, worpress 可 **不以映射外部端口** ，nginx 直接访问


### Ref {#ref}

[nginx反向代理访问其他容器](https://blog.csdn.net/qq_38234785/article/details/117283477)


## ERR_TOO_MANY_REDIRECTS  重定向的次数过多 {#err-too-many-redirects-重定向的次数过多}


### [How to Fix Error Too Many Redirects Issue in WordPress](https://www.wpbeginner.com/wp-tutorials/how-to-fix-error-too-many-redirects-issue-in-wordpress/) {#how-to-fix-error-too-many-redirects-issue-in-wordpress}


### [WordPress 网站使用 CloudFlare 后提示“将您重定向的次数过多” 的原因及解决办法](https://www.wpzhiku.com/wordpress-wang-zhan-shi-yong-cloudflare-hou-ti-shi-jiang-nin-chong-ding-xiang-de-ci-shu-guo-duo-de-yuan-yin-ji-jie-jue-ban-fa/) {#wordpress-网站使用-cloudflare-后提示-将您重定向的次数过多-的原因及解决办法}


### [WordPress网站开启https后台提示“将您重定向的次数过多”](https://www.wppop.com/wordpress-redirect-you-too-many-times-error-solution.html) {#wordpress网站开启https后台提示-将您重定向的次数过多}


### [wordpress网站重定向次数过多的解决方法](https://www.yuntue.com/post/33716.html) {#wordpress网站重定向次数过多的解决方法}


### [解决WordPress常见的的几种ERR_TOO_MANY_REDIRECTS 错误](https://www.hulingweb.cn/qxpp/xuexibiji/817.html) {#解决wordpress常见的的几种err-too-many-redirects-错误}


## wordpress 首页(<https://domain>)打不开，重定向到(<https://domain/home>) {#wordpress-首页--https-domain--打不开-重定向到--https-domain-home}


### apache2 {#apache2}


#### Redirect {#redirect}

```cfg
Redirect / http://www.domain2.com
RedirectMatch ^/(.*)$ http://www.domain2.com/$1

Redirect permanent / http://www.domain2.com
RedirectMatch permanent ^/(.*)$ http://www.domain2.com/$1
```


#### mod_rewrite 模块 {#mod-rewrite-模块}


### .htaccess {#dot-htaccess}

```nil
RewriteEngine On
RewriteCond  %{REQUEST_URI} ^/$
RewriteRule ^(.*)$ https://metacover.tk/home/ [L,R=301]
# RewriteRule  https://metacover.tk/ https://metacover.tk/home/
```


### Ref {#ref}

-   [通过重定向把子目录设置为网站根目录](https://www.xinyueseo.com/jianzhan/531.html)


## compose.yaml {#compose-dot-yaml}

-   networks
    -   db 和 wordpress 必须在同一个网络里
-   nginx
    -   访问 wordpress 的别名网络

-   compose.yml

<!--listend-->

```yaml
  networks:
  wpnetwork:
    name: wpnetwork
    driver: bridge
  wpstorenetwork:
    name: wpstorenetwork
    driver: bridge

services:

  nginx:
    image: nginx
    container_name: nginx
    restart: always
    ports:
      - 80:80
    volumes:
      - ./etc/cert:/etc/opt
      - ./etc/nginx:/etc/nginx
      - ./html:/root
    networks:
      - wpnetwork
      - wpstorenetwork

  wpstore-db:
     image: mariadb
     container_name: wpstore-db
     restart: always
     # ports:
       # - 3306:3306
     volumes:
       - ./metastore/wpstore-db:/var/lib/mysql
     networks:
       wpstorenetwork:
         aliases:
           - wpstorenetwork-mariadb
     environment:
       - xxxx

   wpstore:
     depends_on:
       - wpstore-db
     image: wordpress
     container_name: wpstore
     restart: always
     networks:
       # - wpstorenetwork
       wpstorenetwork:
         aliases:
           - wpstorenetwork-wordpress
     volumes:
       - ./utils:/root
       - ./etc/apache2:/etc/apache2
       - ./metastore/wpstore:/var/www/html
     environment:
       - xxxx
```

-   nginx.conf

<!--listend-->

```cfg
proxy_pass http://wpstorenetwork-wordpress:80/
proxy_pass http://wpetwork-wordpress:80/
```


## Note {#note}

-   **删除不用主题**
    -   反复安装各种主题导致[ERR_TOO_MANY_REDIRECTS](https://www.hulingweb.cn/qxpp/xuexibiji/817.html)
-   DNS 解析域名后，启动 wordpress docker 后安装：
    -   使用<http://damian/wp-admin> 安装时界面错位
    -   使用 <http://ip:port/wp-admin> 则会正常显示
-   **使用 <http://ip:port/wp-admin> 安装后，修改 home 和 siteurl 为 <http://damian/wp-admin>**
    -   修改为 domain 之后登录后台 domain/wpadmin 可能会报错（识别不到网络），刷新一下 dns 缓存（ipconfig/flushdns)或者用隐私的浏览器页面打开
-   WordPress 在 compose 文件中连接数据库
    -   environment 的 `WORDPRESS_DB_NAME` 放在最后，否则登录不了 wp-admin

<!--listend-->

```yaml
wpstore:
  depends_on:
      - wpstore-db
    image: wordpress
    container_name: wpstore
    restart: always
    networks:
      # - wpstorenetwork
      wpstorenetwork:
        aliases:
          - wpstorenetwork
    ports:
      - 8080:80
    volumes:
      - ./utils:/root
      # - ./etc/apache2:/etc/apache2
      - ./xxx/wpstore:/var/www/html
    environment:
      WORDPRESS_DB_HOST: wpstore-db:3306
      WORDPRESS_DB_USER: xxx
      WORDPRESS_DB_PASSWORD: xxx
      WORDPRESS_DB_NAME: xxx
```
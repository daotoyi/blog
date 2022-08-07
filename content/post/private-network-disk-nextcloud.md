---
title: "私有网盘 Nextcloud/ownCloud 和 Cloudreve"
date: "2022-07-23 20:31:00"
lastmod: "2022-07-25 07:40:24"
categories: ["VPS"]
draft: false
toc: true
---

## Cloudreve {#cloudreve}

-   国人开发的
-   支持使用七牛云存储、阿里云 OSS、又拍云、Amazon S3 等对象存储作为存储后端
-   也支持本地服务器、远程服务器和 OneDrive 等作为存储后端
-   也支持 aria2 离线下载。


## ownCloud/NextCloud {#owncloud-nextcloud}

-   NextCloud 是 OwnCloud 的一个分支
-   跨平台跨设备文件同步、共享、版本控制、团队协作等
-   覆盖了 Windows、Mac、Android、iOS、Linux 等各种平台，功能非常强大
    -   挂载国外的 Googledrive
-   不支持第三方国内云存储。


## NextCloud 安装 (docker) {#nextcloud-安装--docker}


### docker-compose {#docker-compose}

```yaml
version: '3.8'

networks:
  nextcloudnetwork:
    name: nextcloudnetwork
    driver: bridge

services:
  nextcloud-db:
    image: mariadb
    container_name: nextcloud-mariadb
    restart: always
    # ports:
      # - 3306:3306
    volumes:
      - ./nextcloud/nextcloud-mariadb:/var/lib/mysql
    networks:
      nextcloudnetwork:
        aliases:
          - nextcloudnetwork-mariadb
    environment:
      MYSQL_DATABASE: nextcloud
      MYSQL_ROOT_PASSWORD: root
      MYSQL_USER: xxxx
      MYSQL_PASSWORD: dynextcloudpass
      # SERVICE_TAGS: dev

  nextcloud:
    depends_on:
      - nextcloud-db
    image: nextcloud
    container_name: nextcloud
    ports:
      - "8081:80"
    restart: always
    networks:
      nextcloudnetwork:
        aliases:
          - nextcloudnetwork-nextcloud
    volumes:
      - ./nextcloud/nextcloud:/var/www/html
      - ./utils:/root
    environment:
      WORDPRESS_DB_HOST: nextcloud-db:3306
      WORDPRESS_DB_USER: xxxx
      WORDPRESS_DB_PASSWORD: dynextcloudpass
      WORDPRESS_DB_NAME: nextcloud
```

浏览器中输入 Host(<http://ip:port>)<http:172.16.254.xxx:8081> 即可访问 Nextcloud;

> 登录界面 MariaDB 的主机 Host 位置填入 **nextcloud-db:3306** or **nextcloudnetwork-mariadb:3306** 即可登录配置.


### 手动添加文件 {#手动添加文件}

虽然上传了文件，但是 ownCloud/Nextcloud 的数据库里并没有这个文件的信息。文件信息都被存储在数据库的 oc_filecache 表中,需要扫描一下.

```bash
files
  files:cleanup              #清楚文件缓存
  files:scan                 #重新扫描文件系统
  files:transfer-ownership   #将所有文件和文件夹都移动到另一个文件夹

files:scan [-p|--path="..."] [-q|--quiet] [-v|vv|vvv --verbose] [--all] [user_id1] ... [user_idN]

参数:
  user_id               #扫描所指定的用户（一个或多个，多个用户ID之间要使用空格分开）的所有文件

选项:
  --path                #限制扫描路径
  --all                 #扫描所有已知用户的所有文件
  --quiet               #不输出统计信息
  --verbose             #在扫描过程中显示正在处理的文件和目录
  --unscanned           #仅扫描以前未扫描过的文件
```

-   `file:scan`

<!--listend-->

```bash
# linux
sudo -u www-data php occ files:scan --all   #扫描所有用户的所有文件
sudo -u www-data php occ user:list          #列出所有用户
sudo -u www-data php occ files:scan --path="/ChengYe/files/Photos" #指向用户ChengYe的Photos文件夹
  # /files/ 是必须要加上的，不可忽略。

# docker
docker exec --user www-data  nextcloud(container) php occ files:scan --all
docker exec --user www-data  nextcloud php occ files:scan admin
docker exec -u www-data nextcloud php occ user:list          #列出所有用户
```


### Ref {#ref}

-   [docker-compose搭建nextcloud](https://www.cnblogs.com/javashare/p/16275003.html)
-   [OCC命令给ownCloud/Nextcloud手动添加文件](https://www.orgleaf.com/2400.html)
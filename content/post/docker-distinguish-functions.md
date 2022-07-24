---
title: "Docker 类似功能区分"
date: "2022-07-24 12:01:00"
lastmod: "2022-07-24 12:02:09"
categories: ["Docker"]
draft: false
---

## ports 和 expose {#ports-和-expose}

-   ports 用来把服务端口映射给宿主机，可以访问宿主机 IP 地址的人都可以访问 ports 映射出来的端口。
-   expose 用来把服务端口开放给其他服务使用，客户端服务可以通过 links 功能访问服务端服务的端口。


### ports {#ports}

```cfg
ports:
    - 80       # 将服务的80端口映射到宿主机的一个随机的端口上
    - 8080:80             # 映射到宿主机的端口
    - 10.16.1.1:8080:80   # 映射到宿主机的10.16.1.1的8080端口
```


### expose (Dockerfile or docker-compose) {#expose--dockerfile-or-docker-compose}

等效, 如果 Dockerfile 里面通过 EXPOSE 暴露了端口出来，那么在通过 docker-compose 创建的服务也会暴露这个端口出来。


## links 和 depends_on {#links-和-depends-on}


### example {#example}

通过 links 把 MySQL、Redis、MongoDB、Elasticsearch 四个服务建立了一套别名。然后又通过 depends_on 指定 maintain 服务依赖这四个服务。

```cfg
services:

  maintain:
    build:
      dockerfile: Dockerfile
      context: ./image/nginx1.20
    container_name: maintain
    image: nginx1.20
    links:
      - mysql:server_mysql
      - redis:server_redis
      - mongo:server_mongo
      - elasticsearch:server_es
    depends_on:
      - mysql
      - redis
      - mongo
      - elasticsearch
```


### depends_on {#depends-on}

表达服务之间的依赖性。

通过 depends_on 告诉 docker-compose 当前服务启动之前先要把 depends_on 指定的服务启动起来才行。


### links - **已弃用** {#links-已弃用}

links 的目的是把一个服务的名称在当前服务里面创建一个别名.

链接到另一个服务中的容器，并以与 depends_on 相同的方式表示服务之间的依赖关系.

```cfg
services:

  tomcat:
    image: tflinux_tomcat9.0
    links:
      - mysql:server_mysql
```


### extend - **已弃用** {#extend-已弃用}

使用 extends 字段扩展单个服务.


### 弃用 links {#弃用-links}

```cfg
web:
  links:
   - db
```

-   当启动 db 容器时会随机分配一个本地端口比如 32777 来连接容器 3306 端口，每一次修改或者重启容器都会改变该端口，使用 links 来保证每一次都能够连接数据库，而不需要知道具体端口是什么。
-   docker-compose 执行 V2 文件时会自动在容器间创建一个网络，每一个容器都能够立即通过名字来访问到另外的容器。
-   因此，不再需要 links，links 过去通常用来开始 db 容器和 web server 容器网络之间的通讯，但是这一步已经被 docker-compose 做了。


### Ref {#ref}

-   [docker-compose 中 links 和 depends_on 区别](https://einverne.github.io/post/2018/04/gtld-xyz.html)
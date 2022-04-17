+++
title = "Docker Compose"
date = 2022-04-04T08:31:00+08:00
lastmod = 2022-04-10T14:52:51+08:00
categories = ["Docker"]
draft = false
+++

## Ref {#ref}

-   [Fig项目介绍](http://www.dockerinfo.net/fig%e9%a1%b9%e7%9b%ae%e4%bb%8b%e7%bb%8d)
-   [Docker Compose 项目](http://www.dockerinfo.net/docker-compose-%e9%a1%b9%e7%9b%ae)


## Fig {#fig}


### introduction {#introduction}

Docker Compose 的前身是 Fig。

Fig 是一个基于 Docker 的 Python 工具，允许用户基于一个 YAML 文件定义多容器应用，从而可以使用 fig 命令行工具进行应用的部署。

内部实现上，Fig 会解析 YAML 文件，并通过 Docker API 进行应用的部署和管理。

在 2014 年，Docker 公司收购了 Orchard 公司，并将 Fig 更名为 Docker Compose。and Compose 向下兼容 Fig。


### install {#install}

```bash
# 方法一：
curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname
-s`-`uname -m` > /usr/local/bin/fig; chmod +x /usr/local/bin/fig

# 方法二：
yum install python-pip python-dev
pip install -U fig
```


### useage {#useage}

```bash

fig up      # 启动
fig up -d   # 启动并后台运行
fig stop    # 停止
fig logs    # 查看日志
fig port    # 查看端口
fig --version
pip uninstall fig  # 卸载Fig:
```


## Compose {#compose}


### introduction {#introduction}

Docker Compose 并不是通过脚本和各种冗长的 docker 命令来将应用组件组织起来，而是通过一个声明式的配置文件描述整个应用，从而使用一条命令完成部署。

Compose 中有两个重要的概念：

-   服务 ( service )：⼀个应⽤的容器，实际上可以包括若⼲运⾏相同镜像的容器实例
-   项⽬ ( project )：由⼀组关联的应⽤容器组成的⼀个完整业务单元，在 docker-compose.yml⽂件中定义


### install {#install}

install via python-pip tool.

```bash
apt install python-pip
pip install -U docker-compose
docker-compose --version
```


### commands {#commands}

```cfg
docker-compose 命令 --help                     获得一个命令的帮助
docker-compose version
docker-compose up -d nginx                     构建启动 nignx 容器
docker-compose exec nginx bash                 登录到 nginx 容器中
docker-compose down                            此命令将会停止 up 命令所启动的容器，并移除网络
docker-compose ps                              列出项目中目前的所有容器
docker-compose restart nginx                   重新启动 nginx 容器
docker-compose build nginx                     构建镜像
docker-compose build --no-cache nginx          不带缓存的构建
docker-compose top                             查看各个服务容器内运行的进程
docker-compose logs -f nginx                   查看 nginx 的实时日志
docker-compose images                          列出 Compose 文件包含的镜像
docker-compose config                          验证文件配置，当配置正确时，不输出任何内容，当文件配置错误，输出错误信息。
docker-compose events --json nginx             以 json 的形式输出 nginx 的 docker 日志
docker-compose pause nginx                     暂停 nignx 容器
docker-compose unpause nginx                   恢复 ningx 容器
docker-compose rm nginx                        删除容器（删除前必须关闭容器，执行 stop）
docker-compose stop nginx                      停止 nignx 容器
docker-compose start nginx                     启动 nignx 容器
docker-compose restart nginx                   重启项目中的 nignx 容器
docker-compose run --no-deps --rm php-fpm php -v   在 php-fpm 中不启动关联容器，并容器执行 php -v 执行完成后删除容器
```


## compose tamplate {#compose-tamplate}


### instance(example) {#instance--example}


#### 需求 {#需求}

一个项目需要用 docker 部署 mysql,并且 mysql 的 项目数据库名：mproject,帐号：mao,密码为 mao123,端口为：33307


#### 方法 {#方法}

mysql 默认帐号为 root,常用两种方案新增用户修改密码:

-   方式一：在容器启动时通过初始化 sql 新增用户名 mao 和密码 mao123
-   方式二：在容器启动之后进入 mysql,新增用户名 mao 和密码 mao123
-   recommend [compose tamplate](#compose-tamplate)


### example {#example}

```yaml
version: "3"
services:
  mysql:
   image: mysql:8.0
   ports:
     - 33307:3306                             #将外部端口33307映射为内部默认创建的3306
   volumes:
     - ./data/mysql:/var/lib/mysql            #将容器中运行的mysql数据保存到宿主机，防止容器删除后数据丢失
     - ./init:/docker-entrypoint-initdb.d/    #/docker-entrypoint-initdb.d/这是数据库提供的初始化目录，数据库在启动时会默认执行当期目录下的以.sql或者.sh结尾的文件。
   environment:
     MYSQL_ROOT_PASSWORD: root                #数据库初始话为root用户设置的默认密码
     MYSQL_DATABASE: mproject                 #数据库名
     MYSQL_USER: mao                          #自定义数据库的用户，权限只作用于MYSQL_DATABASE配置的数据库
     MYSQL_PASSWORD: mao123                   #自定义数据库的用户，权限只作用于MYSQL_DATABASE配置的数据库
   restart: on-failure                    	  #重启条件
   networks:
    - my_pro
networks:
  my_pro:
    driver: bridge
    ipam:
      config:
        - subnet: 192.168.0.0/16   			#配置子网
```
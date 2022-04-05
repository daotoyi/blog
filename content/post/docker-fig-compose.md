+++
title = "Docker Compose"
date = 2022-04-04T08:31:00+08:00
lastmod = 2022-04-04T08:33:39+08:00
categories = ["Docker"]
draft = false
+++

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


### instance(example) {#instance--example}


#### 需求 {#需求}

一个项目需要用 docker 部署 mysql,并且 mysql 的 项目数据库名：mproject,帐号：mao,密码为 mao123,端口为：33307


#### 方法 {#方法}

mysql 默认帐号为 root,常用两种方案新增用户修改密码:

-   方式一：在容器启动时通过初始化 sql 新增用户名 mao 和密码 mao123
-   方式二：在容器启动之后进入 mysql,新增用户名 mao 和密码 mao123
-   recommend [compose tamplate](#compose-tamplate)


### compose tamplate {#compose-tamplate}


#### example {#example}

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


#### compose parameter: {#compose-parameter}

| parame         | note                                                        |
|----------------|-------------------------------------------------------------|
| version        | 指定 compose 文件的版本                                     |
| services       | 定义所有的 service 信息                                     |
| build          | 指定 Dockerfile 所在文件夹的路径                            |
| cap_add        | 让容器拥有内核的某项能力                                    |
| cap_drop       | 去掉容器内核的某项能力                                      |
| command        | 覆盖容器启动后默认执行的命令                                |
| cgroup_parent  | 指定父 cgroup 组，意味着将继承该组的资源限制                |
| container_name | 指定容器名称。默认将会使用 项目名称_服务名称_序号 这样的格式 |
| devices        | 指定设备映射关系                                            |
| depends_on     | 解决容器的依赖、启动先后的问题(服务不会等待依赖容器完全启动之后才启动) |
| dns            | 自定义 DNS 服务器。可以是一个值，也可以是一个列表           |
| dns_search     | 配置 DNS 搜索域。可以是一个值，也可以是一个列表             |
| tmpfs          | 挂载一个 tmpfs 文件系统到容器                               |
| env_file       | 从文件中获取环境变量, 可为单独的文件路径或列表(如有变量名称与 environment 指令冲突则以后者为准) |
| environment    | 设置环境变量。可使用数组或字典两种格式                      |
| expose         | 暴露端口，但不映射到宿主机，只被连接的服务访问              |
| external_links | 链接到 docker-compose.yml 外部的容器，甚至并非 Compose 管理的外部容器 |
| extra_hosts    | 类似 Docker 中的 --add-host 参数，指定额外的 host 名称映射信息 |
| healthcheck    | 通过命令检查容器是否健康运行                                |
| image          | 指定为镜像名称或镜像 ID(如果镜像在本地不存在，Compose 将会尝试拉取这个镜像) |
| logging        | 配置日志选项, 目前支持三种日志驱动类型(json-file、syslog 和 none) |
| network        | 设置网络模式                                                |
| networks       | 配置容器连接的网络                                          |
| pid            | 跟主机系统共享进程命名空间。容器和宿主机系统之间可以通过进程 ID 来相互访问和操作 |
| ports          | 暴露端口信息                                                |
| secrets        | 存储敏感数据，例如 mysql 服务密码                           |
| security_opt   | 指定容器模板标签（label）机制的默认属性（用户、角色、类型、级别等） |
| stop_signal    | 设置另一个信号来停止容器。在默认情况下使用的是 SIGTERM 停止容器 |
| volumes        | 数据卷所挂载路径设置, 可以设置为宿主机路径或者数据卷名称    |
| restart        | 指定容器退出后的重启策略为始终重启, 保持服务始终运行, 推荐配置为 always 或者 unless-stopped |
| working_dir    | 指定容器中工作目录                                          |

注: 每个服务都必须通过 image 指令指定镜像或 build 指令（需要 Dockerfile）等来自动构建生成镜像


#### read variable {#read-variable}

Compose 模板文件支持动态读取主机的系统环境变量和当前目录下的 .env 文件中的变量,若当前目录存在 .env 文件，执行 docker-compose 命令时将从该文件中读取变量.

such as: `.env`

```cfg
  # 支持 # 号注释
MYSQL_IMAGE = mysql:latest
MYSQL_ROOT_PASSWOR = 123456
```

docker-copose read env-variable

```cfg
version: "3 "
services:
  mysql_db:
    image: ${MYSQL_IMAGE}
  environment:
      - MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
```


#### Ref {#ref}

-   [docker-compose模板文件详解](https://blog.csdn.net/weixin_43507959/article/details/105903454)


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


## Notes {#notes}


### 脚本控制 {#脚本控制}

```bash
# 关闭所有正在运行容器
docker ps | awk  '{print $1}' | xargs docker stop

# 删除所有容器应用
docker ps -a | awk  '{print $1}' | xargs docker rm
```


### 映射 {#映射}


#### port 端口 {#port-端口}

`宿主机端口:容器端口`


#### volumns 挂载卷 {#volumns-挂载卷}

`宿主机路径:容器路径`

```yaml
volumes:
  # 只需指定一个路径，让引擎创建一个卷
  - /var/lib/mysql

  # 指定绝对路径映射
  - /opt/data:/var/lib/mysql

  # 相对于当前compose文件的相对路径
  - ./cache:/tmp/cache

  # 用户家目录相对路径
  - ~/configs:/etc/configs/:ro

  # 命名卷
  - datavolume:/var/lib/mysql
```
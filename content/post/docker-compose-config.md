---
title: "Docker Compose config"
date: "2022-04-10 14:22:00"
lastmod: "2022-04-30 12:25:03"
categories: ["Docker"]
draft: false
---

## compose parameter: {#compose-parameter}

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


## compose para annotation {#compose-para-annotation}

Compose 和 Docker 兼容性：
Compose 文件格式有 3 个版本,分别为 1, 2.x 和 3.x
目前主流的为 3.x 其支持 docker 1.13.0 及其以上的版本

常用参数：

```cfg
version           # 指定 compose 文件的版本
services          # 定义所有的 service 信息, services 下面的第一级别的 key 既是一个 service 的名称
    build                 # 指定包含构建上下文的路径, 或作为一个对象，该对象具有 context 和指定的 dockerfile 文件以及 args 参数值
        context               # context: 指定 Dockerfile 文件所在的路径
        dockerfile            # dockerfile: 指定 context 指定的目录下面的 Dockerfile 的名称(默认为 Dockerfile)
        args                  # args: Dockerfile 在 build 过程中需要的参数 (等同于 docker container build --build-arg 的作用)
        cache_from            # v3.2中新增的参数, 指定缓存的镜像列表 (等同于 docker container build --cache_from 的作用)
        labels                # v3.3中新增的参数, 设置镜像的元数据 (等同于 docker container build --labels 的作用)
        shm_size              # v3.5中新增的参数, 设置容器 /dev/shm 分区的大小 (等同于 docker container build --shm-size 的作用)

    command               # 覆盖容器启动后默认执行的命令, 支持 shell 格式和 [] 格式
    configs               # 不知道怎么用
    cgroup_parent         # 不知道怎么用
    container_name        # 指定容器的名称 (等同于 docker run --name 的作用)

    credential_spec       # 不知道怎么用
    deploy                # v3 版本以上, 指定与部署和运行服务相关的配置, deploy 部分是 docker stack 使用的, docker stack 依赖 docker swarm
        endpoint_mode         # v3.3 版本中新增的功能, 指定服务暴露的方式
            vip                   # Docker 为该服务分配了一个虚拟 IP(VIP), 作为客户端的访问服务的地址
            dnsrr                 # DNS轮询, Docker 为该服务设置 DNS 条目, 使得服务名称的 DNS 查询返回一个 IP 地址列表, 客户端直接访问其中的一个地址
        labels                # 指定服务的标签，这些标签仅在服务上设置
        mode                  # 指定 deploy 的模式
            global                # 每个集群节点都只有一个容器
            replicated            # 用户可以指定集群中容器的数量(默认)
        placement             # 不知道怎么用
        replicas              # deploy 的 mode 为 replicated 时, 指定容器副本的数量
        resources             # 资源限制
            limits                # 设置容器的资源限制
                cpus: "0.5"           # 设置该容器最多只能使用 50% 的 CPU
                memory: 50M           # 设置该容器最多只能使用 50M 的内存空间
            reservations          # 设置为容器预留的系统资源(随时可用)
                cpus: "0.2"           # 为该容器保留 20% 的 CPU
                memory: 20M           # 为该容器保留 20M 的内存空间
        restart_policy        # 定义容器重启策略, 用于代替 restart 参数
            condition             # 定义容器重启策略(接受三个参数)
                none                  # 不尝试重启
                on-failure            # 只有当容器内部应用程序出现问题才会重启
                any                   # 无论如何都会尝试重启(默认)
            delay                 # 尝试重启的间隔时间(默认为 0s)
            max_attempts          # 尝试重启次数(默认一直尝试重启)
            window                # 检查重启是否成功之前的等待时间(即如果容器启动了, 隔多少秒之后去检测容器是否正常, 默认 0s)
        update_config         # 用于配置滚动更新配置
            parallelism           # 一次性更新的容器数量
            delay                 # 更新一组容器之间的间隔时间
            failure_action        # 定义更新失败的策略
                continue              # 继续更新
                rollback              # 回滚更新
                pause                 # 暂停更新(默认)
            monitor               # 每次更新后的持续时间以监视更新是否失败(单位: ns|us|ms|s|m|h) (默认为0)
            max_failure_ratio     # 回滚期间容忍的失败率(默认值为0)
            order                 # v3.4 版本中新增的参数, 回滚期间的操作顺序
                stop-first            #旧任务在启动新任务之前停止(默认)
                start-first           #首先启动新任务, 并且正在运行的任务暂时重叠
        rollback_config       # v3.7 版本中新增的参数, 用于定义在 update_config 更新失败的回滚策略
            parallelism           # 一次回滚的容器数, 如果设置为0, 则所有容器同时回滚
            delay                 # 每个组回滚之间的时间间隔(默认为0)
            failure_action        # 定义回滚失败的策略
                continue              # 继续回滚
                pause                 # 暂停回滚
            monitor               # 每次回滚任务后的持续时间以监视失败(单位: ns|us|ms|s|m|h) (默认为0)
            max_failure_ratio     # 回滚期间容忍的失败率(默认值0)
            order                 # 回滚期间的操作顺序
                stop-first            # 旧任务在启动新任务之前停止(默认)
                start-first           # 首先启动新任务, 并且正在运行的任务暂时重叠

        # 注意： 支持 docker-compose up 和 docker-compose run 但不支持 docker stack deploy 的子选项
            security_opt  container_name  devices  tmpfs  stop_signal  links    cgroup_parent
            network_mode  external_links  restart  build  userns_mode  sysctls

    devices               # 指定设备映射列表 (等同于 docker run --device 的作用)
    depends_on            # 定义容器启动顺序 (此选项解决了容器之间的依赖关系， 此选项在 v3 版本中 使用 swarm 部署时将忽略该选项)
```


## compose {#compose}


### read variable {#read-variable}

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


### Ref {#ref}

-   [docker-compose模板文件详解](https://blog.csdn.net/weixin_43507959/article/details/105903454)


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
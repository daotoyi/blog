---
title: "Docker Dockerfile"
date: "2022-04-05 15:32:00"
lastmod: "2022-05-13 08:41:35"
categories: ["Docker"]
draft: false
---

## Ref {#ref}

-   [Dockerfile介绍](http://www.dockerinfo.net/dockerfile%e4%bb%8b%e7%bb%8d)
-   [Docker 容器入门](https://www.cnblogs.com/clsn/p/8410309.html)


## structure {#structure}

Dockerfile 分为四部分：

-   基础镜像信息
-   维护者信息
-   镜像操作指令
-   容器启动时执行指令


## config {#config}

```cfg
# This dockerfile uses the ubuntu image
# VERSION 2 - EDITION 1
# Author: docker_user
# Command format: Instruction [arguments / command] ..

# Base image to use, this must be set as the first line
FROM ubuntu

# Maintainer: docker_user <docker_user at email.com> (@docker_user)
MAINTAINER docker_user docker_user@email.com

# Commands to update the image
RUN echo "deb http://archive.ubuntu.com/ubuntu/ raring main universe" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Commands when creating a new container
CMD /usr/sbin/nginx
```


## build {#build}

配置好 `.dockerfile` 文件后:

```bash
# docker image build  -t image .
docker build  -t ImageName:TagName dir

docker build github.com/creack/docker-firefox
```

-   -f - 指定构建镜像的 Dockerfile 文件（Dockerfile 可不在当前路径下）
    -   如果不使用 -f，则默认将上下文路径下的名为 Dockerfile 的文件认为是构建镜像的 "Dockerfile"
-   -t - 为镜像添加标签
-   ImageName - 这是要为镜像命名的名称。
-   TagName - 这是要为镜像提供的标签。
-   Dir - Docker 文件所在的目录。
    -   构建镜像的过程中，可以且只可以引用上下文中的任何文件


## network {#network}

| 类型      | 说明                                                       |
|---------|----------------------------------------------------------|
| None      | 不为容器配置任何网络功能，没有网络 --net=none              |
| Container | 与另一个运行中的容器共享 Network Namespace，--net=container:containerID |
| Host      | 与主机共享 Network Namespace，--net=host                   |
| Bridge    | Docker 设计的 NAT 网络模型（默认类型）                     |

Bridge 默认 docker 网络隔离基于网络命名空间，在物理机上创建 docker 容器时会为每一个 docker 容器分配网络命名空间，并且把容器 IP 桥接到物理机的虚拟网桥上。

```bash
docker network list
```


## Copy-on-Write {#copy-on-write}

实际上，Docker Hub 中 99% 的镜像都是通过在 base 镜像中安装和配置需要的软件构建出来的。

镜像分层最大的一个好处就是共享资源。

比如说有多个镜像都从相同的 base 镜像构建而来，那么 Docker Host 只需在磁盘上保存一份 base 镜像；同时内存中也只需加载一份 base 镜像，就可以为所有容器服务了。而且镜像的每一层都可以被共享。

{{< figure src="https://images2017.cnblogs.com/blog/1190037/201802/1190037-20180203180355656-1765414705.png" >}}


## note {#note}


### RUN &amp; CMD {#run-and-cmd}


#### RUN {#run}

-   RUN &lt;command&gt; : 将在 shell 终端中运行命令，
    -   即 /bin/sh -c
-   RUN ["executable", "param1", "param2"]： 使用 exec 执行
    -   如 RUN ["/bin/bash", "-c", "echo hello"]，


#### CMD {#cmd}

-   CMD ["executable","param1","param2"] ： 使用 exec 执行，推荐方式
-   CMD command param1 param2 ： 在 /bin/sh 中执行，提供给需要交互的应用；

指定启动容器时执行的命令，每个 Dockerfile 只能有一条 CMD 命令。如果指定了多条命令，只有最后一条会被执行。


#### diff {#diff}


### WORKDIR {#workdir}

为后续的 RUN、CMD、ENTRYPOINT 指令配置工作目录.

可以使用多个 WORKDIR 指令，后续命令如果参数是相对路径，则会基于之前命令指定的路径。

```cfg
WORKDIR /a
WORKDIR b
WORKDIR c
RUN pwd
```

则最终路径为 /a/b/c
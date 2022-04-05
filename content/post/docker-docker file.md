+++
title = "Docker Dockerfile"
lastmod = 2022-04-05T15:24:03+08:00
categories = ["Docker"]
draft = true
+++

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
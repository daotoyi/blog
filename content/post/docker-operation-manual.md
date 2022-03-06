+++
title = "Docker 使用镜像"
date = 2022-02-27T11:53:00+08:00
lastmod = 2022-03-03T22:36:36+08:00
categories = ["Docker"]
draft = false
+++

-   State "DONE"       from              <span class="timestamp-wrapper"><span class="timestamp">[2022-02-27 周日 11:53]</span></span>

Docker 容器（containers）是从 Docker 镜像生成出来的。默认情况下，Docker 从 [Docker Hub](https://hub.docker.com/) 下载这些镜像，Docker 公司在运营这个 Docker Hub。

任何人都可以在 Docker Hub 上托管自己的 Docker 镜像。因此，我们大多数需要的应用程序和 Linux 发行版都能在这里找到。

检查是否可以访问 Docker Hub 和从这个网站下载镜像, `docker run hello-world`

执行此命令时，Docker 首先在本地查找 hello-world，如没有，它会从 Docker Hub（默认版本库）下载了该镜像。下载镜像后，Docker 会根据镜像创建一个容器，并执行该容器中的应用程序。


## images {#images}

```shell
docker search ubuntu
docker pull ubuntu
docker images         # 查看已下载到计算机的镜像

docker run -it ubuntu # 使用-i -t 这两个参数，可以通过 shell 来

root@7896ef8f403f:/#  # 执行命令后，提示符会变为你正在使用镜像的容器id
```


## operate {#operate}

```shell
docker ps
docker ps -a
docker ps -l     # 查看最后创建的容器
docker start ID/容器名
docker stop  ID/容器名
docker rm        # delete container_id
docker rmi Imga  # delete image
docker exec -it name[/id] /bin/sh[/bash]
```
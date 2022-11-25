---
title: "Docker 使用镜像"
date: "2022-02-27 11:53:00"
lastmod: "2022-11-05 10:42:25"
categories: ["Docker"]
draft: false
---

-   State "DONE"       from              <span class="timestamp-wrapper"><span class="timestamp">[2022-02-27 周日 11:53]</span></span>


## basic {#basic}

Docker 容器（containers）是从 Docker 镜像生成出来的。默认情况下，Docker 从 [Docker Hub](https://hub.docker.com/) 下载这些镜像，Docker 公司在运营这个 Docker Hub。

任何人都可以在 Docker Hub 上托管自己的 Docker 镜像。因此，我们大多数需要的应用程序和 Linux 发行版都能在这里找到。

检查是否可以访问 Docker Hub 和从这个网站下载镜像, `docker run hello-world`

执行此命令时，Docker 首先在本地查找 hello-world，如没有，它会从 Docker Hub（默认版本库）下载了该镜像。下载镜像后，Docker 会根据镜像创建一个容器，并执行该容器中的应用程序。


## images {#images}

```shell
docker search ubuntu
docker pull ubuntu

docker images         # 查看已下载到计算机的镜像
docker image list

docker rmi image  # delete image
docker image rm image

docker image inspect ngin  # 查看镜像的详细信息

docker save ID > xxx.tar

#保存/导入镜像
docker save image_id > xxx.tar
docker save image_name > xxx.tar
docker save -o xxx.tar image_name

docker load < xxx.tar
docker load --input xxx.tar

docker run -it ubuntu # 使用-i -t 这两个参数，可以通过 shell 来

root@7896ef8f403f:/#  # 执行命令后，提示符会变为你正在使用镜像的容器id
```


## container {#container}

```bash

# 保存导入容器
docker export container_id >xxx.tar
docker import xxx.tar containr:v1

# 然后再
docker run -it containr:v1 bash
```


## operate {#operate}

```shell
# 给普通用户增加使用docker的权限
sudo usermod -aG docker $USER

docker ps
docker ps -a
docker ps -l     # 查看最后创建的容器

docker start ID/容器名
docker stop  ID/容器名

docker rm        # delete container_id
docker rm -f  `docker ps -a -q` # delete all

docker attach name[/id]
docker exec -it name[/id] /bin/sh[/bash]
ctrl+p & ctrl+q   # exit

docker volume ls
```
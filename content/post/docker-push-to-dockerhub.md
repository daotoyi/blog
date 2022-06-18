---
title: "Docker 提交推送"
date: "2022-02-27 11:53:00"
lastmod: "2022-05-02 22:54:52"
categories: ["Docker"]
draft: false
---

-   State "DONE"       from              <span class="timestamp-wrapper"><span class="timestamp">[2022-02-27 周日 11:53]</span></span>


## Docker commit {#docker-commit}

```shell
docker commit -m "What you did to the image" -a "Author Name" container_id repository/new_image_name

# docker commit -m 'dyQuant image linux' -a 'daotoyi' xxxx daotoyi/dypython
```

-   -m 是提交镜像的备注
-   -a 用于指定作者名
-   container_id ( `docker ps -a` 显示的 `CONTAINER ID`)

当我们提交新镜像时，新生成的镜像也会在我们的计算机上本地保存


## Docker tag {#docker-tag}

```bash
➜ docker images
# REPOSITORY         TAG       IMAGE ID       CREATED          SIZE
# daotoyi/dypython   latest    03d7caa6e12b   18 minutes ago   1.26GB

docker tag IMAGEID(镜像id) REPOSITORY:TAG（仓库：标签）
# docker tag 03d7caa6e12b daotoyi/dypython:linux
# docker tag daotoyi/dypython:latest daotoyi/dypython:linux
```

打标签，会重新生成一个镜像，但是 IMAGE ID 不变。


## Docker push {#docker-push}

```shell

# 要推送镜像，请首先登录 Docker Hub
docker login -u docker-registry-username

# 推送镜像到 Docker hub
docker push docker-registry-username/docker-image-name
# docker push daotoyi/dypython

# 推送到 kalacloud 的版本库
docker push kalacloud/ubuntu-nodejs
```
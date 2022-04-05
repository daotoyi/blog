+++
title = "Docker 提交推送"
date = 2022-02-27T11:53:00+08:00
lastmod = 2022-04-05T16:36:46+08:00
categories = ["Docker"]
draft = false
+++

-   State "DONE"       from              <span class="timestamp-wrapper"><span class="timestamp">[2022-02-27 周日 11:53]</span></span>


## Docker commit {#docker-commit}

```shell
docker commit -m "What you did to the image" -a "Author Name" container_id repository/new_image_name
```

-   -m 是提交镜像的备注
-   -a 用于指定作者名
-   container_id 是 Docker Hub 用户名

当我们提交新镜像时，新生成的镜像也会在我们的计算机上本地保存


## Docker push {#docker-push}

```shell

# 要推送镜像，请首先登录 Docker Hub
docker login -u docker-registry-username

# 推送镜像到 Docker hub
docker push docker-registry-username/docker-image-name

# 推送到 kalacloud 的版本库
docker push kalacloud/ubuntu-nodejs
```
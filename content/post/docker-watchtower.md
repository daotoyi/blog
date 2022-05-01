---
title: "Docker Watchtower"
date: "2022-04-04 08:30:00"
lastmod: "2022-04-30 12:25:05"
categories: ["Docker"]
draft: false
---

## instroduction {#instroduction}

Watchtower 会监视运行容器并监视这些容器最初启动时的镜像是否需要更新。

当 watchtower 检测到一个镜像已经有变动时，它会使用新镜像，使用相同的参数自动重新启动相应的容器。

同时 watchtower 本身也被打包为 Docker 镜像，用一行命令即可使用 watchtower 监控所有容器，然后所有容器都会自动更新，当然也包括 watch­tower 本身。


## install &amp; useage {#install-and-useage}

```bash
$ docker pull containrrr/watchtower

$ docker run -d \
  --name watchtower \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower
```

因为 watchtower 需要与 Docker API 进行交互以监控正在运行的容器，所以在使用时需要加上 -v 参数将 /var/run/docker.sock 映射到容器内。


### compose {#compose}

以下该文件从 Docker Hub 的私有仓库启动 Docker 容器，并使用 watchtower 对其进行监控。

```yaml
version: "3"
services:
  cavo:
    image: index.docker.io/<org>/<image>:<tag>
    ports:
      - "443:3443"
      - "80:3080"
  watchtower:
    image: containrrr/watchtower
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /root/.docker/config.json:/config.json
      command: --interval 30
```


### update specific container {#update-specific-container}

```bash
$ docker run -d \
  --name watchtower \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  nginx redis  # 只监视名为“nginx”和“redis”的容器
```


### other {#other}

-   --cleanup 参数在更新后自动删除旧的镜像
-   --monitor-only 将仅监控新镜像并发送通知，不会更新容器
-   --interval 设置设更新检测时间间隔，单位为秒。
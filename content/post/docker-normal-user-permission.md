---
title: "Docker 普通用户使用"
date: "2022-10-28 13:40:00"
lastmod: "2022-10-28 13:40:42"
categories: ["Docker"]
draft: false
---

## 问题 {#问题}

```text
docker: Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/create: dial unix /var/run/docker.sock: connect: permission denied.
```

这主要是因为 Docker 进程使用 Unix Socket，而 /var/run/docker.sock 需要 root 权限才能进行读写操作。


## 方案 {#方案}

使用 root 权限创建一个 docker 组，并将普通用户加入到该组中，然后刷新一下 docker 组使其修改生效即可：

```bash
sudo groupadd docker			    # 有则不用创建
sudo usermod -aG docker USER	# USER 为加入 docker 组的用户
newgrp docker					        # 刷新 docker 组
docker run hello-world			  # 测试无 root 权限能否使用 docker
```
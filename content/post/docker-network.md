---
title: "Docker Network"
date: "2022-06-25 18:30:00"
lastmod: "2022-06-25 18:31:01"
categories: ["Docker"]
draft: false
---

## 容器间网络互通 {#容器间网络互通}

-   容器间要能相互通信，需要同在一个网络中。
-   docker 容器在创建时若不指定网络驱动时会默认归属到 bridge 网络。
-   使用 docker inspect 指令查看两个容器是否同属一个 network，如果不是，使用 docker network 将两个容器连接起来，使他们在同一个网络 network 里即可。

<!--listend-->

```bash
# 查看docker 网络:
docker network ls

# 首先创建一个网络：
docker network create networkName

#将容器连到创建的网络中（每个容器都要连到这个网络里）：
docker network connect networkName containerName

# 查看网络内的容器信息：
docker network inspect networkName

#可以在运行容器时直接指定连接network：
docker run --network networkName imageName
```
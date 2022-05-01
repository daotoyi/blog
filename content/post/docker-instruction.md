---
title: "Docker 初识"
date: "2022-02-27 11:53:00"
lastmod: "2022-04-30 12:24:27"
categories: ["Docker"]
draft: false
---

-   State "DONE"       from              <span class="timestamp-wrapper"><span class="timestamp">[2022-02-27 周日 11:53]</span></span>

[Docker](https://www.docker.com/) 是一个开源的应用容器引擎。Docker 可以让开发者打包他们创建的应用以及相应的依赖包到一个可移植、轻量级的容器中。Docker 可大大简化在容器中管理应用程序的过程。容器使用沙盒机制，运行在其中的应用与主系统相互分离，类似与虚拟机。但容器比虚拟机有更棒的可移植性、占用计算机资源更小。


## Docker 镜像 {#docker-镜像}

最大的文件通常是镜像。如果使用默认的 overlay2 存储驱动，Docker 镜像会保存在 /var/lib/docker/overlay2 目录


## 基本概念 {#基本概念}

从 Docker 下载下来的叫镜像（ images ）

使用 docker run 运行起来的镜像（ images ）叫容器（ containers ）


## reference {#reference}

[Docker 入门指南：如何在 Ubuntu 上安装和使用 Docker](https://kalacloud.com/blog/how-to-install-and-use-docker-on-ubuntu/)
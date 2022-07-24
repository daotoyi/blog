---
title: "Docker 初识"
date: "2022-02-27 11:53:00"
lastmod: "2022-07-23 06:37:45"
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


## Docker (容器) 的原理 {#docker--容器--的原理}

简单来说，就是使用 Linux 的 overlayfs[3], overlay file system 可以做到，将两个 file system merge  在一起，下层的文件系统只读，上层的文件系统可写。

如果去读文件，找到上层就读上层的，否则的话就找到下层的去读。

Docker 运行的时候，从最下层的文件系统开始，merge 两层，得到新的 fs 然后再 merge 上一层，然后再 merge 最上一层，最后得到最终的 directory，然后用 chroot[4] 改变进程的 root 目录，启动 container。

Docker image 其实就是一个 tar 包[5]。一般来说我们通过 Dockerfile 用 docker built 命令来构建，但是其实也可以用其他工具构建，只要构建出来的 image 符合 Docker 的规范[6]，就可以运行。


## reference {#reference}

[Docker 入门指南：如何在 Ubuntu 上安装和使用 Docker](https://kalacloud.com/blog/how-to-install-and-use-docker-on-ubuntu/)
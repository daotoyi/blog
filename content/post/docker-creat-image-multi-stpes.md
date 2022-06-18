---
title: "Docker 多阶段构建目标镜像"
description: "多阶段构建压缩镜像体积"
lastmod: "2022-05-13 10:25:14"
categories: ["Docker"]
draft: true
---

## 简介 {#简介}

先构建一个大而全的镜像，然后只把镜像中有用的部分拿出来，放在一个新的镜像里。


## 应用 {#应用}

创建 pytyon 环境镜像，pip 只在构建镜像的过程中需要，而对运行我们的程序却一点用处也没有。我们只需要安装 pip，再用 pip 安装第三方库，然后将第三方库从这个镜像中复制到一个只有 python，没有 pip 的镜像中，这样，pip 占用的 268MB 空间就可以被节省出来了。


## 过程 {#过程}


### 在 ubuntu 镜像的基础上安装 python {#在-ubuntu-镜像的基础上安装-python}

```bash
FROM ubuntu
RUN apt update \
    && apt install python3

#生成了python:3.8-ubuntu镜像
docker build -t python:3.8-ubuntu .
```


### 在 python:3.8-ubuntu 的基础上安装 pip {#在-python-3-dot-8-ubuntu-的基础上安装-pip}

```bash
FROM python:3.8-ubuntu
RUN apt install python3

#生成了python:3.8-ubuntu-pip镜像
docker build -t python:3.8-ubuntu-pip .
```


### 多阶段构建目标镜像 {#多阶段构建目标镜像}

```bash
FROM python:3.8-ubuntu-pip
RUN pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple numpy
FROM python:3.8-ubuntu
COPY --from=0 /usr/local/lib/python3.8/dist-packages/ /usr/local/lib/python3.8/dist-packages/

# 项目的最终镜像
docker build -t project:1.0 .
```

第二个 FROM 是以 FROM python:3.8-ubuntu 镜像为基础，将第三方库统统复制过来，COPY 命令后的–from=0 的意思是从第 0 阶段进行复制


## 导入镜像到生产环境 {#导入镜像到生产环境}

```bash
# 保存的文件是一个.tar格式的压缩文件
docker save -o hello.tar hello:1.0

docker load -i hello.tar
```
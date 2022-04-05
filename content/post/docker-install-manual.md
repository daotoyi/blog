+++
title = "Docker 安装"
date = 2022-02-27T11:53:00+08:00
lastmod = 2022-03-28T23:45:36+08:00
categories = ["Docker"]
draft = false
+++

官方 Ubuntu 存储库中提供的 Docker 安装软件包可能不是最新版本，为了保证是最新版，我们从 Docker 官方库来安装。


## Ubuntu {#ubuntu}

```sh

# 将官方 Docker 版本库的 GPG 密钥添加到系统中
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# 将 Docker 版本库添加到APT源：
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

sudo apt update

# 确保要从 Docker 版本库，而不是默认的 Ubuntu 版本库进行安装：
apt-cache policy docker-ce

sudo apt install docker-ce

sudo systemctl status docker
```


## Redhat {#redhat}

```bash
# yum-utils提供yum-config-manager工具
yum install -y yum-utils

#
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# 安装社区版本
yum install -y docker-ce

systemctl start docker

#　移除docker
yum remove docker-ce

# 移除镜像，容器，卷，网络，自定义文件等
rm -rf /var/lib/docker
```
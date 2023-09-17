---
title: "Docker 安装"
date: "2022-02-27 11:53:00"
lastmod: "2023-09-08 08:01:56"
categories: ["Docker"]
draft: false
---

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


## Almalinux {#almalinux}

Red Hat Enterprise Linux 不提供对 Docker 的本机支持，AlmaLinux 也不提供，因为它是 RHEL 的一个分支。相反，红帽推动了对 Podman 的支持，Podman 是 Docker 的替代品。

```bash
# 包更新到最新版本
dnf -y update
# reboot

# 移除冲突包
dnf remove podman buildah

# 将 Docker CE 存储库添加到您的 AlmaLinux / Rocky Linux 8 系统
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

# 确认
dnf repolist

# 安装Docker CE
dnf -y install docker-ce docker-ce-cli containerd.io

# systemctl start/enable docker
```
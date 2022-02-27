+++
title = "Docker 安装"
lastmod = 2022-02-27T11:31:01+08:00
categories = ["Docker"]
draft = false
+++

官方 Ubuntu 存储库中提供的 Docker 安装软件包可能不是最新版本，为了保证是最新版，我们从 Docker 官方库来安装。

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
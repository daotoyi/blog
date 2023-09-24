---
title: "Linux debian sid source"
date: "2023-09-23 12:17:00"
lastmod: "2023-09-23 12:17:32"
categories: ["Linux"]
draft: false
---

## 简述 {#简述}

Debian sid 其实严格意义上不是一个正式的发行版，它更像一个 Debian 发行版的滚动开发版本，包含引入 Debian 系统中的最新的软件包。一般都是一些硬派开发者或测试者才会使用这个版本。他的软件包及其的新，相应的这些软件包有可能不稳定。


## 使用 {#使用}

安装好后会获得一个正常的 Debian 系统，此时只需要修改软件源就可以将系统转为 Debian sid 系统。

使用管理员权限修改 /etc/apt/sources.list 文件。将文件中的内容全部删去，修改为：

```shell
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ sid main contrib non-free
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ sid main contrib non-free
```

由于 sid 中的软件包足够新，所以并不需要 updates、backports 和 security 这三个软件源。

然后使用命令： `sudo apt update` `sudo apt upgrade` 即可更新系统，并将系统转变为 Debian sid。


## 注意 {#注意}

需要知道的是，使用 Debian sid，其实是在参与 Debian 的开发。这意味着你应该了解 Linux、Debian 和 Debian 打包系统的方方面面，而且你应当对跟踪、修复漏洞持有兴趣。
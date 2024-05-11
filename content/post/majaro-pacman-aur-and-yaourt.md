---
title: "Manjaro pacman、aur and yaourt(yay)"
author: ["SHI WENHUA"]
date: "2024-04-20 20:28:00"
lastmod: "2024-04-20 20:35:09"
tags: ["manjaro"]
categories: ["Linux"]
draft: false
---

## pacman {#pacman}

-   Pacman 在 Arch wiki 的说明如下

> pacman 软件包管理器是 Arch Linux 的一大亮点。它将一个简单的二进制包格式和易用的构建系统结合了起来(参见 makepkg 和 ABS)。不管软件包是来自官方的 Arch 库还是用户自己创建，pacman 都能方便地管理。


## AUR(Arch User Repository) {#aur--arch-user-repository}

> Arch 用户软件仓库（Arch User Repository，AUR）是为用户而建、由用户主导的 Arch 软件仓库。AUR 中的软件包以软件包生成脚本（PKGBUILD）的形式提供，用户自己通过 makepkg 生成包，再由 pacman 安装。创建 AUR 的初衷是方便用户维护和分享新软件包，并由官方定期从中挑选软件包进入 community 仓库。本文介绍用户访问和使用 AUR 的方法。

一般来说，安装 AUR 的软件包没有 Pacman -S 那么方便，用户需要在 AUR 中下载软件包生成脚本（PKGBUILD 和其他相关文件），然后使用 makepkg 生成包，再用 pacman 安装，PKGBUILD 里面包含了源码等生成软件包需要的内容，但还需要用户自行构建软件包。


## AUR 工具 {#aur-工具}

AUR 工具就像 AUR 上的 Pacman，他也可以通过一个简单的命令来帮你安装 AUR 上面的软件包。 比较流行的 AUR 工具有：

-   yaourt(已经停止维护)
-   yay
-   aurman

+++
title = "CMD yum/dnf/pacman"
date = 2022-03-30T18:49:00+08:00
lastmod = 2022-03-31T22:55:02+08:00
categories = ["Linux"]
draft = false
+++

## yum {#yum}

```bash
yum check-update     # 列出所有可更新的软件清单命令：
yum update           # 更新所有软件命令：
yum install <package_name> # 仅安装指定的软件命令：
yum update <package_name>  # 仅更新指定的软件命令：
yum list             # 列出所有可安裝的软件清单命令：
yum remove <package_name>  # 删除软件包命令：
yum search <keyword>  # 查找软件包命令：

# 清除缓存命令:
yum clean packages  # 清除缓存目录下的软件包
yum clean headers   # 清除缓存目录下的 headers
yum clean oldheaders # 清除缓存目录下旧的 headers
yum clean, yum clean all
```


## dnf {#dnf}

在 RHEL8 中把软件源分成了两部分一个是 BaseOS,一个是 AppStream.
在 Red Hat Enterprise Linux 8.0 中，统一的 ISO 自动加载 BaseOS 和 AppStream 安装源存储库。

存储库介绍:

1.  BaseOS 存储库旨在提供一套核心的底层操作系统的功能，为基础软件安装库
2.  AppStream 存储库中包括额外的用户空间应用程序、运行时语言和数据库，以支持不同的工作负载和用例。AppStream 中的内容有两种格式——熟悉的 RPM 格式和称为模块的 RPM 格式扩展。

DNF(Dandified Yum)是新一代的 RPM 软件包管理器。

DNF 使用 RPM,libsolv 和 hawkey 库进行包管理操作，DNF 包管理器克服了 YUM 包管理器的一些瓶颈，提升了包括用户体验，内存占用，依赖分析，运行速度等多方面的内容。

```bash
# 先安装并启用 epel-release 依赖
yum install epel-release
yum install dnf
dnf –version

dnf repolist  # 显示系统中可用的 DNF 软件库
dnf repolist all    #  显示系统中可用和不可用的所有的 DNF 软件库
dnf list            # 列出所有 RPM 包
dnf list installed  # 列出所有安装了的 RPM 包
dnf list available  # 所有可供安装的 RPM 包

dnf search nano
dnf provides /bin/bash  # 查找某一文件的提供者

dnf info nano
dnf install xxxx
dnf update  xxxx

dnf check-update   # 检查系统软件包的更新
dnf update or dnf upgrade # 升级所有系统软件包

dnf remove nano or dnf erase nano # 删除软件包
dnf autoremove     # 删除无用孤立的软件包
dnf clean all      # 删除缓存的无用软件包

dnf history
```


## pacman {#pacman}

`/etc/pacman.conf`


### 1、更新系统 {#1-更新系统}

```bash
pacman -Syy					#本地的包数据库和远程的软件仓库同步
pacman -Syu

pacman -Su # 如果你已经使用 pacman -Sy 将本地的包数据库与远程的仓库进行了同步，也可以只执行：
```


### 2、安装包 {#2-安装包}

```bash
pacman -S 包名    # 例如，执行 pacman -S firefox ,也可以同时安装多个包，以空格分隔包名即可。
pacman -Sy 包名   # 与上面命令不同的是，该命令将在同步包数据库后再执行安装。
pacman -Sv 包名   # 在显示一些操作信息后执行安装。
pacman -U 安装本地包 # 其扩展名为 pkg.tar.gz。
```


### 3、删除包 {#3-删除包}

```bash
pacman -R 包名   # 该命令将只删除包，不包含该包的依赖。
pacman -Rs 包名  # 在删除包的同时，也将删除其依赖。
pacman -Rd 包名  # 在删除包时不检查依赖。
pacman -Rsc 包名 # 删除一个包,所有依赖
```


### 4、搜索包 {#4-搜索包}

```bash
pacman -Ss 关键字 # 这将搜索含关键字的包。
pacman -Qi 包名   # 查看有关包的信息。
pacman -Ql 包名   # 列出该包的文件。
pacman -Qo 包名   # 列出该包被哪个包包含
```


### 5、其他用法 {#5-其他用法}

```bash
pacman -Sw 包名 #只下载包，不安装。
pacman -Sc Pacman # 下载的包文件位于 /var/cache/pacman/pkg/ 目录。该命令将清理未安装的包文件
pacman -Scc # 清理所有的缓存文件。
```
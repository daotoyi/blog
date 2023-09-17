---
title: "Window 系统分区"
date: "2023-08-25 12:20:00"
lastmod: "2023-08-25 12:20:28"
categories: ["Windows"]
draft: false
---

## 文件系统 {#文件系统}

文件系统是系统对文件的存放排列方式，不同格式的文件系统关系到数据是如何在磁盘进行存储，文件名、文件权限和其他属性也存在不同。

Windows 操作系统支持 NTFS, FAT32, and exFAT 三种不同文件系统。


## 格式比较 {#格式比较}


### Fat32 {#fat32}

是一种通用格式，任何 USB 存储设备都会预装该文件系统，可以在任何操作系统平台上使用。

最主要的缺陷是只支持最大单文件大小容量为 4GB。不能像 NTFS 格式支持很多现代文件格式的属性，但对于不同系统平台具有良好的兼容性，可以在 Linux、Mac 或 Android 系统平台上通用。


### exFAT {#exfat}

微软自家创建的用来取代 FAT32 文件格式的新型文件格式，它最大可以支持 1EB 的文件大小，非常适合用来存储大容量文件，还可以在 Mac 和 Windows 操作系统上通用。

最大的缺点是没有文件日志功能，这样就不能记录磁盘上文件的修改记录。


### NTFS {#ntfs}

微软为硬盘或固态硬盘（SSD）创建的默认新型文件系统，NTFS 的含义是 New Technology File System。它集成了所有文件系统的优点：日志功能、无文件大小限制、支持文件压缩和长文件名、服务器文件管理权限等。

最大的缺点是 Mac 系统只能读取 NTFS 文件但没有权限写入，需要借助第三方工具才能实现。


## U 盘模式 {#u-盘模式}


### USB-HDD 模式 {#usb-hdd-模式}

USB-HDD 硬盘仿真模式，此模式兼容性很高，适用于新机型，但对于一些只支持 USB-ZIP 模式的电脑则无法启动，一般制作 U 盘启动盘选择该模式。


### USB-ZIP 模式 {#usb-zip-模式}

大容量软盘仿真模式，此模式在一些比较老的电脑上是唯一可选的模式，但对大部分新电脑来说兼容性不好，特别是 2GB 以上的大容量 U 盘。


## linux 挂载 {#linux-挂载}


### exFAT {#exfat}

Linux 默认情况下不支持 exFAT 文件系统。但是，你可以通过安装 exFAT 文件系统驱动来使 Linux 支持 exFAT。

```bash
# ubuntu
sudo apt-get update
sudo apt-get install exfat-fuse exfat-utils

# centos
yum install epel-release -y
rpm -Uvh http://download1.rpmfusion.org/free/el/rpmfusion-free-release-6.noarch.rpm （cenots6）
rpm -Uvh http://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm （cenots7）

yum install fuse-exfat exfat-utils -y
mount.exfat /dev/sdb1 /mnt/ 或
mount -t exfat /dev/sdb1 /media/
```


### NTFS {#ntfs}

```bash
# download & comlile
http://www.tuxera.com/community/ntfs-3g-download/

wget http://tuxera.com/opensource/ntfs-3g_ntfsprogs-2014.2.15.tgz
tar xvf ntfs-3g_ntfsprogs-2014.2.15.tgz -C /root/tools
cd /root/tools/ntfs-3g_ntfsprogs-2014.2.15/

./configure && make && make install

# install
yum install ntfs-3g-devel ntfsprogs-devel -y
```
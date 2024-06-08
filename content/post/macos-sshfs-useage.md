---
title: "macOS sshfs 使用"
author: ["SHI WENHUA"]
date: "2024-05-19 19:01:00"
lastmod: "2024-05-29 06:37:19"
categories: ["macOS"]
draft: false
---

## SSHFS {#sshfs}

SSHFS（SSH Filesystem）是一个基于 FUSE 的文件系统客户端，用于通过 SSH 连接远程目录。SSHFS 使用的是 SFTP 协议，它是 SSH 的一个子系统，在大多数 SSH 服务器上默认启用.

与其他网络文件系统（如 NFS 和 Samba）相比，SSHFS 的优势在于它不需要在服务器端进行任何额外的配置。要使用 SSHFS，您只需要 SSH 访问远程服务器。


## macOS sshfs {#macos-sshfs}

```bash
brew install --cask macfuse
brew install gromgit/fuse/sshfs-mac
```

```bash
installer: Error - The FUSE for macOS installation package is not compatible with this version of macOS.
```

-   参考
    1.  [macFUSE](https://github.com/macfuse/macfuse/wiki/Getting-Started)
    2.  [M1/M2/M3芯片 Mac 在“恢复”模式中启用系统扩展教程](https://www.52mac.com/soft/13613-1-1.html)


## Window10 sshfs {#window10-sshfs}

需要安装最新版本的 WinFsp 和 SSHFS-Win，

-   WinFsp 下载地址：<https://github.com/billziss-gh/winfsp/releases/>
-   SSHFS-Win 下载地址：<https://github.com/billziss-gh/>


### 添加挂载 {#添加挂载}

右键此电脑 - 映射网络驱动器。

-   默认添加的远程目录是用户的家目录
    -   \\\sshfs\root@192.xx.xx.xx
-   远程挂载根目录
    -   \\\sshfs.r\root@192.xx.xx.xx
    -   {{< figure src="https://pic4.zhimg.com/80/v2-10e2c11aa5a5765531285111e452e5df_1440w.webp" >}}


## 使用 {#使用}


### SHFS 使用格式 {#shfs-使用格式}

`sshfs [user@]host:[dir] mountpoint [options]` 。如果没有指定远程目录，默认会连接用户的家目录。


### 开机自动挂载 {#开机自动挂载}

可以在/etc/fstab 文件中添加：

> [root@localhost ~]# echo 'root@192.168.0.105:/Shares /mnt fuse.sshfs defaults 0 0'&gt;&gt; /etc/fstab

前提是需要设置无密码登录，不然开机不能挂载。


### 卸载远程文件系统 {#卸载远程文件系统}

```bash
[root@localhost ~]# fusermount -u /mnt/
# 或者
[root@localhost ~]# umount /mnt
```


## 参考 {#参考}

-   [SSHFS Mac 挂载 Centos 远程文件系统](https://cloud.tencent.com/developer/article/2412921)
-   [使用SSHFS文件系统远程挂载目录](https://zhuanlan.zhihu.com/p/260231900)
-   [mac 通过 sshfs 挂载远程 Linux 文件系统](https://blog.gensh.me/mac-mount-remote-fs-via-sshfs)(编译方式）

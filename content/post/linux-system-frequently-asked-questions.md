---
title: "Linux System FAQ"
date: "2022-08-01 14:00:00"
lastmod: "2023-11-07 14:00:07"
tags: ["FAQ"]
categories: ["Linux"]
draft: false
---

## FAT32 格式 u 盘只读 {#fat32-格式-u-盘只读}


### 背景 {#背景}

> [ 1456.424000] FAT-fs (sdc4)： error, fat_free_clusters: deleting FAT entry beyond EOF


### 分析 {#分析}

通过分析日志和内核代码，当检测到文件系统异常时，会进行错误处理，默认是 remount readonly， 也就是当文件系统错误时，重新挂载文件系统，这样导致只读。


### 解决 {#解决}

文件系统报错无法避免，只能通过 mount 参数规避，防止出现 readonly 问题。 **在挂载参数中修改 errors 处理**.


#### 方法一 {#方法一}

在 mount 命令中加入 remount 参数,(修改/etc/fstab 文件)

> errors 取值： panic|continue|remount-ro （默认是 rmount-ro）
>
> mount 时将参数指定为 continue 即可,如:
> mount -t vfat /dev/sda /mnt/sda -o errors=continue


#### 方法二 {#方法二}

格式化 u 盘为 ext2 格式

> 在内核菜单项中加入了 ext2 的支持，采取静态模式，编译后更新内核。
> \#mkfs.ext2 /dev/sda1


### Ref {#ref}

-   [如何解决FAT文件系统出现readonly的问题](https://blog.csdn.net/dxt1107/article/details/106936862)
-   @Windows [cmd chkdsk]


## 修改显示时间为 UTC 格式 {#修改显示时间为-utc-格式}

```bash
rm /etc/localtime
ln -s /usr/share/zoneinfo/Universal /etc/localtime
```
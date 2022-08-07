---
title: "Windows chkdsk"
lastmod: "2022-08-04 09:24:37"
categories: ["Windows"]
draft: false
---

## 简介 {#简介}

chkdsk 的全称是 checkdisk，就是磁盘检查的意思。

是一种 Windows 内置的实用程序，可以检查硬盘文件系统的完整性，并可以修复 FAT16、FAT32 和 NTFS 硬盘上的各种文件系统错误。

当你的系统当掉或者非法关机的时候由系统来调用检查磁盘的，也可以由手工通过命令行调用来检查某一个磁盘分区。

该工具基于被检测的分区所用的文件系统，创建和显示磁盘的状态报告。Chkdsk 还会列出并纠正磁盘上的错误。如果不带任何参数，chkdsk 将显示当前驱动器中的磁盘状态。


## 参数 {#参数}

> CHKDSK [volume[[path]filename]]] [/F] [/V] [/R] [/X] [/I] [/C] [/L[:size]]
>
> volume 指定驱动器(后面跟一个冒号)、装入点 或卷名。
> filename 仅用于 FAT/FAT32: 指定要检查是否有碎片的文件。
> /F 修复磁盘上的错误。
> /V 在 FAT/FAT32 上: 显示磁盘上每个文件的完整路径和名称。 在 NTFS 上: 如果有清除消息，将其显示。
> /R 查找不正确的扇区并恢复可读信息(隐含 /F)。
> /L:size 仅用于 NTFS: 将日志文件大小改成指定的 KB 数。 如果没有指定大小，则显示当前的大小。
> /X 如果必要，强制卷先卸下。 卷的所有打开的句柄就会无效(隐含 /F)。
> /I 仅用于 NTFS: 对索引项进行强度较小的检查。
> /C 仅用于 NTFS: 跳过文件夹结构的循环检查。
> /I 和 /C 命令行开关跳过卷的某些检查，减少运行 Chkdsk 所需的时间。


## 使用 {#使用}


### 从命令提示符运行磁盘检查命令 {#从命令提示符运行磁盘检查命令}

```bat
chkdsk k: /f
```


### 从分区属性运行检查磁盘 {#从分区属性运行检查磁盘}

{{< figure src="https://www.disktool.cn/assets/images6540/other/check-file-system-error.png" >}}


### 使用免费分区软件启动 chkdsk.exe 工具（推荐） {#使用免费分区软件启动-chkdsk-dot-exe-工具-推荐}

{{< figure src="https://www.disktool.cn/assets/images6540/check-partition/check-partition.png" >}}


### Ref {#ref}

[在Windows中使用磁盘修复命令CHKDSK检查并修复磁盘错误](https://www.disktool.cn/content-center/command-prompt-check-disk-6540.html)


## 应用 {#应用}

使用 u 制作的 linux 启动系统，在宿主机突然断电后， u 盘系统异常。

> 参考 @Linux [Linux system FAQ] - FAT32 格式 u 盘只读:
> 当检测到文件系统异常时，会进行错误处理，默认是 remount readonly， 也就是当文件系统错误时，重新挂载文件系统，这样导致只读。

```bash
[ 1456.424000] FAT-fs (sdb4): error, fat_free_clusters: deleting FAT entry beyond EOF
[ 1456.440000] FAT-fs (sdb4): Filesystem has been set read-only
```

在运行一些 shell 时报错, 是因为以上原因导致系统文件损坏。文件被截断。

```bash
/bin/sh: Syntax error: Unterminated quoted string
```

在更换文件时，一些文件大小为 0，且无法被删除。可使用 windows chdsk 检查修复，之后 u 盘恢复正常。

```bat
chkdsk k: #只检查不修复
chkdsk k: /f
```
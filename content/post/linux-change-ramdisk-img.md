---
title: "Linux 修改 Ramdisk 镜像重新制作"
date: "2023-12-17 21:30:00"
lastmod: "2023-12-26 19:11:23"
categories: ["Linux"]
draft: false
---

## 说明 {#说明}

通过 cpio 命令解压 ramddisk 解压系统后重新打包制作镜像。


## 步骤 {#步骤}

```bash
# 查看文件格式
➜ file initrd.img
initrd.img: XZ compressed data, checksum CRC32

# 修改文件名，并解压
➜ mv initrd.img initrd.img.xz
➜ xz -d -k initrd.img.xz

# cpio解压系统
➜ mkdir rootfs && cd rootfs
➜ cpio -ivd < ../initrd.img

# 修改之后重新打包、压缩（rootfs/)
➜ find . | cpio -o -H newc > ../rootfs.cpio
➜ cd ..
# ➜ xz -z -k initrd.img.cpio #生成的ramdisk启动异常
➜ xz -9 -C crc32 -c  rootfs.cpio >  rootfs.cpio.xz
➜ ls
rootfs.img.cpio.xz
➜ mv rootfs.img.cpio rootfs.img
```


## 备注 {#备注}

```bash
##  xz
xz -z filenaem  #compress #-k 保留被压缩的文件
tar -Jcf linux-3.12.tar.xz linux-3.12/

xz -d filenaem	-k #-k 保留被压缩的文件
tar -Jxf linux-3.12.tar.xz

##  gzip
gzip –c filename > filename.gz
gunzip –d -k filename.gz #-k 保留被压缩的文件

unzip -n test.zip -d /tmp #	不覆盖原先的文件
unzip -o test.zip -d tmp/ #覆盖原先的文件
unzip -v test.zip		  # 查看不解压
unzip test.zip			  # 解压在当前目录下
```
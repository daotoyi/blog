---
title: "syslinux 简单使用"
date: "2024-01-12 22:22:00"
lastmod: "2024-01-12 22:22:19"
categories: ["Tools"]
draft: false
---

## 简介 {#简介}

Syslinux 是一个功能强大的引导加载程序, 可以装在 U 盘上来引导系统

-   5.00 版本以前，几乎所有 c32 模块是独立的，即没有其他模块依赖；
-   但在 5.00 以后，很多 c32 模块则是依赖于其他模块


## 安装 {#安装}

-   格式化 U 盘为 fat32 格式
-   U 盘根目录建立 boot/syslinux 目录
-   安装 sysliux 引导

    ```bat
    V4.05: ~\win32>syslinux.exe -ma -d \boot\syslinux H:
    V6.03: ~\bios\win32>syslinux.exe --mbr --active --directory /boot/syslinux/ --install H:
    ```

    -   将在/boot/syslinux 目录下生成启动系统文件 ldlinux.sys
-   syslinux-xxx\bios 文件夹里搜索如何文件(对于 6.03 需要找到对应的依赖库)

    ```cfg
    memdisk             引导IMG镜像文件
    menu.c32            窗口模块
    vesamenu.c32        窗口模块
    chain.c32           指定分区(硬盘)启动
    reboot.c32          重新启动计算机
    poweroff.c32        关闭计算机
    ```


## 配置 {#配置}

```cfg
# WinPE
LABEL Winpe
MENU LABEL Winpe
  kernel /boot/isope.bin
  append initrd=/boot/SETUPLDR.BIN

# Linux
LABEL linux
MENU LABEL Puppy linux
  kernel /boot/linux/vmlinuz
  append initrd=/boot/syslinux/initrd.gz

# 硬盘
LABEL StartHD
  MENU LABEL StartHD
  COM32 /boot/syslinux/chain.c32 hd0

# 关闭系统
LABEL Poweroff
    MENU LABEL Poweroff
    COM32 /boot/syslinux/poweroff.c32

# 重启系统
LABEL reboot
  MENU LABEL Reboot
  COM32 /boot/syslinux/reboot.c32

# 磁盘镜像引导
# syslinux支持gzip或zip压缩格式的(memdisk)，标准floppy镜像可直接引导启动，非标准(容量大于2880K)要附加CHS参数
# 其中，CHS参数可通过软件GDParam来获取
LABEL maxdos
  kernel memdisk
  append initrd=boot/maxdos.img floppy c=555 h=2 s=18

# ISO光盘

LABEL WIN7PE.iso
  LINUX memdisk
  INITRD /boot/wins/WIN7PE.iso
  APPEND iso raw

# LiveCD
LABEL CentOS
    MENU LABLE CentOS
    kernel /boot/CentOS/vmlinuz0
    append initrd=/boot/CentOS/initrd0.img root=UUID=4C9E-56D3 rootfstype=vfat rw quiet liveimg SQUASHED="/sysroot/boot/CentOS/squashfs.img"
```


## 参考 {#参考}

-   [Syslinux使用](https://www.cnblogs.com/hzl6255/p/3341374.html)
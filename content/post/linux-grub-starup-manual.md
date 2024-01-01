---
title: "Linux Grub 手动启动 linux"
date: "2023-12-29 08:35:00"
lastmod: "2023-12-29 08:35:59"
categories: ["Linux"]
draft: false
---

## 普通场景 {#普通场景}

「BIOS」+「MBR」+「普通的磁盘分区」

```bash
#1 查看所有分区
grub> ls

#2 查看分区下的内容
grub> ls (hd0,1)/

#3 设置根分区及启动盘
grub> set root=(hd0,1)
grub> linux /boot/vmlinuz-3.13.0-29-generic root=/dev/sda1
grub> initrd /boot/initrd.img-3.13.0-29-generic
grub> boot
```


## 引导 iso 启动 {#引导-iso-启动}

```bash
# 查询所有已安装磁盘并打印详细信息
grub>ls -l

# 设置根目录分区
grub>set root=(hd0,1)

# 将Ubuntu.iso位置赋值给变量isofile
grub>set isofile=/ubuntu-18.04-desktop-amd64.iso

# 使用grub2的回放技术，把ubuntu.iso的文件内容，投射（挂载）到loop上。
# 在使用这个命令时，得考虑你的内存足够的大。(hd0,1)iso镜像文件所在分区
grub>loopback loop (hd0,1)$isofile

# 加载内核，其中(loop),是使用了上一句所投射的设备，其访问的是ubuntu.iso文件的内容
# boot=casper将目录casper挂载为boot，
# iso-scan/filename=$isofile 是利用iso-scan来寻找到ubuntu.iso文件所在位置并把所找到的iso文件挂到光驱设备
grub>linux (loop)/casper/vmlinuz boot=casper iso-scan/filename=$isofile quiet splash

# initrid.lz是一个镜象文件，里面存的是一些内核要加载的重要文件
grub>initrd (loop)/casper/initrd.lz

#根据上面的参数启动系统
grub>boot
```


## uefi 模式下引导 windows {#uefi-模式下引导-windows}

```bash
#加载ntfs文件系统
grub>insmod ntfs
grub>set root=(hd0,1)
grub>chainloader +1 # 引导传统bios启动的Windows
#如果不成功则可能是efi，换个目录如：bootmgfw.efi-->bootx64.efi
grub>chainloader /EFI/boot/bootx64.efi
```


## bios 模式下引导 windows {#bios-模式下引导-windows}

```bash
grub>set root=(hd0,1)
# /bootmgr 是一个在根目录下的引导文件，
# bootmgr是在Windows Vista、Windows 7、windows 8/8.1和windows 10中使用的新的启动管理器，
# 就相当于Win NT/Win 2000/Win XP时代的NTLDR。
# chainloader /bootmgr 命令会报签名错误，即使关闭签名验证也无法启动
grub>ntldr /bootmgr
grub>boot
```


## 救援模式(grub rescue) {#救援模式--grub-rescue}

```text
error : unknow filesystem
grub rescue>
```

由于分区调整或分区 UUID 改变造成 grub2 不能正常启动，从而进入修复模式了（grub rescue)，也称救援模式。

在救援模式下只有很少的命令可以用：set  ,  ls , insmod , root , prefix

-   set  查看环境变量，这里可以查看启动路径和分区。
-   ls   查看设备
-   insmod  加载模块
-   root  指定用于启动系统的分区,在救援模式下设置 grub 启动分区
-   prefix 设定 grub 启动路径

<!--listend-->

```bash
grub rescue> ls   回车
(hd0) (hd0,msdos9) (hd0,msdos8) (hd0,msdos7) (hd0,msdos6) (hd0,msdos5) (hd0,msdos2) (hd0,msdos1)
grub rescue> ls (hd0,msdos1)/
# （假如找到的启动分区是hd0,msdos8）

## 查看一下设置情况：
# grub rescue> set
# prefix=(hd0,msdos1)/boot/grub
# root=hd0,msdos1

grub rescue>root=(hd0,msdos8)
grub rescue>prefix=/boot/grub                 #grub路径设置
grub rescue>set root=(hd0,msdos8)
grub rescue>set prefix=(hd0,msdos8)/boot/grub
grub rescue>insmod normal                     #启动normal启动
# grub rescue>insmod /boot/grub/normal.mod  #加载基本模块
grub rescue>normal
# normal  #进入正常模式，出现菜单，如果加载grub.cfg（错误的）可能出现问题，按shift可以出现菜单，之后按c键进入控制台

# grub>正常的grub模式，可用命令多
grub>set root=(hd0,msdos1)  #设置正常启动分区
grub>linux /boot/vmlinuz ....  ro text root=/dev/sda1  #加载内核，进入控制台模式
grub>initrd  /boot/initrd ....  #加载initrd.img
grub>boot #引导

# 启动进入系统后
grub-install /dev/sda
update-grub
```
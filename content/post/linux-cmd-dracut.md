---
title: "Linux cmd dracut"
author: ["SHI WENHUA"]
date: "2024-06-29 13:49:00"
lastmod: "2024-06-29 13:49:24"
tags: ["cmd"]
categories: ["Linux"]
draft: false
---

用于增强 Linux 启动系统的功能，并通过从已安装的系统中复制设备和文件并将其与 Dracut 框架合并来开发 Linux 启动映像（initramfs，初始 RAM 文件系统）。

dracut 作为新一代的 initramfs 系统，和前一代的 initramfs 系统的 mkinitrd 的不同点在于, dracut 设计上就考虑到了映像尺寸的问题，尽量避免硬编码，以提高生成的 cpio 映像载入内存的速度。实际上，由于 initramfs 的唯一作用就是挂载 rootfs(因此不需要把一堆无用的比如 plymouth 等都装进去)，它主要依赖 udev 去获取 rootfs 的设备节点，一旦 rootfs 节点出现则立刻切换过去。按照官方维基的说法：5秒启动不是梦。另外它采用了模块化的方式，使用者可自由在 %{_libdir}/dracut/modules.d 下创建他需要的特殊模块，可扩展性很强。最后它的使用方式和 mkinitrd 非常接近，迁移成本较低。

dracut 用于制作 initrd 启动镜像文件, dracut-network 会为镜像内添加 nfs 等网络支持.

在 Linux 中创建 initramfs 映像的最佳方法是使用 Dracut 命令。该命令生成具有所有可用功能的 initramfs 照片，确保 Dracut 模块和系统组合设置。在这种情况下，如果 initramfs 映像已存在，Dracut 将发出错误消息。

```bash
# 覆盖现有图像
sudo dracut -force

# 快速启动系统中的正确内核命令行
sudo dracut --print-cmdline

#一些dracut内置模块默认不会添加至initramfs中，可以在/etc/dracut.conf或/etc/dracut.conf.d/xxx.xonf中添加，也可以使用–add选项
dracut --add bootchart initramfs-bootchart.img

# 查看所有可用的dracut模块
dracut --list-modules
```

---
title: "Linux initramfs"
date: "2024-02-03 12:28:00"
lastmod: "2024-02-03 12:28:18"
categories: ["Linux"]
draft: false
---

## 为什么需要 initramfs {#为什么需要-initramfs}

在 Linux 内核被加载到内存并运行后，内核进程最终需要切换到用户的进程来使用计算机，而用户进程又存在于外存储设备上。 内核源码是没有包含驱动程序的，驱动程序在外存储设备上，这个时候 initramfs 就闪亮登场了。


## initramfs {#initramfs}

initramfs 是一个临时的文件系统，其中包含了必要的设备如硬盘、网卡、文件系统等的驱动以及加载驱动的工具及其运行环境，比如基本的 C 库，动态库的链接加载器等等。同时，那些处理根文件系统在 RAID、网络设备上的程序也存放在 initramfs 中。由第三方程序（如 Bootloader）负责将 initramfs 从硬盘装载进内存。

在初始化的最后，内核运行 initramfs 中的 init 程序，该程序将探测硬件设备、加载驱动，挂载真正的文件系统，执行文件系统上的/sbin/init，进而切换到真正的用户空间。真正的文件系统挂载后，initramfs 即完成了使命，其占用的内存也会被释放。


## initrd 与 initramfs {#initrd-与-initramfs}

initrd 是基于 ramdisk 技术的，而 ramdisk 就是一个基于内存的块设备，因此 initrd 也具有块设备的一切属性。

鉴于 ramdisk 机制的种种限制，Linus Torvalds 基于已有的缓存机制实现了 ramfs。

ramfs 与 ramdisk 有着本质的区别，ramdisk 本质上是基于内存的一个块设备，而 ramfs 是基于缓存的一个文件系统。因此，ramfs 去除了前述块设备的一些限制。

当 2.6 版本的内核引导时，在挂载真正的根文件系统之前，首先将挂载一个名为 rootfs（rootfs 就是一个 ramfs，只不过换了一个名称） 的文件系统，并将 rootfs 的根作为虚拟文件系统目录树的总根。 **内核需要根文件系统上的驱动以及程序来驱动和挂载根文件系统，但是这些驱动和程序有可能没有编译进内核，而在根文件系统上。**

rootfs 是在内存中的，内核不需要特殊的驱动就可以挂载 rootfs，所以内核使用 rootfs 作为一个过渡的桥梁。

在挂载了 rootfs 后，内核将 Bootloader 加载到内存中的 initramfs 中打包的文件解压到 rootfs 中，而这些文件中包含了驱动以及挂载真正的根文件系统的工具，内核通过加载这些驱动、使用这些工具，实现了挂载真正的根文件系统。此后，rootfs 也完成了历史使命，被真正的根文件系统覆盖（overmount）。但是 rootfs 作为虚拟文件系统目录树的总根，并不能被卸载。但是这没有关系，前面我们已经谈到了，rootfs 基于 ramfs，删除其中的文件即可释放其占用的空间。


## 启动流程 {#启动流程}

-   挂载 rootfs
-   解压 initramfs 到 rootfs
-   挂载并切换到真正的根目录
    -   在 grub.cfg 文件中对应的就是 root=XXX。内核将真正的根文件系统挂载到 initramfs 文件系统中的/root 目录下


## initramfs 文件基本操作 {#initramfs-文件基本操作}

```bash
# 查看initramfs
lsinitrd

# 解压initramfs
/usr/lib/dracut/skipcpio initramfs-3.10.0-229.el7.x86_64.img | zcat | cpio -ivd

# 手动创建initramfs
 find . | cpio -o -H newc | gzip -9 > /tmp/test.img
```


## 创建最基本的 initramfs {#创建最基本的-initramfs}

内核启动后会执行 initramfs 中的 init 程序，创建一个 init，里面写入 bash 脚本，脚本添加两行信息，屏幕打印 hello 信息，并运行 bash 程序，exec 是内核运行程序的函数，bash 一般存放在/bin/bash 路径，这里保持这个路径，其次是添加 bash 所依赖的库文件。

```bash
[root@ct7_node02 initramfs]# ll
total 4
drwxr-xr-x 2 root root 18 Aug  2 15:14 bin
-rwxr-xr-x 1 root root 49 Aug  2 15:13 init
drwxr-xr-x 2 root root 90 Aug  2 15:17 lib64
[root@ct7_node02 initramfs]# cat init
#!/bin/bash

echo "Hello Michael"
exec /bin/bash

[root@ct7_node02 initramfs]# tree ./
./
|-- bin
|   `-- bash
|-- init
`-- lib64
    |-- ld-linux-x86-64.so.2
    |-- libc.so.6
    |-- libdl.so.2
    `-- libtinfo.so.5
```

通过 ldd 命令查看 bash 所依赖的库文件，并将这些文件复制到上面的 lib64 目录中

```bash
# ldd /usr/bin/bash
linux-vdso.so.1 =>  (0x00007ffcbd4aa000)
libtinfo.so.5 => /lib64/libtinfo.so.5 (0x00007f4268c01000)
libdl.so.2 => /lib64/libdl.so.2 (0x00007f42689fd000)
libc.so.6 => /lib64/libc.so.6 (0x00007f426863b000)
/lib64/ld-linux-x86-64.so.2 (0x00007f4268e31000)
```

```bash
# lsinitrd test.img
Image: test.img: 1.4M
========================================================================
Version:

Arguments:
dracut modules:
========================================================================
drwxr-xr-x   4 root     root            0 Aug  2 15:17 .
drwxr-xr-x   2 root     root            0 Aug  2 15:14 bin
-rwxr-xr-x   1 root     root       960392 Aug  2 15:14 bin/bash
-rwxr-xr-x   1 root     root           49 Aug  2 15:13 init
drwxr-xr-x   2 root     root            0 Aug  2 15:17 lib64
-rwxr-xr-x   1 root     root       155064 Aug  2 15:15 lib64/ld-linux-x86-64.so.2
-rwxr-xr-x   1 root     root      2116736 Aug  2 15:15 lib64/libc.so.6
-rwxr-xr-x   1 root     root        19344 Aug  2 15:16 lib64/libdl.so.2
-rwxr-xr-x   1 root     root       174520 Aug  2 15:16 lib64/libtinfo.so.5
========================================================================
```


## 参考 {#参考}

[initramfs详解-----初识initramfs](https://huaweicloud.csdn.net/6356178ed3efff3090b59d10.html?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-2~default~OPENSEARCH~activity-1-126041951-blog-128799728.pc_relevant_vip_default&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2~default~OPENSEARCH~activity-1-126041951-blog-128799728.pc_relevant_vip_default&utm_relevant_index=1)
---
title: "Linux busybox/buildroot/openwrt"
description: "嵌入式文件系统构建工具"
date: "2022-06-26 16:17:00"
lastmod: "2022-08-01 14:07:19"
tags: ["busybox"]
categories: ["Linux"]
draft: false
---

## 使用 Busybox 手工制作 {#使用-busybox-手工制作}

Busybox 本身包含了很了 Linux 命令，但是要编译其他程序的话需要手工下载、编译，如果它需要某些依赖库，你还需要手工下载、编译这些依赖库。

如果想做一个极简的文件系统，可以使用 Busybox 手工制作。


### busybox 编译和移植说明 {#busybox-编译和移植说明}

busybox 的编译与 Linux 内核的编译过程类似。从<http://www.busybox.net/downloads/> 下载最新的源码，解压后，通过以下几步，即可完成 busybox 的编译和移植：


#### make xxxxxxconfig {#make-xxxxxxconfig}

busybox 提供了几种配置:

-   defconfig (缺省配置)
-   allyesconfig（最大配置）
-   allnoconfig（最小配置）

一般选择缺省配置即可, 这一步结束后，将生成 `.config` 文件.


#### make menuconfig {#make-menuconfig}

这一步是可选的，可以通过这一步进行微调，加入或去除某些命令。 这一步实际上是修改.config


#### make CROSS_COMPILE=arm-linux- {#make-cross-compile-arm-linux}

这一步就是根据.config，生成 busybox，当然你也可以指定其他的编译器， 如 arm-linux-gnueabi-。（"make CROSS_COMPILE="将用 gcc 编译 PC 机上运行的 busybox.


### [编译busybox](https://juejin.cn/post/7057883082585538567) {#编译busybox}


#### 环境配置 {#环境配置}

```bash
root@linux:~/study$ ls
busybox-1.33.0.tar.bz2

apt install libncurses-dev -y

tar jxvf busybox-1.33.0.tar.bz2
mkdir -p busybox-build
cd busybox-1.33.0
make O=../busybox-build defconfig

# 生成编译 .config 文件
cd ../busybox-build

make menuconfig
# 需要设置静态编译，编译出的二进制可以独立运行，不依赖其他库。
# 在"Setting"（回车进入子菜单）-->选择"Build static binary (no shared libs)"（空格键选择）。
```


#### 编译安装生成 initrd {#编译安装生成-initrd}

```bash
# make 和 make install 执行成功后会在 busybox-build 目录下生成 _install 目录
make
make install

# 在 busybox-build 同级目录下创建 rootfs 目录
mkdir rootfs
cd rootfs
#不要忽略最后的一个点.
cp -ar ../busybox-build/_install/* .

# 创建软连接 init 指向 bin/busybox，内核启动到最后会执行 init 进程
ln -sf bin/busybox init
mkdir -p {sys,proc,dev,etc/init.d}

# 启动脚本，相当于 rc.local
touch etc/init.d/rcS
chmod 755 etc/init.d/rcS
# etc/init.d/rcS内容见下方

touch etc/fstab
# etc/fstab内容见下方

# 这里的 pigz 可以多线程压缩，需要安装 pigz，或者使用 gzip 替代。
sudo apt install pigz
find . -print0 | cpio --null -ov --format=newc | pigz -9 > ../initrd-busybox.img
```

<!--list-separator-->

-  rcS

    ```bash
    #!/bin/sh
    # RC Script for Tiny Core Linux
    # (c) Robert Shingledecker 2004-2012

    # Mount /proc.
    [ -f /proc/cmdline ] || /bin/mount /proc

    # Remount rootfs rw.
    /bin/mount -o remount,rw /

    # Mount system devices from /etc/fstab.
    /bin/mount -a
    ```

<!--list-separator-->

-  fstab

    ```bash
    sysfs /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0
    proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0
    udev /dev devtmpfs rw,nosuid,noexec,relatime,mode=755 0 0
    ```


### 指定编译器 {#指定编译器}


#### menuconfig 界面指定 {#menuconfig-界面指定}

make menuconfig:

-   Settings
    -   Cross compiler prefix
        -   &lt;input&gt;


#### terminal 终端指定 {#terminal-终端指定}

```bash
export PATH=$PATH:/toolchains/gcc-xxxx-linux-gnu/bin
make CROSS_COMPILE=aarch64-linux-gnu-
```


### busybox 使用 {#busybox-使用}

busybox 使用有以下三种方式：


#### busybox 后直接跟命令，如 {#busybox-后直接跟命令-如}

-   busybox ls
-   busybox tftp


#### 直接将 busybox 重命名，如 {#直接将-busybox-重命名-如}

-   cp busybox tftp
-   cp busybox tar
-   然后再执行 tftp, tar


#### 创建符号链接（symbolic link）， 如 {#创建符号链接-symbolic-link-如}

-   ln -s busybox rm
-   ln -s busybox mount
-   然后执行 rm，mount

**busybox 提供了一种自动创建命令链接方法：在 busybox 编译成功后，接着执行“make install”,则会产生一个_install 目录，其中包含了 busybox 及每个命令的软链接。**


### Ref {#ref}

-   [busybox的编译、使用及安装](https://www.cnblogs.com/baiduboy/p/6228003.html)
-   [编译busybox](https://juejin.cn/post/7057883082585538567)
-   [配置和编译busybox相关问题](https://blog.csdn.net/lly374685868/article/details/80611741)


## 使用 Buildroot 自动制作 {#使用-buildroot-自动制作}

它是一个自动化程序很高的系统，可以在里面配置、编译内核，配置编译 u-boot、配置编译根文件系统。在编译某些 APP 时，它会自动去下载源码、下载它的依赖库，自动编译这些程序。

Buildroot 的语法跟一般的 Makefile 语法类似，很容易掌握。


## 使用 Yocto {#使用-yocto}

NXP、ST 等公司的官方开发包是使用 Yocto，但是 Yocto 语法复杂，并且 Yocto 动辄 10GB，下载安装都很困难，普通笔记本编译可能需要 2-3 天甚至更久，非常不适合初学者(我们不推荐使用 yocto 构建文件系统)。


## 推荐 Buildroot {#推荐-buildroot}

Buildroot 是一组 Makefile 和补丁，可简化并自动化地为嵌入式系统构建完整的、可启动的 Linux 环境(包括 bootloader、Linux 内核、包含各种 APP 的文件系统)。Buildroot 运行于 Linux 平台，可以使用交叉编译工具为多个目标板构建嵌入式 Linux 平台。Buildroot 可以自动构建所需的交叉编译工具链，创建根文件系统，编译 Linux 内核映像，并生成引导加载程序用于目标嵌入式系统，或者它可以执行这些步骤的任何独立组合。


## Site {#site}

-   [Busybox](https://busybox.net/)
-   [Buildroot](https://buildroot.org/)
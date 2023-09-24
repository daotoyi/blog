---
title: "make"
lastmod: "2023-09-24 08:08:45"
categories: ["Code"]
draft: true
---

## 常用命令 {#常用命令}

-   make
-   make install
-   make modules
-   make modules_install


## 配置参数 {#配置参数}

```text
# make ARCH=<平台> config #比较繁琐，不推荐
# make ARCH=<平台> oldconfig #常用于内核升级，提示新内核特性
# make ARCH=<平台> menuconfig #常用
# make ARCH=<平台> xconfig #X界面的配置方式
# make ARCH=<平台> gconfig #GTK界面的配置方式
# make ARCH=<平台> defconfig #使用默认的配置
# make ARCH=<平台> allyesconfig #所有配置选项设置为yes
# make ARCH=<平台> allmodconfig #所有选项配置为module
```

选项：

-   Y : 代表将此项编译入内核中
-   N : 代表不将此项编译
-   M : 代表将此项编译为模块,在需要使用到的时候再加载入内核


## 内核镜像 {#内核镜像}

| vmlinx-z         | 描述                                         |
|------------------|--------------------------------------------|
| vmlinux          | 编译后形成镜像文件                           |
| zImage(vmlinuz)  | 在 vmlinux 的基础上使用 gzip 进行压缩所形成的小内核（不超过 512KB） |
| bzImage(vmlinuz) | 全称为 bigzImage，同 zImage 一样原理，只是比 zImage 镜像大 |
| uImage(vmlinuz)  | 为 uBoot 专用镜像，在 zImage 基础上再加上一个头形成 uImage |

**vmlinuz 是对 vmlinux 进行了相应压缩的内核镜像，而 zImage，bzImage 和 uImage 统称为 vmlinuz。**

<https://pic1.zhimg.com/70/v2-2b297e718bf98292c41c6d7cfa864048_1440w.avis?source=172ae18b&biz_tag=Post>


## make-kpkg 与 make deb-pkg {#make-kpkg-与-make-deb-pkg}

make-kpkg 已退休，Debian 的官方方式是 make deb-pkg


### make-kpkg(已退休） {#make-kpkg已退休}

```bash
fakeroot make-kpkg  --initrd --revision custom.001 --append-to-version -20110107 kernel_image kernel_headers
```

-   fakeroot：普通用户执行
-   --initrd: 生成 initramfs
-   --revision: deb 文件的版本信息，只影响文件名，默认会是“10.00.Custom”；
-   --append-to-version: 不仅出现在 deb 安装包的文件名里，也会影响到 kernel 的名称
-   kernel_image：生成内核和默认模块的安装包
-   kernel_headers： 生成一个内核头文件的安装包。


### make deb-pkg {#make-deb-pkg}

```bash
make deb-pkg
```


## make clean 与 make mrproper {#make-clean-与-make-mrproper}

Linux 内核源码根目录下面的 makefile 中：

```bash
help:
 @echo  'Cleaning targets:'
 @echo  '  clean    - Remove most generated files but keep the config and'
 @echo  '                    enough build support to build external modules'
 @echo  '  mrproper   - Remove all generated files + config + various backup files'
 @echo  '  distclean   - mrproper + remove editor backup and patch files'
```


## 参考 {#参考}

<https://blog.csdn.net/mish84/article/details/26003963>
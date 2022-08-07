---
title: "Linux 动态链接器"
description: "跨 libc 启动程序（python3）"
date: "2022-04-16 07:33:00"
lastmod: "2022-08-07 12:24:40"
tags: ["libs"]
categories: ["Cplus"]
draft: false
---

## ELF 格式 {#elf-格式}

Linux 上可执行程序遵循的是 ELF 格式。

一般一个 ELF 文件都会有两个 header :

-   ELF header，作用是描述整个 ELF 文件的一些信息
-   program header, 作用主要是为了表明自己应该如何被加载和执行。
-   example: `readelf --file-header /usr/bin/awk`

在这两个 header 之后，有很多 section。

-   这些 section 会在 ELF 文件被加载时，归纳为若干 segment 。
-   这里面既有代码也有数据
-   其中最关心的一个 section 叫做 .dynamic.
    -   .dynamic 包含了可执行程序所需的动态链接库
    -   example: `readelf -d /usr/bin/awk`

readelf 本质上只解析这一个 ELF 文件。如果一个 ELF 文件依赖的动态链接库，又依赖了其他动态链接库，那么这条命令就不够用了。为此，可以使用 ldd 命令.


## glibc，libc，glib {#glibc-libc-glib}


### glibc {#glibc}

glibc 是 linux 的 GUN C 函数库，是 linux 系统中最底层的 API，几乎其它任何运行时库都依赖于 glibc。

glibc 除了封装 linux 操作系统所提供的系统服务，它本身也提供了许多其它必要功能服务的实现，例如：动态加载模块 libdl、实时扩展接口 librt。对应的动态库的名字 libc.so


### libc {#libc}

是 Linux 下的 ANSI C 函数库，被 glibc 包含

> libc 是 Linux 下原来的标准 C 库，也就是当初写 hello world 时包含的头文件#include &lt; stdio.h&gt; 定义的地方。后来逐渐被 glibc 取代，也就是传说中的 GNU C Library,在此之前除了有 libc，还有 klibc,uclibc。


### glib {#glib}

是 Linux 下 C 的一些工具库，和 glibc 没有关系


### check {#check}

```bash
# 查看glibc版本,ldd是隶属于glibc，它的版本就是glibc的版本
ldd --version

#libstdc++是 gcc的标准C++库(libc++是clang的标准C++库)
```


## ld-linux.so {#ld-linux-dot-so}

识别二进制映像以及文件映射到进程虚拟地址空间这个过程确实是在内核中完成的，但是动态链接的过程，需要把控制权交给 ld-linux.so.x，这是在用户空间进行的。

ld-linux.so.x 是 Glibc 安装的库，所以动态链接的过程实际上这跟编译一样，属于用户态程序，核心代码在 elf/rtld.c 中。


## linux-vdso.so.1 {#linux-vdso-dot-so-dot-1}

ldd 命令非常友好地打印出了所有动态链接库的地址，唯独没有打印出 linux-vdso.so.1 .

linux-vdso.so.1 文件，并不是一个真实存在的文件，而是 Linux 中的一个虚拟文件，专门用于将内核中一些常用的函数从内核空间映射到用户空间。也就是说，这个文件不用复制。


## LD_LIBRARY_PATH &amp; rpath &amp; runpath {#ld-library-path-and-rpath-and-runpath}

在 Linux 中，主要有三个因素可以决定特定可执行文件的动态链接库的搜索路径：

1.  环境变量 LD_LIBRARY_PATH
    -   绝大部分动态链接库会从环境变量 LD_LIBRARY_PATH 中查找加载
2.  rpath
3.  runpath

rpath 和 runpath 是 ELF 文件的可选内容。

如果一个 ELF 文件含有 rpath ，那么系统会 **优先在 rpath 所指向的路径搜索，然后再搜索 LD_LIBRARY_PATH, runpath 则是在 LD_LIBRARY_PATH 之后搜索。**

rpath，因为是内嵌在 ELF 当中的，一旦程序中有这个内容会影响我们使用 LD_LIBRARY_PATH 的效果。

在不同平台运行程序，可以复制拷贝程序所需的动态库，指定搜索路径后再运行，如

```nil
LD_LIBRARY_PATH=/new/path:$LD_LIBRARY_PATH /usr/bin/python3
```


## 新系统平台运行 {#新系统平台运行}


### 直接在新平台上运行失败 {#直接在新平台上运行失败}

在 Linux 当中， 内核并不直接负责加载动态链接的 ELF 文件所需要的链接库，这些链接库的加载职责由 ld-linux.so.2 来负责，而 ld-linux.so.2 的路径在程序的链接时就已经写成了硬编码。

因此，因此在新系统中， 运行程序依然会使用硬编码的路径来调用 ld-linux-x86-64.so.2 ，这会直接使用到新系统的 ld-linux-x86-64.so.2。

由于 ld-linux-x86-64.so.2 必须与 glibc 的版本匹配，，而 glibc 其他动态链接库均来自老系统，就会运行失败。


### 解决方式一：指定链接库重新编译 {#解决方式一-指定链接库重新编译}

```bash
g++ main.o -o myapp ... \
   -Wl,--rpath=/path/to/newglibc \
   -Wl,--dynamic-linker=/path/to/newglibc/ld-linux.so.2
```

-   第三行会指定 ld-linux.so.2 的位置
-   第二行可以用来设定 ELF 文件的 rpath
    -   就不用在启动时调整 LD_LIBRARY_PATH 了
    -   通过 rpath 参数还有另外的好处，那就是进程再产生子进程时，不会因需要改变当前进程的 LD_LIBRARY_PATH 而连带受到影响


### 方式一总结 {#方式一总结}

如果编译环境与运行环境不同(arm 交叉编译），则需要将 gcc，glibc 的一些库打包到程序安装包中，并且指定库的路径

指定 gcc/g++的版本

```bash
export CC=gcc的路径
export CXX=g++的路径
```

1.  将程序的依赖库，动态连接器都需要放入程序的依赖库的目录中:
2.  指定连接器和 glibc 的版本路径.
    -   在 gcc 的编译参数中指定 -Wl,–dynamic-linker=glibc 中动态链接器的路径，如下：

        ```bash
        gcc xxx -o xxx \
          -Wl,--dynamic-linker=/动态连接器的路径/ld-linux-x86-64.so.2
        ```
    -   这些库最好都放在指定的，固定的目录中，在编译时通过这个编译选项指定该路径.
3.  将动态连接器 ld-linux-x86-64.so.2 的路径配置到 LD_LIBRARY_PATH 中


### 方式一扩展 {#方式一扩展}

```bash
./ld-linux-x86-64.so.2  ./xxxx.exe
```

适用于一些在新平台上不支持重新编译构建或者编译有困难的库。


### 解决方式二：patchelf {#解决方式二-patchelf}

```bash
$ ./patchelf --set-interpreter /path/to/newglibc/ld-linux.so.2 --set-rpath /path/to/newglibc/ myapp
```


## gcc/glibc 多版本共存 {#gcc-glibc-多版本共存}

多个 gcc/glibc 共存，新安装的 gcc/glibc 版本需要指定安装目录。特别是 glibc 作为基础库，如果直接替换了系统中原有的 glibc，很可能造成任何命令/程序都无法运行的情况。

**切记，一定要指定安装目录。**


## Ref {#ref}

-   [理解 Linux 动态链接库依赖](https://zhuanlan.zhihu.com/p/59590848)
-   [多个gcc/glibc版本的共存及指定gcc版本的编译](https://blog.csdn.net/mo4776/article/details/119837501)
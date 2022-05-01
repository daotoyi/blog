---
title: "Linux 动态链接器"
date: "2022-04-16 07:33:00"
lastmod: "2022-04-30 12:45:50"
categories: ["Linux"]
draft: false
---

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


## 多个 gcc/glibc 版本共存 {#多个-gcc-glibc-版本共存}

多个 gcc/glibc 共存，新安装的 gcc/glibc 版本需要指定安装目录。特别是 glibc 作为基础库，如果直接替换了系统中原有的 glibc，很可能造成任何命令/程序都无法运行的情况。

**切记，一定要指定安装目录。**


### 指定 gcc/g++，glibc 的版本进行编译 {#指定-gcc-g-plus-plus-glibc-的版本进行编译}

-   指定 gcc/g++的版本

<!--listend-->

```bash
export CC=gcc的路径
export CXX=g++的路径
```

-   指定连接器的版本
    将连接器的路径，放在 LD_LIBRARY_PATH 的最前面

-   指定 glibc 的版本
    -   通过 gcc 的-L 参数指定 glibc 库(libc.so)的路径
    -   在 gcc 的编译参数中指定 -Wl,–dynamic-linker=glibc 中动态链接器的路径，如下：

        ```bash
        -Wl,--dynamic-linker=/动态连接器的路径/ld-linux-x86-64.so.2
        ```
    -   在 gcc 中链接 libc.so(-lc)
    -   将 glibc 的路径，引入 LD_LIBRARY_PATH 中


### 程序运行机器上的依赖 {#程序运行机器上的依赖}

如果编译环境与运行环境不同，则需要将 gcc，glibc 的一些库打包到程序安装包中，并且指定库的路径

-   依赖的库
    libstdc++.so,libc.so 库及它们的依赖库，动态连接器都需要放入程序的依赖库的目录中，基本是包含如下几个库:

    ```bash
    librt.so.1
    libdl.so.2
    libpthread.so.0
    libstdc++.so.6
    libm.so.6
    libc.so.6 -> glibc库
    libgcc_s.so.1
    libresolv.so.2
    libcrypt.so.1
    ld-linux-x86-64.so.2 ->其实是个执行程序，为动态连接器
    ```
-   指定依赖库的路径

在编译是通过 gcc 的编译参数 `-Wl,-rpath=程序的依赖库路径` ,这些库最好都放在指定的，固定的目录中，在编译时通过这个编译选项指定该路径.

3.将动态连接器 ld-linux-x86-64.so.2 的路径配置到 PATH 中


## Ref {#ref}

-   [多个gcc/glibc版本的共存及指定gcc版本的编译](https://blog.csdn.net/mo4776/article/details/119837501)
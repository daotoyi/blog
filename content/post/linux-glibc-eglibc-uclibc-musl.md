---
title: "Linux glibc、eglibc、uclibc、Musl-libc"
date: "2022-08-06 20:12:00"
lastmod: "2022-08-07 10:53:15"
tags: ["libs"]
categories: ["Cplus"]
draft: false
---

## glibc {#glibc}

-   GNU C Library 是 GNU 项目（GNU Project），所实现的 C 语言标准库（C standard library）
-   常见的桌面和服务器中的 GNU/Linux 类的系统中，都是用的这套 C 语言标准库。
-   实现了常见的 C 库的函数，支持很多种系统平台，功能很全，但是也相对比较臃肿和庞大。


## eglibc {#eglibc}

-   Embedded GLIBC 是 glibc 的原创作组织 FSF 所（新）推出的 glibc 的一种变体
-   目的在于将 glibc 用于嵌入式系统。
-   保持源码和二进制级别的兼容，与 Glibc 源代码架构和 ABI 层面兼容。
-   降低(内存)资源占用/消耗
-   最主要特点就是可配置，裁剪掉不需要的模块，降低生成的库的大小。


## uClibc {#uclibc}

-   一个小型的 C 语言标准库，主要用于嵌入式
-   此处的 u 意思是μ，是 Micro 微小的意思
-   uClibc 比 glibc 要小很多
-   uClibc 是独立的，为了应用于嵌入式系统中，完全重新实现出来的。
-   和 glibc 在源码结构和二进制上，都不兼容.


## musl {#musl}

-   一个轻量级的 C 标准库
-   设计作为 GNU C library (glibc)、 uClibc 或 Android Bionic 的替代用于嵌入式操作系统和移动设备


## conclusion {#conclusion}

-   uClibc 是嵌入式系统中用的，glibc 是桌面系统用的
-   eglibc 也是嵌入式系统中用的，是 glibc 的嵌入式版本，和 glibc 在源码和二进制上兼容。
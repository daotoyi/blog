---
title: "Linux 32 位系统支持 8G 内存"
lastmod: "2022-07-11 12:55:24"
categories: ["Linux"]
draft: true
---

## 问题方案 {#问题方案}

32 位的操作系统只能识别 4G 内存

yum install kernel-PAE


## PAE {#pae}

-   Physical Address Extension，PAE 是 Intel 提供的内存地址扩展机制.
-   通过在宿主操作系统中使用 Address Windowing Extensions API 为应用程式提供支持，从而让处理器将能够用来寻址物理内存的位数从 32 位扩展为 36 位。
-   用于拥有超过 4GB RAM 的 32-bit x86 系统中，或 CPU 带有 “NX (No eXecute)” 特性的系统中
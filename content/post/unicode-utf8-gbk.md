---
title: "Unicode"
date: "2022-02-13 14:25:00"
lastmod: "2022-04-30 12:45:25"
categories: ["Linux"]
draft: false
---

-   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2022-02-13 周日 14:25]</span></span>


## 概述 {#概述}

**用什么编码，就用什么解码**


## ASCII 码 {#ascii-码}

ASCII 码占 8 个比特位，也就是一个字节，其中最前面一个位是扩展位，都是 0，为了日后扩展所用，其余位置不是 0 就是 1。


## GBK {#gbk}

最早的字符编码 ASCII 码中，并没有中文，但是随着计算机在中国的普及, 中国北大方正团队，发明了 gbk 编码。

<https://mmbiz.qpic.cn/mmbiz_png/hRU7GdO3rMVNZ3b3mfoBLFHiaTGClXCoAJQc9A2ukp8LISoia9hAVJNGFdDsbqBf0zRItW85sZFianQWibt8KQbJicA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1>

由于当时的需要，逐步衍生出来的，这三种不同的编码都是向上兼容的.


## Unicode 万国码 {#unicode-万国码}

最开始的 Unicode，又叫 ucs-2，ASCII 存储采用 1 个字节，因此 ucs-2 采用 2 个字节进行存储，最多有 2^16=65536 个空位，这样仍然无法兼容全世界的字符。于是 ucs-4 产生了，存储采用 4 个字节，共 2^32=4 亿多个空位。

但是据统计，全世界文字、数字、符号信息加起来也就 23 万，对于 4 亿多空间来说，ucs-4 简直太浪费空间了，这个对于文件传输来说，及其浪费流量。

考虑到节省空间，在 Unicode 基础上，我们又发明了 utf-8，一种可变长的 Unicode 字符编码。


## UTF-8 {#utf-8}

-   对于英文来说，采用 ASCII 码占位方式，占 8 位，即 1 个字节；
-   存放欧洲文字时，占 16 位，即 2 个字节；
-   存放中文时，占 24 位，即 3 个字节。

    <https://mmbiz.qpic.cn/mmbiz_png/hRU7GdO3rMVNZ3b3mfoBLFHiaTGClXCoAPJnk2UGM6OzaGq7rPFsywnBIPcomRxpaa4G7ziaJtVXIjFQaOibgSicQg/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1>


## 编码示例 {#编码示例}

<https://mmbiz.qpic.cn/mmbiz_png/hRU7GdO3rMVNZ3b3mfoBLFHiaTGClXCoAh4J3ibNznRxeDqZ8yiaBDW0hStjetZWaQRUYCxbcPh5ea5yT36icDqNgw/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1>


## python 使用 {#python-使用}

-   在 Python2 中，默认字符编码是 ASCII 码，因此在 Python2 中写中文，首行一般都会加上 `-- coding:utf-8 --`

-   对 Python3.x 来说，默认字符编码是 utf-8，而 utf-8 是 Unicode 的扩展集。即 Python3.x 中默认所有的字符都是 Unicode。

-   如果是 utf-8 编码，每个中文字符就是 3 个字节存储。如果是 gbk 编码，每个中文字符就是 2 个字节存储。


## Unicode、UTF-8、UTF-16，终于懂了[^fn:1] {#unicode-utf-8-utf-16-终于懂了}

[^fn:1]: <https://mp.weixin.qq.com/s/dIuTohi2CLkmOe1skGVf4w>
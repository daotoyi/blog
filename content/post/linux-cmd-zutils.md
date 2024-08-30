---
title: "Linux cmd Zutils"
author: ["SHI WENHUA"]
date: "2024-08-05 18:41:00"
lastmod: "2024-08-06 08:33:38"
categories: ["Linux"]
draft: false
---

Zutils 是一组用来处理压缩文件的工具集，支持的压缩档包括：gzip, bzip2, lzip, and xz. 当前版本提供的命令有：zcat, zcmp, zdiff, and zgrep 。

```bash
# 直接查看tar.gz压缩包里的内容可以使用
zcat xxx.tar.gz

zcat vsftpd.tar.gz | grep --binary-files=text 'footbar.js'
# or
zgrep --binary-files=text 'footbar.js' vsftpd.tar.gz
```

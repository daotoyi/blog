---
title: "Linux compare with Windows"
date: "2022-03-13 15:17:00"
lastmod: "2022-09-19 08:09:47"
categories: ["Linux"]
draft: false
---

## CMD {#cmd}


### link (mklink ln) {#link--mklink-ln}

`MKLINK [[/D] | [/H] | [/J]] Link Source`

| para   | function            |
|--------|---------------------|
| /D     | 创建目录符号链接。默认为文件符号链接。 |
| /H     | 创建硬链接而非符号链接。 |
| /J     | 创建目录联接。      |
| Link   | 指定新的符号链接名称。 |
| Source | 指定新链接引用的路径(相对或绝对)。 |
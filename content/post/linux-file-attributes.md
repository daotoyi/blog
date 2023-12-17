---
title: "Linux 文件扩展属性"
date: "2023-12-17 19:04:00"
lastmod: "2023-12-17 19:05:01"
categories: ["Linux"]
draft: false
---

## 简述 {#简述}

扩展属性（xattrs）提供了一种机制，用来将键值对永久得关联到文件；让现有的文件系统得以支持在原始设计中未提供的功能。

扩展属性是目前流行的 POSIX 文件系统具有的一项特殊的功能，可以给文件，文件夹添加额外的 Key-value 的键值对，键和值都是字符串并且有一定长度的限制。

扩展属性需要底层文件系统的支持，在使用扩展属性的时候，需要查看文件系统说明文章，看此文件系统是否支持扩展属性，以及对扩展属性命名空间等相关的支持。包括 btrfs、ext2、ext3、ext4、JFS、Reiserfs，Lustrefs 以及 XFS 等文件系统都支持 EA。


## 备份扩展属性 {#备份扩展属性}

```bash
# backup
tar --xattrs --xattrs-include=* -czvf mydata.tar.gz mydata

# restore
tar --xattrs --xattrs-include=* -xvf mydata.tar.gz
```
---
title: "Linux cmd tar/zip"
date: "2022-11-03 14:47:00"
lastmod: "2023-12-11 20:32:57"
tags: ["cmd"]
categories: ["Linux"]
draft: false
---

## zip {#zip}


### 常用命令 {#常用命令}

| 命  令                      | 作  用       |
|---------------------------|------------|
| zip 1.txt.zip 1.txt         | 压缩         |
| zip -r 123.zip 123/         | 压缩目录     |
| unzip 1.txt.zip             | 解压         |
| unzip 123.zip -d _root/456_ | 解压缩到指定目录下 |
| unzip -l 123.zip            | 列出压缩文件所包含的内容 |

和 gzip、bzip2 和 xz 不同的是，使用 zip 压缩后，保留原文件。不能更改压缩后的压缩包名称。不能直接查看 zip 压缩包的内容，只能查看压缩包内文件列表。


## tar {#tar}


### 常用命令 {#常用命令}

| 命  令                                        | 作  用    |
|---------------------------------------------|---------|
| tar -cvf 123.tar 123                          | 打包单个文件 |
| tar -cvf 123.tar 1.txt 123                    | 打包多个文件 |
| tar -xvf 123.tar                              | 解包      |
| tar -tf 123.tar                               | 查看打包文件列表 |
| tar -cvf 123.tar --exclude 1.txt --exclude 23 | 打包时部分文件不打 |

--exclude

-   当有多个文件或才目录排除时，每个都需要加--exclude
-   包排除文件夹是最后不能有‘/’


### 打包压缩 {#打包压缩}

| 命  令                        | 作  用           |
|-----------------------------|----------------|
| tar -zcvf 123.tar.gz 123      | 打包并压缩成 gzip 压缩包 |
| tar -zxvf 123.tar.gz          | 解包并解压缩 gzip 压缩包 |
| tar -jcvf 123.bz2 123         | 打包并压缩成 bzip2 压缩包 |
| tar -jxvf 123.bz2             | 解包并解压缩 bzip2 压缩包 |
| tar -Jcvf 123.xz 123          | 打包并压缩成 xz 压缩包 |
| tar -Jxvf 123.xz              | 解包并解压缩 xz 压缩包 |
| tar -tf 123.bz2/123.gz/123.xz | 查看压缩包文件列表 |


### 扩展文件属性 {#扩展文件属性}

| 参数                  | EN 解释                                    | 中文翻译         | 备注 |
|---------------------|------------------------------------------|--------------|----|
| --acls                | Enable the POSIX ACLs support              | 启用 POSIX ACL 支持 |    |
| --no-acls             | Disable the POSIX ACLs support             | 禁用 POSIX ACL 支持 |    |
| --no-selinux          | Disable the SELinux context support        | 禁用 SELinux 上下文支持 |    |
| --no-xattrs           | Disable extended attributes support        | 禁用扩展属性支持 |    |
| --selinux             | Enable the SELinux context support         | 启用 SELinux 上下文支持 |    |
| --xattrs              | Enable extended attributes support         | 启用扩展属性支持 |    |
| --xattrs-exclude=MASK | specify the exclude pattern for xattr keys | 指定 xattr 键排除模式 |    |
| --xattrs-include=MASK | specify the include pattern for xattr keys | 指定 xattr 键包括模式 |    |


### 扩展属性示例 {#扩展属性示例}

一些数据是存储在扩展属性里面的，很多操作默认是会忽略扩展属性的，很容易把扩展属性弄丢。

```bash
# 打包
tar --xattrs --xattrs-include=* -czvf mydata.tar.gz mydata
# 解压
tar --xattrs --xattrs-include=* -xvf mydata.tar.gz
# 检查扩展性
getfattr -d -m . mydata
```

**打包和解压都必须带参数，并且都需要带 include 的参数，否则解压的时候会忽略**


### 参考 {#参考}

-   [Ubuntu tar 1.28 命令详解](http://ubuntu.digitser.net/ubuntu/zh-CN/tar.html)
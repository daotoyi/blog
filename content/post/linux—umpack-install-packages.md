---
title: "Linux 解压安装包文件"
date: "2022-11-21 12:29:00"
lastmod: "2022-11-21 14:05:30"
categories: ["Linux"]
draft: false
---

## dpkg {#dpkg}

-   X 解压
-   dekg-deb 重新打包

<!--listend-->

```sh
mkdir extract
mkdir extract/DEBIAN
mkdir build

# 0 解压出包中的文件到 extract 目录下
dpkg -X ../openssh-client_6.1p1_i386.deb extract/
# 1 解压出包的控制信息 extract/DEBIAN/下：
dpkg -e ../openssh-client_6.1p1_i386.deb extract/DEBIAN/
#change code
# 2 修改后的内容重新进行打包生成 deb 包
dpkg-deb -b extract/ build/
```


## rpm {#rpm}


### prefix {#prefix}

使用--prefix 参数可以安装到一个指定的临时目录.

```sh
rpm -ivh xxx.rpm --prefix=/path/to/tmp
```

有些文件不能指定安装，使用以下 cpio 方式。


### cpio {#cpio}

RPM 包括是使用 cpio 格式打包的，因此可以先转成 cpio 然后解压.

```sh
rpm2cpio xxx.rpm | cpio -div
```

得到 tar.gz 的压缩包，直接使用 tar -zxvf 命令即可解压得到源码
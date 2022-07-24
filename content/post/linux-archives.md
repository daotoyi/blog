---
title: "Linux 集锦"
lastmod: "2022-07-20 20:43:19"
categories: ["Linux"]
draft: true
---

## shell {#shell}


### 空语句 : {#空语句}

-   shell
    -   :
-   python
    -   pass


### 去除文件后辍 {#去除文件后辍}

```bash
$ basename /folder/f.zip .zip
f
```


## CMD {#cmd}


### cp 和 mv 命令添加进度条 {#cp-和-mv-命令添加进度条}

由于 cp 和 mv 命令都是属于 coreutils 工具包下的，因此我们的主要操作就是在编译 coreutils 的时候加入补丁从而实现进度条功能.


#### 过程 {#过程}

```bash
# 注意尽量不要使用 root 用户操作
# 下载coreutils
$ wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.32.tar.xz
$ tar -xJf coreutils-8.32.tar.xz
$ cd coreutils-8.32/

# 下载 github 上的补丁
$ wget https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-0.8-8.32.patch
# 打补丁，实现进度条显示
$ patch -p1 -i advcpmv-0.8-8.32.patch
# patching file src/copy.c
# patching file src/copy.h
# patching file src/cp.c
# patching file src/mv.c

# 编译安装
$ ./configure
$ make
# 将打补丁生成的cp和mv命令的二进制文件复制到bin目录下
$ sudo cp src/cp /usr/local/bin/cp
$ sudo cp src/mv /usr/local/bin/mv
```


#### 使用 {#使用}

在使用 cp 和 mv 命令的时候加上 -g 参数就可以显示进度条.

在 .bashrc 文件中设置 alias.

```bash
$ alias cp='cp -ig'
$ alias mv='mv -ig'
```
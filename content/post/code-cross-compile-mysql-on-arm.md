---
title: "交叉编译 ARM 版 mysql"
lastmod: "2023-12-08 17:45:02"
categories: ["Code"]
draft: true
---

## 基本概述 {#基本概述}

移植过程中会需要用到 x86 环境下生成的工具，所以先编译 PC 端的 mysql。


## 编译环境 {#编译环境}


### 主机 {#主机}

```text
➜ screenfetch

 ██████████████████  ████████     dao@Manjaro
 ██████████████████  ████████     OS: Manjaro 23.0.4 Uranos
 ██████████████████  ████████     Kernel: x86_64 Linux 5.10.197-1-MANJARO
 ██████████████████  ████████     Uptime: 12d 19h 48m
 ████████                ████████     Packages: 1410
 ████████  ████████  ████████     Shell: zsh 5.9
 ████████  ████████  ████████     Resolution: 1440x960
 ████████  ████████  ████████     WM: Not Found
 ████████  ████████  ████████     GTK Theme: Adwaita [GTK3]
 ████████  ████████  ████████     Disk: 64G / 254G (27%)
 ████████  ████████  ████████     CPU: Intel Atom x5-E8000 @ 4x 2GHz
 ████████  ████████  ████████     RAM: 1106MiB / 3837MiB
 ████████  ████████  ████████
 ████████  ████████  ████████
```


### 工具链 {#工具链}

<style>.org-center { margin-left: auto; margin-right: auto; text-align: center; }</style>

<div class="org-center">

gcc-buildroot-9.3.0-2020.03-x86_64_aarch64-rockchip-linux-gnu
aarch64-rockchip-linux-gnu

</div>


### 源码 {#源码}

-   mysql-5.7.27
-   ncurses-6.1
    －　<http://mirrors.ustc.edu.cn/gnu/ncurses/>
-   libtirpc-0.2.2


## 编译步骤 {#编译步骤}


### mysql(pc) {#mysql--pc}

```bash
sudo pacman -S  pkg-config cmake gcc

tar -xf mysql-boost-5.7.27.tar.gz
cd mysql-5.7.27/BUILD/

vi compile-pentium64 # 上一级目录必须要有boost目录
# path=`dirname $0`
# cmake $path/.. -DWITH_DEBUG=0
# make

./compile-pentinum64

# 编译OK后
cd ../..
mv mysql-5.7.27 mysql-5.7.27-pc
```

-   compile-pentium64

<!--listend-->

```bash
path=`dirname $0`
cmake $path/.. -DWITH_DEBUG=0
make
```


### ncurses {#ncurses}

-   step

<!--listend-->

```bash
tar -xf　ncurses-6.1.tar.gz
cd ncurses-6.1/

source cc.sh
# export PATH=$PATH:/home/daoyi/techyauld/xj-arm/prebuilts/gcc/linux-x86/aarch64/gcc-buildroot-9.3.0-2020.03-x86_64_aarch64-rockchip-linux-gnu/bin/
# export CC=aarch64-rockchip930-linux-gnu-gcc
# export CXX=aarch64-rockchip930-linux-gnu-g++

sudo ./configure --host=aarch64-rockchip-linux-gnu --prefix=/usr/local/ncurses-6.1-arm　CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++
# or
# sudo ./configure --host=aarch64-rockchip930-linux-gnu --prefix=/usr/local/ncurses-6.1-arm
make
make install
```

-   cc.sh

<!--listend-->

```bash
#!/bin/sh
 export PATH=$PATH:/home/daoyi/techyauld/xj-arm/prebuilts/gcc/linux-x86/aarch64/gcc-buildroot-9.3.0-2020.03-x86_64_aarch64-rockchip-linux-gnu/bin/
 export CC=aarch64-rockchip930-linux-gnu-gcc
 export CXX=aarch64-rockchip930-linux-gnu-g++
```


### mysql(arm) {#mysql--arm}

```bash
tar -xf mysql-boost-5.7.27.tar.gz
cd mysql-5.7.27/BUILD_ARM/

vim compile-arm

# copy utils compiled on x86
sudo cp ../../mysql-5.7.27-PC/BUILD/extra/comp_err ./extra/
sudo cp ../../mysql-5.7.27-PC/BUILD/libmysql/libmysql_api_test ./libmysql
sudo cp ../../mysql-5.7.27-PC/BUILD/scripts/comp_sql ./scripts/
sudo cp ../../mysql-5.7.27-PC/BUILD/sql/gen_lex_hash ./sql/
sudo cp ../../mysql-5.7.27-PC/BUILD/sql/gen_lex_token ./sql/
sudo cp ../../mysql-5.7.27-PC/BUILD/extra/protobuf/protoc ./extra/protobuf/

# 解决库版本报错问题
sudo ln -s /usr/lib64/libisl.so.23.3.0 /usr/lib64/libisl.so.15
sudo ln -s /usr/lib64/libmpfr.so.6.2.1 /usr/lib64/libmpfr.so.4
sudo ./compile-arm
```

-   compile-arm

<!--listend-->

```bash
#! /bin/sh
path ='dirname $0'
source ../../cc.sh
cmake .. -DWITH_DEBUG=0 \
                    -DSTACK_DIRECTION=1 \
                    -DENABLE_DOWNLOADS=1 \
                    -DDOWNLOAD_BOOST=1 \
                    -DDEFAULT_CHARSET=utf8 \
                    -DDEFAULT_COLLATIOIN=utf8_general_ci \
                    -DEXTRA_CHARSETS=all \
                    -DENABLED_LOCAL_INFILE=1  \
                    -DWITH_BOOST=../boost/boost_1_59_0 \
                    -DCMAKE_CXX_COMPILER=${CXX} \
                    -DCMAKE_C_COMPILER=${CC} \
                    -DCURSES_INCLUDE_PATH=/usr/local/ncurses-6.1-arm/include \
                    -DCURSES_LIBRARY=/usr/local/ncurses-6.1-arm/lib/libncurses.a
```


### tirpc（cross-compile-tool） {#tirpc-cross-compile-tool}

```bash
cd libtirpc-0.2.2
cd j
source ../cc.sh

# sudo ./configure --host=aarch64-rockchip930-linux-gnu --prefix=/usr/local/libtirpc-arm CC=$CC CXX=$CXX
#sudo ./configure --host=aarch64-linux-gnu --prefix=/usr/local/libtirpc-arm CC=$CC CXX=$CXX
# 以上host不能被识别， 修改为arm-linux： OK
sudo ./configure --host=arm-linux --prefix=/usr/local/libtirpc-arm CC=$CC CXX=$CXX
make -j4
```

make 报 nis.h 文件：fatal error: rpcsvc/nis.h: No such file or directory。


## 参考说明 {#参考说明}

-   [mysql交叉编译，移植至ARM](https://blog.csdn.net/qq_40405760/article/details/129037611)
-   [问题解决方法：aarch64-linux-gnu/bin/ld: cannot find -lxxx](https://blog.csdn.net/u014248033/article/details/109359024)
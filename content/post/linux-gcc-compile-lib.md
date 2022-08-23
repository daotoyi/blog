---
title: "Linux gcc/g++"
date: "2022-08-02 22:47:00"
lastmod: "2022-08-07 22:39:29"
tags: ["libs"]
categories: ["Cplus"]
draft: false
---

## gcc 工作流程 {#gcc-工作流程}

<https://img-blog.csdn.net/20180703103940467?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2RhaWRhaWhlbWE=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70>

常用参数

```bash
-v	查看版本
-o	产生目标文件
-I+ 目录	指定头文件目录
-D	编译时定义宏
-00/-01/-03	没有优化/缺省值/优化级别最高
-Wall	提示更多警告信息
-c	只编译子程序
-E	生成预处理文件
-g	包含调试信息
```


## 静态库 {#静态库}

-   在 Linux 发行版系统中，静态链接库文件的后缀名通常用 .a 表示；
-   在 Windows 系统中，静态链接库文件的后缀名为 .lib

<!--listend-->

```bash
+--- include
|   +--- head.h
+--- lib
|   +--- main.c
+--- src
|   +--- add.c
|   +--- div.c
|   +--- mul.c
|   +--- sub.c
```


### 编译 o 文件 {#编译-o-文件}

将所有指定的源文件，都编译成相应的目标文件。

```c
gcc *.c -c -I../include

// ls *.o
add.o  div.o mul.o sub.o
```


### 创建静态库 {#创建静态库}

```c
ar rcs libMyTest.a *.o
mv libMyTest.a ../lib
nm libMyTest.a  // 查看库中包含的函数等信息
```

-   r 将文件插入静态库中
-   c 创建静态库，不管库是否存在
-   写入一个目标文件索引到库


### 使用静态库 {#使用静态库}


#### 第一种方法： {#第一种方法}

```bash
gcc + 源文件 + -L 静态库路径 + -l静态库名 + -I头文件目录 + -o 可执行文件名
gcc main.c -L lib -l MyTest -I include -o app
./app
```


#### 第二种方法： {#第二种方法}

```bash
gcc + 源文件 + -I头文件 + libxxx.a + -o 可执行文件名
gcc main.c -I include lib/libMyTest.a -o app
```


## 动态库 {#动态库}

-   在 Linux 发行版系统中，动态链接库的后缀名通常用 .so 表示；
-   在 Windows 系统中，动态链接库的后缀名为 .dll；


### 编译 o 文件（与位置无关） {#编译-o-文件-与位置无关}

```bash
gcc -fPIC *.c -I ../include -c   # 参数-fPIC表示生成与位置无关代码
```


### 创建动态库 {#创建动态库}

```bash
gcc -shared -o libMyTest.so *.o        # 参数：-shared 制作动态库 -o：重命名生成的新文件
mv libMyTest.so ../lib
```


### 使用动态库 {#使用动态库}


#### 第一种方法： {#第一种方法}

```bash
gcc + 源文件 + -L 动态库路径 + -l动态库名 + -I头文件目录 + -o 可执行文件名
gcc main.c -L lib -l MyTest -I include -o app
./app
# （执行失败，找不到链接库，没有给动态链接器（ld-linux.so.2）指定好动态库 libmytest.so 的路径）
```

-   export LD_LIBRARY_PATH=自定义动态库的路径
-   将 libmytest.so 所在绝对路径追加入到 **/etc/ld.so.conf** 文件，使用 **sudo ldconfig -v**  更新


#### 第二种方法： {#第二种方法}

```bash
gcc + 源文件 + -I头文件 + libxxx.so + -o 可执行文件名
gcc main.c -I include lib/libMyTest.so -o app
# （执行成功，已经指明了动态库的路径）
```
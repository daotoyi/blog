+++
title = "make, cmake, qmake"
lastmod = 2022-04-15T09:37:46+08:00
categories = ["Linux"]
draft = true
+++

## make {#make}

make 是用来执行 Makefile 的, Makefile 是类 unix 环境下(比如 Linux)的类似于批处理的"脚本"文件。

其基本语法是:  **目标+依赖+命令** ，只有在目标文件不存在，或目标比依赖的文件更旧，命令才会被执行。

由此可见，Makefile 和 make 可适用于任意工作，不限于编程.

Makefile+make 可理解为类 unix 环境下的项目管理工具，但它太基础了，抽象程度不高，而且在 windows 下不太友好(针对 visual studio 用户)，于是就有了跨平台项目管理工具 cmake.

make 工具可以看成是一个智能的批处理工具，它本身并没有编译和链接的功能，而是用类似于批处理的方式—通过调用 makefile 文件中用户指定的命令来进行编译和链接的。


## cmake {#cmake}

cmake 是跨平台项目管理工具，它用更抽象的语法来组织项目。

cmake 是抽象层次更高的项目管理工具，cmake 命令执行的 CMakeLists.txt 文件.


## qmake {#qmake}

qmake 是 Qt 专用的项目管理工具，对应的工程文件是\*.pro，在 Linux 下面它也会生成 Makefile.


## conclusion {#conclusion}

-   make 用来执行 Makefile，
-   cmake 用来执行 CMakeLists.txt，
-   qmake 用来处理\*.pro 工程文件。
-   Makefile 的抽象层次最低，
-   cmake 和 qmake 在 Linux 等环境下最后还是会生成一个 Makefile。
-   cmake 和 qmake 支持跨平台，cmake 的做法是生成指定编译器的工程文件，而 qmake 完全自成体系。
-   cmake 也是同样支持 Qt 程序的，cmake 也能生成针对 qt 程序的那种特殊 makefile
-   cmake 的 CMakeLists.txt 写起来相对与 qmake 的 pro 文件复杂点。
-   qmake 是为 Qt 量身打造的，使用起来非常方便，但是 cmake 功能比 qmake 强大。


## windowscmake {#windowscmake}

```bash
# 打印出所有generator
cd build/;
cmake .. -G

# 生成unix下的MakeFiles
cd build/
cmake .. -G "Unix Makefiles"

# 简化-G "Unix Makefiles"（cmake ..）,在CMakeLists.txt文件的同级目录下，写入PreLoad.cmake文件内容。

set(CMAKE_GENERATOR "Unix Makefiles" CACHE INTERNAL "" FORCE)

# 编译exe
make
```


## Ref {#ref}

-   [make, cmake, qmake 这些到底是什么鬼](https://developer.aliyun.com/article/664947)
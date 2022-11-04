---
title: "Linux Qt"
date: "2022-11-02 20:18:00"
lastmod: "2022-11-02 20:18:36"
categories: ["Linux"]
draft: false
---

## basic {#basic}

-   pro 文件
    -   用来告诉 qmake 如何生成 makefile。
        -   如该项目有哪些源文件和头文件，该应用程序的特定配置，
        -   比如需要链接的额外的库，或者一个额外的包含路径，这些都应该放在项目文件中。

<!--listend-->

```bash
qmake  xxx.pro 		//生成makefile文件  (移植的qt)
make 				//编译生成可执行文件 （生成arm开发板下可执行文件）
```


## configure {#configure}

QT 的源码所在目录下，再进到 qws 目录下 `cd mkspecs/qws`.

查看是否有适合我们的配置目录 `linux-arm-gnueabi-g++` ，如果没有，就自己建一个目录，然后 mkspecs/目录下的其他拷贝两个文件 `qmake.conf` 和 `qplatformdefs.h` 。

之后进入到 linux-arm-gnueabi-g++目录，修改 qmake.conf 的编译器位置，如下：

```cfg
QMAKE_CC                = arm-none-linux-gnueabi-gcc
QMAKE_CXX               = arm-none-linux-gnueabi-g++
QMAKE_LINK              = arm-none-linux-gnueabi-g++
QMAKE_LINK_SHLIB        = arm-none-linux-gnueabi-g++

# modifications to linux.conf
QMAKE_AR                = arm-none-linux-gnueabi-ar cqs
QMAKE_OBJCOPY           = arm-none-linux-gnueabi-objcopy
QMAKE_STRIP             = arm-none-linux-gnueabi-strip
```

./mktarget 生成的文件解压在目标系统的根目录中，可在/usr/local/Trolltech/QtEmbedded-x.x.x-arm/bin 中找到 qmake。


## FAQ {#faq}


### Basic XLib functionality test failed! {#basic-xlib-functionality-test-failed}

sudo apt-get install libxext-dev


### mark 时/usr/bin/ld: cannot find -lXext {#mark-时-usr-bin-ld-cannot-find-lxext}

sudo apt-get install libxt-dev


### mark 时 /usr/bin/ld: cannot find -lXrender {#mark-时-usr-bin-ld-cannot-find-lxrender}

sudo apt-get install libxrender-dev


### 出现 X11/extensions/Xdamage.h: No such file or directory {#出现-x11-extensions-xdamage-dot-h-no-such-file-or-directory}

sudo apt-get install libxdamage-dev


### <span class="org-todo done DONE">DONE</span> About QtOpenGL {#about-qtopengl}

If try -opengl then: All the OpenGL functionality tests failed!

sudo apt-get install libgl1-mesa-dev libglu1-mesa-dev


### About QtDBus {#about-qtdbus}

If try -dbus then:The QtDBus module cannot be enabled because libdbus-1 version 0.93 was not found

sudo apt-get install libdbus-1-dev
sudo apt-get install libedbus-dev


### gconf {#gconf}

sudo apt-get install libgconf2-dev


### icu {#icu}

sudo apt-get install libicu-dev


## Ref {#ref}

-   [编译 arm 版的qt](https://www.cnblogs.com/wanghuaijun/p/7746560.html)
-   [Qt5.12.0 交叉编译搭建](https://www.codeprj.com/blog/9beb661.html)
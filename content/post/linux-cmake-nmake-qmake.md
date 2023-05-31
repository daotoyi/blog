---
title: "Linux cmake nmake qmake 的区别联系"
date: "2023-05-31 16:37:00"
lastmod: "2023-05-31 16:37:37"
categories: ["Linux"]
draft: false
---

## 基本概念 {#基本概念}


### gcc {#gcc}

是 GNU Compiler Collection（就是 GNU 编译器套件），也可以简单认为是编译器，它可以编译很多种编程语言（括 C、C++、Objective-C、Fortran、Java 等等）。

当你的程序只有一个源文件时，直接就可以用 gcc 命令编译它。 但是当你的程序包含很多个源文件时，用 gcc 命令逐个去编译时，你就很容易混乱而且工作量大, 所以出现了 make 工具, make 工具可以看成是一个智能的批处理工具，它本身并没有编译和链接的功能，而是用类似于批处理的方式—通过调用 makefile 文件中用户指定的命令来进行编译和链接的。


### makefile {#makefile}

简单的说就像一首歌的乐谱，make 工具就像指挥家，指挥家根据乐谱指挥整个乐团怎么样演奏，make 工具就根据 makefile 中的命令进行编译和链接的。

makefile 命令中就包含了调用 gcc（也可以是别的编译器）去编译某个源文件的命令。makefile 在一些简单的工程完全可以人工手下，但是当工程非常大的时候，手写 makefile 也是非常麻烦的，如果换了个平台 makefile 又要重新修改。

这时候就出现了 Cmake 这个工具，cmake 就可以更加简单的生成 makefile 文件给上面那个 make 用。当然 cmake 还有其他功能，就是可以跨平台生成对应平台能用的 makefile，你不用再自己去修改了。可是 cmake 根据什么生成 makefile 呢？它又要根据一个叫 CMakeLists.txt 文件（学名：组态档）去生成 makefile。到最后 CMakeLists.txt 文件谁写啊？是你自己手写的。如果你用 IDE，类似 VS 这些一般它都能帮你弄好了，你只需要按一下那个三角形.


### qmake {#qmake}

qmake 是什么，先说一下 Qt 这个东西。Qt 是跨平台 C++图形用户界面应用程序开发框架。它既可以开发 GUI 程序，也可用于开发非 GUI 程序，比如控制台工具和服务器。简单的说就是 C++的第三方库，使用这个库你可以很容易生成 windows，Linux，MAC os 等等平台的图形界面。现在的 Qt 还包含了开发各种软件一般需要用到的功能模块（网络，数据库，XML，多线程啊等等），比你直接用 C++（只带标准内裤那种）要方便和简单。

你可以用 Qt 简简单单就实现非常复杂的功能，是因为 Qt 对 C++进行了扩展，你写一行代码，Qt 在背后帮你写了几百上千行，而这些多出来的代码就是靠 Qt 专有的 moc 编译器（The Meta-Object Compiler）和 uic 编译器（User Interface Complier）来重新翻译你那一行代码。问题来了，你在进行程序编译前就必须先调用 moc 和 uic 对 Qt 源文件进行预处理，然后再调用编译器进行编译。上面说的那种普通 makefile 文件是不适用的，它没办法对 qt 源文件进行预处理。所以 qmake 就产生了。

qmake 工具就是 Qt 公司制造出来，用来生成 Qt 专用 makefile 文件，这种 makefile 文件就能自动智能调用 moc 和 uic 对源程序进行预处理和编译。qmake 当然必须也是跨平台的，跟 cmake 一样能对应各种平台生成对应 makefile 文件。

qmake 是根据 Qt 工程文件（.pro）来生成对应的 makefile 的。pro 文件用来告诉 qmake 如何生成 makefile。如该项目有哪些源文件和头文件，该应用程序的特定配置，比如需要链接的额外的库， 或者一个额外的包含路径，这些都应该放在项目文件中。工程文件（.pro）相对来说比较简单，一般工程你都可以自己手写，但是一般都是由 Qt 的开发环境 Qt Creator 自动生成的，你还是只需要按下那个邪恶三角形就完事了。

由于 qmake 很简单很好用又支持跨平台，而且是可以独立于它的 IDE，所以你也可以用在非 Qt 工程上面，照样可以生成普通的 makefile，只要在 pro 文件中加入 CONFIG -= qt 就可以了。


### nmake {#nmake}

它处理 makefile 文件，解释里边的语句并执行相应的指令。 调用 NMAKE 时，它会检查所有相关的文件，如果目标文件的时间戳小于依赖文件的，那 nmake 就执行该依赖关系相关联的操作。

```makefile
foo.exe : first.obj  second.obj
link first.obj, second.obj
```

第一行定义了依赖关系；第二行给出了该依赖关系相关联的操作。 如果 first.obj 和 second.obj 任何一个修改了，那就得调用 link.exe，重新链接生成 foo.exe。 这就是 nmake 的执行逻辑。

nmake 就相当于一个解释程序，makefile 是一个编程语言，写的程序(makefile 文件)由 nmake 来解释执行.


## qmake 和 cmake {#qmake-和-cmake}

-   cmake 也是同样支持 Qt 程序的，cmake 也能生成针对 qt 程序的那种特殊 makefile，只是 cmake 的 CMakeLists.txt 写起来相对与 qmake 的 pro 文件复杂点。
-   qmake 是为 Qt 量身打造的，使用起来非常方便，但是 cmake 功能比 qmake 强大。一般的 Qt 工程你就直接使用 qmake 就可以了，cmake 的强大功能一般人是用不到的。


## cmake nmake qmake {#cmake-nmake-qmake}

-   make 用来执行 Makefile
-   cmake 用来执行 CMakeLists.txt，
-   qmake 用来处理\*.pro 工程文件。
-   Makefile 的抽象层次最低，cmake 和 qmake 在 Linux 等环境下最后还是会生成一个 Makefile。
-   cmake 和 qmake 支持跨平台
    -   cmake 的做法是生成指定编译器的工程文件
    -   而 qmake 完全自成体系。
-   nmake 一般用于 windows 系统 vs 的编译。

-   cmake\qmake -- 跨平台 -- 生成 MakeFile
-   nmake -- windows vs -- 生成 MakeFile
-   make -- MakeFile

    {{< figure src="https://raw.githubusercontent.com/daotoyi/picsbed/main/img/202305311637437.jpeg" >}}
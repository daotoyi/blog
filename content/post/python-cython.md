---
title: "Cython"
date: "2022-07-01 11:53:00"
lastmod: "2022-07-01 11:53:58"
categories: ["Python"]
draft: false
---

## 需求背景 {#需求背景}

-   不得不编写一些多重嵌套的循环，C 语言来实现会快上百倍
-   至少在数字计算方面，能够加入可选的静态类型，这样可以极大地加速运算效果。
-   对于一些计算密集型的部分，希望能够写出一些媲美 Numpy, Scipy, Pandas 的算法；
-   有一些已经用 C、C++ 实现的库，想直接在 Python 内部更好地调用它们，并且不使用 ctypes、cffi 等模块


## Cython {#cython}

Cython 是一门编程语言，它将 C 和 C++ 的静态类型系统融合在了 Python 身上。Cython 源文件的后缀是 .pyx，它是 Python 的一个超集，语法是 Python 语法和 C 语法的混血。

编写完 Cython 代码时，需要先将 Cython 代码翻译成高效的 C 代码，然后再将 C 代码编译成 Python 的扩展模块。

Cython 和 Python 的语法非常相似，我们只需要编写 Cython 代码，然后再由 Cython 编译器将 Cython 代码翻译成 C 代码即可。所以从这个角度上说，拿 C 写扩展和拿 Cython 写扩展是等价的。
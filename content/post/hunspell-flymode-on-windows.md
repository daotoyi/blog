+++
title = "flymode 在 windows 上使用总结"
date = 2022-02-18T11:07:00+08:00
tags = ["hunspell"]
categories = ["emacs"]
draft = false
+++

## ENV {#env}

-   win10
-   emacs-27.1
-   spacemacs


## foreword {#foreword}

spell-checking flymode export error.

spacemacs 需要 aspell0.6 以上的版本，但是 [Latest Version: GNU Aspell-0.50.3 (win32)（Released Dec 22, 2002）](http://aspell.net/win32/).


## Aspell {#aspell}

找到 [Aspell6](https://wiki.lyx.org/uploads/Windows/Aspell6/) 的字典包，但未找到程序包,也是不能用.


## [hunspell](https://github.com/hunspell/hunspell) {#hunspell}

需要在 Linux, Mac, Window 上编译使用. windows 编译繁琐.

通过 stack overflows 找到安装包, 使用效果 well.

-   [ispell/hunspell/Windows: a fully-worked example](https://lists.gnu.org/archive/html/help-gnu-emacs/2014-04/msg00030.html)
-   [hunspell(win)-download-url](https://jaist.dl.sourceforge.net/project/ezwinports/hunspell-1.3.2-3-w32-bin.zip)
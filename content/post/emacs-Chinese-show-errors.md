---
title: "Emacs 中文显示乱码"
date: "2023-10-06 19:33:00"
lastmod: "2023-10-06 19:33:44"
categories: ["emacs"]
draft: false
---

## [Emacs](https://so.csdn.net/so/search?q=Emacs&spm=1001.2101.3001.7020)打开中文乱码

有时使用emacs打开文件的时候，会显示[乱码](https://so.csdn.net/so/search?q=%E4%B9%B1%E7%A0%81&spm=1001.2101.3001.7020)。原因是emacs默认编码跟文档编码不同而出现了乱码。

### 1 当前[buffer](https://so.csdn.net/so/search?q=buffer&spm=1001.2101.3001.7020)调整编码

> M-x revert-buffer-with-coding-system)
> 或者快捷键C-x <RET> r

指定的编码重新读入这个文件即可。
**一般乱码都是因为emacs下使用latin或者utf8，而打开的文档是gb2312编码。**

### 2 配置文件自动判断

[Unicad EmacsWiki 地址](https://www.emacswiki.org/emacs/Unicad)
[Unicad 下载地址](https://code.google.com/archive/p/unicad/)
将下载的unicad.el放在load-path变量的目录里，在.emacs文件中加载发即可（require 'unicad）。

[参考:emacs打开乱码解决办法](https://www.cnblogs.com/codeblock/p/4742110.html)
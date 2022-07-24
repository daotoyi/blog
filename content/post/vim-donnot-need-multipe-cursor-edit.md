---
title: "vim 不需要多光标编辑"
date: "2022-02-12 14:54:00"
lastmod: "2022-07-13 10:21:51"
categories: ["VIm"]
draft: false
---

\*\*
前言
Sublime text 首次引入了多光标编辑功能 1 （据我所知），这意味着可以在多个光标位置同时编辑代码。Vim 有个插件（vim-multiple-cursors ）模仿这一功能，但是存在一些问题。自动补全功能失效，撤销历史与我想象中的不一样，也无法把文本操作映射到某按键，以便在下次 Vim 会话中使用。还有，很难用眼睛跟踪所有光标，特别是当它们处于不同列的时候。使用该插件一段时间后，我得出结论：没有什么操作场景是 原生 Vim 特性无法完成的.

{{< figure src="https://daotoyi.cn/img/20220224150901.png" >}}


## 在 N 个位置修改单词 {#在-n-个位置修改单词}

通过 `gn` 文本对象来完成。

首先搜索想要修改的单词，再使用 `cgn` 命令修改下一处，然后再使用 Vim 最强大的 `.` 点命令。

使用 . 你可以将修改应用到下一处，或者使用 n 跳过一处到下一个匹配处。

<style>.org-center { margin-left: auto; margin-right: auto; text-align: center; }</style>

<div class="org-center">



{{< figure src="https://daotoyi.cn/img/20220224150959.png" >}}

</div>

[sourcelink](https://macplay.github.io/images/cgn_and_dot.gif)

和其它文本对象一样， gn 可以与所有的命令协同工作。比如，你可以与 d 合用删除匹配的单词。


## 修改可视区域 {#修改可视区域}

在 Vim 中，visual-block 被用来完成各种修改。与其它编辑器不同的是，如果你修改了区块的第一行文字，那么当结束操作时这些修改也会被应用到其它所有行。

<style>.org-center { margin-left: auto; margin-right: auto; text-align: center; }</style>

<div class="org-center">

{{< figure src="https://daotoyi.cn/img/20220224151042.png" >}}

</div>

[sourcelink](https://macplay.github.io/images/change_visual_block.gif)


## 基于多行的复杂修改 {#基于多行的复杂修改}

{{< figure src="https://daotoyi.cn/img/20220224151229.png" >}}

以下是一些达到该目标的技巧：

-   记录宏的时候，将跳转到行首作为第一个操作。

-   使用 `f` 或 `t` 跳转到你想更改的位置。

-   避免使用方向键或 hjkl 。并非所有行都是相同宽度，使用 `w , e , b` 要稍微好一点。


## 使用宏 {#使用宏}


## Reference {#reference}

-   [You don’t need more than one cursor in vim](https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db)
-   [vim 不需要多光标编辑](https://macplay.github.io/posts/vim-bu-xu-yao-duo-guang-biao-bian-ji-gong-neng/)
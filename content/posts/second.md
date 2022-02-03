---
title: "Second"
Author: daoyi
date: 2022-02-03T11:17:37+08:00
tags[]: markdown, org
categories[]: code
---

# 简述

采用 markdown 在 Hugo + Github 部署的静态网站上记录个人博客。

# Hugo

- Hugo 是由 Go 语言实现的静态网站生成器。
- 简单、易用、高效、易扩展、快速部署。

# Github

github pages

- 完全免费
- 可以绑定域名
- 使用免费的 HTTPS
- 自己 DIY 网站的主题
- 使用他人开发好的插件

# markdown

记录markdown语法及org-mode语法的一些异同.

## Edit
EDIT|Org|MarkDown|show
-|:-|:-|:-
粗体|`*粗体*` | `**粗体**` or `__粗体__`|**粗体**
斜体 | `/斜体/` | `*斜体* ` or `_斜体_`|*斜体*
 删除线 | `+删除线+` | `~~删除线~~` |~~删除线~~
下划线 | `_下划线_` | `<u>下划线</u>` |<u>下划线</u>
等宽 | `=一字不差=` or `~代码~` | `` `一字不差` `` |`一字不差`
小号字体 |  | `<small>小号字体</small>` |<small>小号字体</small> 
大号字体 | | `<big>大号字体</big>` | <big>大号字体</big>
2 号字 |  | `<font size=2>2号字</font>` | <font size=2>2号字</font>
字体 |  | `<font face="隶书">这是隶书</font>` | <font face="隶书">这是隶书</font>
5号红色华文彩云 |  | <`font face="华文彩云" color=#FF0000 size=5>5号红色华文彩云</font>` | <font face="华文彩云" color=#FF0000 size=5>5号红色华文彩云</font>`
颜色字体 | | `$\color{gold}{金色}$` | $\color{gold}{金色}$

## Latex
LATEX |Org|MarkDown|show
-|:-|:-|-
编号| `$a^2+b^2=c^2$` 或者 `\(a^2+b^2=c^2\)`| `$a^2+b^2=c^2$`|$a^2+b^2=c^2$
不编号| `$$a^2+b^2=c^2$&` 或者 `\[a^2+b^2=c^2\]`| `$$a^2+b^2=c^2$$`|$a^2+b^2=c^2$

## Latex - org
```js
\begin{equation}
\label{eq.mass-energy}
E=mc^2
\end{equation}
```
>`\label{eq.mass-energy}`是公式的身份标记，`eq.mass-energy` 是公式唯一的名字。在文中其他位置通过` \eqref{eq.mass-energy}` 即可引用此公式。

## Latex - markdown
```js
<a id="eq.mass-energy"></a>
$$
E=mc^2
\tag{num}
$$
```
>第一行定义`索引 id`，`num` 是公式的手动编号，在文中可通过 `[num](#eq.mass-energy) `进行引用。

## Link
LINK |Org|MarkDown|show
-|:-|:-|-
-|`[[Link][Description]]`| `[Description](Link)`|[Description](Link)

## Figure - org
```js
#+CAPTION: 标题说明（图表标题）
#+NAME: fig.pic-name
[[./img/a.jpg]]
```

## Figure - markdown
```js
![Description](图片的网络地址或是本地路径)
```
`or`
```js
<a id="fig.pic-name"></a>
<center>
    <img  src="图片的网络地址或是本地路径"  width="300px"  alt="alt name">
    <div>图 1: 图片标题</div>
</center><br>
```

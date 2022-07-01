---
title: "Hugo 使用 orgmode(ox-hugo)"
date: "2022-02-01 08:37:00"
lastmod: "2022-06-29 12:12:04"
tags: ["Hugo"]
categories: ["VPS"]
draft: false
toc: true
---

## 简述 {#简述}

采用 `emacs org-mde` 在 `Hugo + Github` 部署的静态网站上记录个人博客。


## Org-mode {#org-mode}


### Read More {#read-more}

生成的文章要支持 Read More ，在需要分割的地方添加 `#more` (中间有空格)即可。


### meta {#meta}

```org
#+title: First-orgmode
#+Author: daoyi
#+date: 2022-02-03T10:41:17+08:00
#+tags[]: org, hugo, emacs
#+categories[]: emacs
```


### titile {#titile}

```org
* 一级标题
** 二级标题
```


### code {#code}


#### cmd {#cmd}

```org
M-x
org-insert-structure-template
```


#### hotkey {#hotkey}

在 spacemacs 中，使用快捷键 , i b 会弹出一个 minor 窗口，键入 s 即会在光标位置插入代码块，根据实际补充语言名称，最后会生成对应的高亮效果。

-   原始内容

<!--listend-->

```org
#+begin_src python
def hello():
  return "hello world"

return hello()
```

-   渲染效果

<!--listend-->

```python
def hello():
  return "hello world"

return hello()
```


### image {#image}

```org
[[/images/emacs/insert-source-code-block.png]]
```


### table {#table}

-   原始内容

<!--listend-->

```org
| A | B | C |
|---+---+---+
| a | b | c |
```

-   渲染效果

| A | B | C |
|---|---|---|
| a | b | c |


### footnote {#footnote}

spacemacs 添加脚注的快捷键是 `, i f` 。


#### sytax {#sytax}

```org
[1]
　　纯数字脚注。和 footnote.el 兼容但是不建议，因为代码段里常常出现[1]
[fn:名字]
　　命名的脚注参考，名字是唯一的标签，或者可以自动地创建成数字。
[fn::内联定义]
　　LaTeX-like 的匿名脚注，定义直接在引用点（reference point）给出。
[fn:名字:定义]
　　一个内联的 fotnote，也指定名字作为提示。
    因为 Org 允许多个引用指向同一个名字，你可以用[fn:name]来创建额外的引用。
```


#### example {#example}

```org
在这行添加第一个脚注[fn:1]。

在这行添加第二个脚注[fn:2]。
```


### org-mode 转义 {#org-mode-转义}

&vert; 这样的符号在 org 里是需要转义，可以在 spacemacs 中键入 `SPC SPC` ，输入 `org-entities-help` 找到对应的转义码。

<style>.org-center { margin-left: auto; margin-right: auto; text-align: center; }</style>

<div class="org-center">

{{< figure src="https://kangxiaoning.github.io/images/emacs/org-entities-help.png" >}}

</div>


## 隐藏 todo 时间戳 {#隐藏-todo-时间戳}

在切换任务状态时，会有活动状态变更 log 记录，在 ox-hugo 导出时，这些记录显示会显示网页中.

设置属性,保留这些记录，导出时，ox-hugo 又可以忽略这些记录

```org
:PROPERTIES:
:LOG_INTO_DRAWER: t
:END
```

当该属性开启状态时，日志信息会自动添加到 LOGBOOK 中，此时在执行导出，状态记录会被自动忽略。


### Ref {#ref}

-   [隐藏todo 状态转换之后的时间戳的方法](https://it-boyer.github.io/post/%E5%8D%9A%E5%AE%A2%E7%AB%99%E5%8A%A1/ox-hugo%E5%B7%A5%E5%85%B7%E7%BB%8F%E9%AA%8C%E7%A7%AF%E7%B4%AF/#%E5%AF%BC%E5%87%BA%E6%97%B6todo-%E7%8A%B6%E6%80%81%E9%9A%90%E8%97%8F%E7%9A%84%E9%97%AE%E9%A2%98)


## 头部文件说明 {#头部文件说明}

```org
# -*- mode: snippet -*-
# name: hugo_blog
# key: <hugo
# --

#+OPTIONS: author:nil ^:{}
#+hugo_front_matter_format: yaml
#+HUGO_BASE_DIR: ../
#+HUGO_SECTION: posts/`(format-time-string "%Y/%m")`
#+DATE: `(format-time-string "[%Y-%m-%d %a %H:%M]")`
#+HUGO_CUSTOM_FRONT_MATTER: :toc true
#+HUGO_AUTO_SET_LASTMOD: t
#+HUGO_TAGS: $1
#+HUGO_CATEGORIES: $2
#+HUGO_DRAFT: false
#+TITLE: $3

$0
```


## Hugo {#hugo}

-   Hugo 是由 Go 语言实现的静态网站生成器。
-   简单、易用、高效、易扩展、快速部署。


### Github {#github}

github pages

-   完全免费
-   可以绑定域名
-   使用免费的 HTTPS
-   自己 DIY 网站的主题
-   使用他人开发好的插件
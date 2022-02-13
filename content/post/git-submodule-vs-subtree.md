+++
title = "git submodule VS subtree"
date = 2022-02-12T09:49:00+08:00
lastmod = 2022-02-12T10:20:59+08:00
tags = ["git"]
categories = ["Github"]
draft = false
+++

-   State "DONE"       from "TODO"       <span class="timestamp-wrapper"><span class="timestamp">[2022-02-12 周六 09:49]</span></span>


## 仓库共用 {#仓库共用}

两种子仓库使用方式

1.  git submodule(子模块)
2.  git subtree(子树合并)

git subtree 本质就是把子项目目录作为一个普通的文件目录，对于父级的主项目来说是完全透明的，原来是怎么操作现在依旧是那么操作.

无法直接单独查看子仓库的修改记录，因为子仓库的修改包含在父仓库的记录中了。

**官方推荐 subtree.**


## 使用 {#使用}

-   语法：
    `git subtree add --prefix=<子目录名> <子仓库名> <分支> --squash`

-   实例：
    `git subtree add --prefix=component component master --squash`

会在本地新建一个叫 `component` 的文件夹， `--squash` 会把 subtree 上的改动合并成一次 commit

-   pull：
    `git subtree pull --prefix=component component master --squash`

-   push：
    `git subtree push --prefix=component component master --squash`

注意: \*\*必须在 `component` 的父级目录执行\*\*，使用起来还不是很方便。
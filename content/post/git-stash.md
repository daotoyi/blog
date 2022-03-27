+++
title = "git stash"
lastmod = 2022-03-26T09:06:43+08:00
categories = ["Github"]
draft = true
+++

git stash 命令用于将更改储藏在脏工作目录中。


## useage {#useage}

```shell
git stash # git stash save
git stash list # 列出
git stash show # 进行检查
git stash apply # 恢复
git stash apply stash@{2}
git stash drop stash@{2} # 移除储藏
git stash pop # 恢复上一次的stash
```
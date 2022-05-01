---
title: "Git 操作对比"
date: "2022-03-26 09:48:00"
lastmod: "2022-04-30 12:32:02"
tags: ["git"]
categories: ["Github"]
draft: false
---

## chechkout VS reset VS revert {#chechkout-vs-reset-vs-revert}

| 命令         | 作用域 | 常用情景          |
|------------|-----|---------------|
| git reset    | 提交层面 | 在私有分支上舍弃一些没有提交的更改 |
| git reset    | 文件层面 | 将文件从缓存区中移除 |
| git checkout | 提交层面 | 切换分支或查看旧版本 |
| git checkout | 文件层面 | 舍弃工作目录中的更改 |
| git revert   | 提交层面 | 在公共分支上回滚更改 |
| git revert   | 文件层面 | （木有）          |


### reset {#reset}

```shell
git commit   --amend       # 撤销上一次提交  并讲暂存区文件重新提交
git reset HEAD  -- <file>  # 拉取最近一次提交到版本库的文件到暂存区,操作不影响工作区
git checkout -- <file>     # 拉取暂存区文件 并将其替换成工作区文件

## 删除暂存区和工作区的文件
git rm file_path

## 仅仅删除暂存区里的文件
git rm --cached file_path

# 仅仅只是撤销已提交的版本库，不会修改暂存区和工作区
git reset --soft 版本库ID

# 仅仅只是撤销已提交的版本库和暂存区，不会修改工作区
git reset --mixed 版本库ID

# 彻底将工作区、暂存区和版本库记录恢复到指定的版本库
git reset --hard 版本库ID
```


### compare {#compare}

```bash
# 删除未追踪文件
# 删除 untracked files-
$ git clean -f
# 连 untracked 的目录也一起删掉
$ git clean -fd
# 连 gitignore 的 untrack 文件/目录也一起删掉 （慎用，一般这个是用来删掉编译出来的 .o 之类的文件用的）
$ git clean -xfd
# 在用上述 git clean 前，墙裂建议加上 -n 参数来先看看会删掉哪些文件，防止重要文件被误删
$ git clean -nxfd
$ git clean -nf
$ git clean -nfd

# 取消修改（在工作区）：
$ git checkout -- file_name.txt 单个文件
$ git checkout .所有文件

# 取消已暂存的文件：
# 可以使用 git reset HEAD <file>... 的方式取消暂存，返回已修改未暂存的状态：
$ git reset HEAD benchmarks.rb

# 现在将版本退回到合并前,也就是回退一个版本：
$ git reset --hard head^

# 撤销未 push 的 commit 到你想恢复到的 commit_id:
$ git reset --hard commit_id 返回到某个节点，不保留修改。
$ git reset --soft commit_id 返回到某个节点，保留修改。

# 修改最后一次提交：
# 有时候我们提交完了才发现漏掉了几个文件没有加，或者提交信息写错了。想要撤消刚才的提交操作，可以使用 --amend 选项重新提交：
$ git commit --amend
# 如果刚才提交时忘了暂存某些修改，可以先补上暂存操作，然后再运行 --amend 提交：
$ git commit -m 'initial commit'
$ git add forgotten_file
$ git commit --amend

# 撤销某次提交：
git revert 撤销 某次操作，此次操作之前和之后的 commit 和 history 都会保留，并且把这次撤销作为一次最新的提交：
$ git revert HEAD 撤销前一次 commit
$ git revert HEAD^ 撤销前前一次 commit
$ git revert HEAD~n 撤销前 N 次的 commit
$ git revert commit_id （比如：fa042ce57ebbe5bb9c8db709f719cec2c58ee7ff）撤销指定的版本，撤销也会作为一次提交进行保存。

# 不在暂存区的文件撤销更改：
$ git restore test_file.c

# 将暂存区的文件从暂存区撤出：
$ git restore --staged test_file.c
```

---
作者：WorldPeace_hp<br />
链接：<https://www.jianshu.com/p/414ad1eaf44b><br />
来源：简书<br />
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
---
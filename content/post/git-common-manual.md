---
title: "Git 常用操作"
date: "2022-03-27 23:17:00"
lastmod: "2023-12-17 12:29:52"
tags: ["git"]
categories: ["Github"]
draft: false
---

## 常用命令 {#常用命令}

```bash
# 工作区 -> 暂存区
$ git add <file/dir>

# 暂存区 -> 本地仓库
$ git commit -m "some info"

# 本地仓库 -> 远程仓库
$ git push origin master  # 本地master分支推送到远程origin仓库
# 工作区 <- 暂存区
$ git checkout -- <file>  # 暂存区文件内容覆盖工作区文件内容

# 暂存区 <- 本地仓库
$ git reset HEAD <file>   # 本地仓库文件内容覆盖暂存区文件内容

# 本地仓库 <- 远程仓库
$ git clone <git_url>        # 克隆远程仓库
$ git fetch upstream master  # 拉取远程代码到本地但不应用在当前分支
$ git pull upstream master   # 拉取远程代码到本地但应用在当前分支
$ git pull --rebase upstream master  # 如果平时使用rebase合并代码则加上

# 克隆指定版本
# -b 版本标签
# --depth 克隆深度,如果标签迭代的版本很多, 克隆会很慢
git clone -b v5.2.0 --depth=1 <git_url>


# 工作区 <- 本地仓库
$ git reset <commit>          # 本地仓库覆盖到工作区(保存回退文件内容修改)
$ git reset --mixed <commit>  # 本地仓库覆盖到工作区(保存回退文件内容修改)
$ git reset --soft <commit>   # 本地仓库覆盖到工作区(保留修改并加到暂存区)
$ git reset --hard <commit>   # 本地仓库覆盖到工作区(不保留修改直接删除掉)
```

-   push pull

    ```bash
    # 远程 <-> 本地
    git pull origin <远程分支名>:<本地分支名>
    git push origin <本地分支名>:<远程分支名>

    # 远程 <-> 本地
    git pull origin <远程分支名>
    git push origin <本地分支名>

    # 将本地分支与远程同名分支相关联
    # git push -u origin <本地分支名>
    ```


## 配置实用参数 {#配置实用参数}

```bash
# 用户信息
$ git config --global user.name "your_name"
$ git config --global user.email "your_email"

# 文本编辑器
$ git config --global core.editor "nvim"

# 分页器
$ git config --global core.pager "more"

# 别名
$ git config --global alias.gs "git status"

# 纠错
$ git config --global help.autocorrect 1

# 不加--global参数的话，则为个人配置
$ git config --list
$ git config user.name
$ git config user.name "your_name"

# 如果在项目中设置，则保存在.git/config文件里面
$ cat .git/config
[user]
name = "your_name"
```


## 处理工作中断 {#处理工作中断}

```bash
# 存储当前的修改但不用提交commit
$ git stash

# 保存当前状态包括untracked的文件
$ git stash -u

# 展示所有stashes信息
$ git stash list

# 回到某个stash状态
$ git stash apply <stash@{n}>

# 删除储藏区
$ git stash drop <stash@{n}>

# 回到最后一个stash的状态并删除这个stash信息
$ git stash pop

# 删除所有的stash信息
$ git stash clear

# 从stash中拿出某个文件的修改
$ git checkout <stash@{n}> -- <file-path>
```


## 对比文件差异 {#对比文件差异}


### 工作区和暂存区之间文件 {#工作区和暂存区之间文件}

```bash
# 查看工作区和暂存区之间所有的文件差异
git diff

# 查看具体某个文件 在工作区和暂存区之间的差异
git diff -- 文件名

# 查看多个文件在工作区和暂存区之间的差异
git diff -- 文件名1 文件名2 文件名3
```


### 工作区和版本库之间文件 {#工作区和版本库之间文件}

```shell
# 查看工作区与最新版本库之间的所有的文件差异
git diff HEAD

# 查看工作区与具体某个提交版本之间的所有的文件差异
git diff 具体某个版本

# 查看工作区与最新版本库之间的 指定文件名的文件差异
git diff HEAD -- 文件名

# 查看工作区与最新版本库之间的 指定文件名的多个文件差异
git diff HEAD -- 文件名1 文件名2 文件名3

# 查看工作区与具体某个版本之间的指定文件名的文件差异
git diff 具体某个版本 -- 文件名

# 查看工作区与最具体某个版本之间的指定文件名的多个文件差异
git diff 具体某个版本 -- 文件名1 文件名2 文件名j3
```


### 暂存区和版本库之间文件 {#暂存区和版本库之间文件}

```bash
# 查看暂存区和 上一次提交 的最新版本(HEAD)之间的所有文件差异
git diff --cached

# 查看暂存区和 指定版本 之间的所有文件差异
git diff --cached 版本号

# 查看暂存区和 HEAD 之间的指定文件差异
git diff --cached -- 文件名1 文件名2 文件名3

# 查看暂存区和 指定版本 之间的指定文件差异
git diff --cached 版本号 -- 文件名1 文件名2 文件名3
```


### 不同版本库之间文件 {#不同版本库之间文件}

```bash
# 查看两个版本之间的差异
git diff 版本号1 版本号2

# 查看两个版本之间的指定文件之间的差异
git diff 版本号1 版本号2 -- 文件名1 文件名2

# 查看两个版本之间的改动的文件列表
git diff 版本号1 版本号2 --stat

# 查看两个版本之间的文件夹 src 的差异
git diff 版本号1 版本号2 src
```


## 推送拉取所有个分支 {#推送拉取所有个分支}


### push {#push}

```bash
git push REMOTE '*:*'
git push REMOTE --all
git push --all origin
```


### pull {#pull}

```bash
git fetch --all
git pull --all
```


## 合并其他分支文件 {#合并其他分支文件}

```bash
# 当前AA分支， 将BB分支的user.c user.h覆盖到AA分支
git checkout BB user.c user.h
```


## Ref {#ref}

-   [Git实用技巧记录](https://www.escapelife.site/posts/f6ffe82b.html)
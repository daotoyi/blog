+++
title = "Git 常用操作"
date = 2022-03-27T23:17:00+08:00
lastmod = 2022-03-27T23:18:21+08:00
tags = ["git"]
categories = ["Github"]
draft = false
+++

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

# 工作区 <- 本地仓库
$ git reset <commit>          # 本地仓库覆盖到工作区(保存回退文件内容修改)
$ git reset --mixed <commit>  # 本地仓库覆盖到工作区(保存回退文件内容修改)
$ git reset --soft <commit>   # 本地仓库覆盖到工作区(保留修改并加到暂存区)
$ git reset --hard <commit>   # 本地仓库覆盖到工作区(不保留修改直接删除掉)
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


## Ref {#ref}

-   [Git实用技巧记录](https://www.escapelife.site/posts/f6ffe82b.html)
+++
title = "Magit 使用"
date = 2022-02-13T23:35:00+08:00
tags = ["magit"]
categories = ["emacs"]
draft = false
+++

## 基本说明 {#基本说明}

| status           | notes                          |
|------------------|--------------------------------|
| Head             | 当前处于哪个 branch            |
| Push             | 要 push 到哪个远程 branch      |
| Untracked files  | 哪些文件未被 gt 管理           |
| Unstaged Changes | 哪些文件修改了未 stage         |
| Staged Changes   | 哪些文件处于 staged 状态(即运行了 git adc) |
| Unpushed to      | 哪些 commit 未 push 到远程分支 |
| Unpulled from    | 哪些提交未拉取到本地           |


## 常用操作 {#常用操作}

-   `?` 键弹出 提示 buffer,显示各个快捷键
-   `s` 将 unstaged 文件设置为 staged
-   `u` 将 staged 文件设置为 unstage
-   `k` 撤销更改，移动到 staged/unstaged 文件
-   `<TAB>` 可以看见修改的地方
-   `c,c` commit, input commit
-   `C-cc` edit-files-finished
-   `P,p` push remote


## 注意 {#注意}

要将 git 的配置文件 `.gitconfig` 文件放置于 emacs 识别的$HOME 目录下.否则 commit 和 push 会报错

```nil

[gui]
  recentrepo = D:/Program Files (x86)/Git/tmp
[user]
  name = daotoyi
  email = xxxx.com
[core]
  autocrlf = false
  quotepath = false
[i18n]
  commitencoding = utf-8
  logoutputencoding = utf-8
[credential]
  helper = manager
[http]
  sslverify = false
```
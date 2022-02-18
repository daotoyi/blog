+++
title = "Magit 使用"
tags = ["magit"]
categories = ["emacs"]
draft = true
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
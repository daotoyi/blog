---
title: "Linux exa"
author: ["SHI WENHUA"]
lastmod: "2024-04-01 22:04:59"
tags: ["cmd"]
categories: ["Linux"]
draft: true
---

```bash
# 默认显示 icons：
alias ls="exa --icons"
# 显示文件目录详情
alias ll="exa --icons --long --header"
# 显示全部文件目录，包括隐藏文件
alias la="exa --icons --long --header --all"
# 显示详情的同时，附带 git 状态信息
alias lg="exa --icons --long --header --all --git"

# 替换 tree 命令
alias tree="exa --tree --icons"
```

-   note

> 特别说明：别名生效后，如果还希望使用原始命令，可通过类似于 \command 的形式实现，如 \ls 将无效别名设置，直接使用系统内置 ls 命令。

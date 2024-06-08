---
title: "Linux cmd autojump"
author: ["SHI WENHUA"]
date: "2024-05-11 21:49:00"
lastmod: "2024-05-12 05:20:28"
categories: ["Linux"]
draft: false
---

## install {#install}

```shell
# Add the following line to your ~/.bash_profile or ~/.zshrc file:
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# If you use the Fish shell then add the following line to your ~/.config/fish/config.fish:
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish
```

-   fish

<!--listend-->

```fish
if status is-interactive
    # Commands to run in interactive sessions can go here
  [ -f /opt/homebrew/share/autojump/autojump.fish ]
  source /opt/homebrew/share/autojump/autojump.fish
end
```


## useage {#useage}

```bash
#跳转到一个包含foo字符串的目录
j foo
# 跳转到一个包含foo字符串目录的子目录
jc foo
# 在终端直接打开包含foo字符串目录的文件管理器
jo foo
jco foo
```

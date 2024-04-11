---
title: "Linux desktop 环境"
date: "2022-08-06 14:13:00"
lastmod: "2024-01-04 13:38:07"
categories: ["Linux"]
draft: false
---

## 检查桌面环境 {#检查桌面环境}

```bash
# 只能进入桌面系统后，在桌面系统启动命令窗口执行才能得到结果
# 使用SecureCRT工具连接到系统，执行以下命名得不到任何结果
env | grep DESKTOP_SESSION=
# or
echo $DESKTOP_SESSION
# or
echo $GDMSESSION

ps -A | egrep -i "gnome|kde|mate|cinnamon|lx|xfce|jwm"
```


## Ref {#ref}

-   [Linux系统检查查看桌面环境](https://www.cnblogs.com/kerrycode/p/4790021.html)
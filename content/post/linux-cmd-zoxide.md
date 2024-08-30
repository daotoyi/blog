---
title: "Linux cmd zoxide"
author: ["SHI WENHUA"]
date: "2024-06-21 13:51:00"
lastmod: "2024-06-21 13:51:06"
categories: ["Linux"]
draft: false
---

```bash
## 通过 z 使用 zoxide
echo 'eval "$(zoxide init zsh --cmd z)"' >> ~/.zshrc
## 或直接替换 cd 命令
echo 'eval "$(zoxide init zsh --cmd cd)"' >> ~/.zshrc
```

---
title: "Linux cmd zoxide"
author: ["SHI WENHUA"]
lastmod: "2024-04-01 12:43:16"
categories: ["Linux"]
draft: true
---

```bash
## 通过 z 使用 zoxide
echo 'eval "$(zoxide init zsh --cmd z)"' >> ~/.zshrc
## 或直接替换 cd 命令
echo 'eval "$(zoxide init zsh --cmd cd)"' >> ~/.zshrc
```

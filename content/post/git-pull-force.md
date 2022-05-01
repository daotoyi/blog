---
title: "Git Pull 强制覆盖"
date: "2022-03-26 09:48:00"
lastmod: "2022-04-30 12:32:03"
tags: ["git"]
categories: ["Github"]
draft: false
---

## 推荐方案 {#推荐方案}

```shell
git fetch origin master
git reset --hard origin/master
```

[“git pull”如何强制覆盖本地文件？](https://vimsky.com/article/3679.html)
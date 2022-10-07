---
title: "Git Pull 强制覆盖"
date: "2022-03-26 09:48:00"
lastmod: "2022-10-07 17:29:46"
tags: ["git"]
categories: ["Github"]
draft: false
---

## 不保留本地文件 {#不保留本地文件}

```shell
git fetch origin master
git reset --hard origin/master
```

[“git pull”如何强制覆盖本地文件？](https://vimsky.com/article/3679.html)


## 保留本地文件 {#保留本地文件}

```shell
git fetch origin main
git stash
git reset --hard origin/main
git stash pop
```

冲突文件会在文件中展示出来：

```text
# fetch content
<<<<<<< Updated upstream
git repo changed 3.
=======

# local changed content stashed.
changed 4.
>>>>>>> Stashed changes
```
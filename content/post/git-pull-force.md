+++
title = "Git Pull 强制覆盖"
lastmod = 2022-03-26T09:24:49+08:00
categories = ["Github"]
draft = true
+++

## 推荐方案 {#推荐方案}

```shell
git fetch origin master
git reset --hard origin/master
```

[“git pull”如何强制覆盖本地文件？](https://vimsky.com/article/3679.html)
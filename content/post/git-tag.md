---
title: "Git tag"
date: "2022-06-10 21:00:00"
lastmod: "2023-12-31 11:03:07"
tags: ["git"]
categories: ["Github"]
draft: false
---

## tag {#tag}

git 标签分为两种类型

-   轻量标签
    -   轻量标签是指向提交对象的引用
-   附注标签
    -   附注标签则是仓库中的一个独立对象。
-   建议使用附注标签


## bash {#bash}

<https://metabits.tk/wp-adminic>

```bash
git tag
git tag -l ‘v0.1.*’

git tag v0.1.2-light
git tag -a v0.1.2 -m “0.1.2版本”  # annotated

git checkout [tagname]
git show v0.1.2
git tag -d v0.1.2
git tag -a v0.1.1 9fbc3d0  # git log
```

-   标签总是和某个 commit 挂钩
-   重命名：先删除，再增加
-   标签推送

<!--listend-->

```bash
# 通常的git push不会将标签对象提交到git服务器，需要进行显式的操作
# 将v0.1.2标签提交到git服务器
git push origin v0.1.2
# 将本地所有标签一次性提交到git服务器
git push origin –-tags

# 先从本地删除，然后，从远程删除。
git tag -d v1.0
git push origin :refs/tags/v1.0
```
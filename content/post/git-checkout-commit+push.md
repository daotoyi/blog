---
title: "Git 撤销 commit 和 push 并清除记录"
date: "2022-05-01 19:05:00"
lastmod: "2022-05-01 19:05:42"
tags: ["git"]
categories: ["Github"]
draft: false
---

1.  git reset &lt;版本号&gt; —— 回退到指定版本。指定的版本号可通过 git log 查看
    1.  注：不需要携带--hard，可使用--soft
    2.  使用 --soft 的话，仅仅只是把提交信息给倒退回来
    3.  但使用 --hard 的话，会把版本信息也倒退回来的。
2.  git stash —— 暂存修改。
3.  git push --force —— 强制 push 到远程仓库，指定版本往后的 commit 均被删除。
4.  git stash pop —— 释放暂存的修改。
5.  git add. —— 暂存所有修改。
6.  git commit -m "message" —— 提交已暂存的文件。
7.  git push origin master —— 推送至远程仓库。

<!--listend-->

```bash
git log
git reset --soft xxxxxxxx

#强制撤销并推送至 master 主分支
git push -f
# 或者使用
git push origin master --force

#如强制撤销并推送至 dev 开发分支
git push -f --set-upstream origin dev
```
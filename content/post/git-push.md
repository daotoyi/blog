---
title: "Git push"
description: "push to specific branch"
lastmod: "2022-06-18 16:25:29"
categories: ["Github"]
draft: true
---

## push 到指定分支 {#push-到指定分支}

```bash
git branch dev
git checkout dev
# git checkout -b dev

git add .
git commit -m ‘’

git push origin dev
```


## push 到指定仓库 {#push-到指定仓库}

```bash
# repo a: branch developer_test

git checkout -b dev

git remote add repo-test https://gitee.com/*****/test.git
git push repo-test developer_test

# 使用另外的分支名(例如branch_b)
git push repo-test_b developer_test:branch_b
```
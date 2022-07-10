---
title: "Hugo 使用 Github Action 使用"
date: "2022-03-13 23:24:00"
lastmod: "2022-07-05 21:48:31"
tags: ["Hugo"]
categories: ["VPS"]
draft: false
toc: true
---

## Useage {#useage}

Touch `.github/workflows/main.yml` in root directory. confiure as:

```yaml
  name: Deploy GitHub Pages

# 触发条件：在 push 到 master/main 分支后
on:
  push:
    branches:
      - main

# 任务
jobs:
  build-and-deploy:
    # 服务器环境：最新版 Ubuntu
    runs-on: ubuntu-latest
    steps:
      # 检查代码
      - name: Checkout
        uses: actions/checkout@v2
        with:
          persist-credentials: false

      # 安装hugo命令
      - name: Install Hugo
        run: sudo apt install hugo

      # 1、生成静态文件
      # 默认主题（config.toml)
      - name: hugo-generate
        run: hugo #--config

      # 2、部署到 GitHub Pages
      - name: Deploy on Github
        uses: JamesIves/github-pages-deploy-action@releases/v3
        with:
          ACCESS_TOKEN: ${{ secrets.ACCESS_TOKEN }}
          REPOSITORY_NAME: userID/repoName
          BRANCH: main
          FOLDER: public
```


## Notes {#notes}


### hugo fatal: in unpopulated submodule XXX {#hugo-fatal-in-unpopulated-submodule-xxx}

When `git add theme`, raise `fatal: in unpopulated submodule`.  Because of theme as submodule.

Solve it:

```shell
git rm -rf --cached themes/hugo-book
git add themes/hugo-book
```


## Reference {#reference}

-   [GitHub Actions 入门教程-自动部署静态博客](https://zhuanlan.zhihu.com/p/364366127)
-   [GitHub Actions入门教程：自动化部署静态博客](https://somenzz.gitee.io/auto-deploy-blog-by-github-actions.html)
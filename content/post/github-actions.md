---
title: "Github Actions"
date: "2022-03-19 22:33:00"
lastmod: "2022-04-30 12:32:40"
categories: ["Github"]
draft: false
---

## [GitHub Actions入门教程：自动化部署静态博客](https://somenzz.gitee.io/auto-deploy-blog-by-github-actions.html) {#github-actions入门教程-自动化部署静态博客}


### example {#example}

将博客原文档推送给 github 的仓库 repo1. Github Actions 接收到 push 请求后，按以下配置将生成的静态内容推送给 github 的仓库 repo2.并且同步给 gitee 上的仓库 repo3.

```yaml
  name: Deploy GitHub Pages

# 触发条件：在 push 到 master 分支后
on:
  push:
    branches:
      - master

# 任务
jobs:
  build-and-deploy:
    # 服务器环境：最新版 Ubuntu
    runs-on: ubuntu-latest
    steps:
      # 拉取代码
      - name: Checkout
        uses: actions/checkout@v2
        with:
          persist-credentials: false

      # 1、生成静态文件
      - name: Build
        run: npm install && npm run build

      # 2、部署到 GitHub Pages
      - name: Deploy
        uses: JamesIves/github-pages-deploy-action@releases/v3
        with:
          ACCESS_TOKEN: ${{ secrets.ACCESS_TOKEN }}
          REPOSITORY_NAME: somenzz/somenzz.github.io
          BRANCH: master
          FOLDER: public
          #注意这里的 public 是仓库根目录下的 public，也就是 npm run build 生成静态资源的路径，比如有的人是 `docs/.vuepress/dist`

      # 3、同步到 gitee 的仓库
      - name: Sync to Gitee
        uses: wearerequired/git-mirror-action@master
        env:
          # 注意在 Settings->Secrets 配置 GITEE_RSA_PRIVATE_KEY
          SSH_PRIVATE_KEY: ${{ secrets.GITEE_RSA_PRIVATE_KEY }}
        with:
          # 注意替换为你的 GitHub 源仓库地址
          source-repo: git@github.com:somenzz/somenzz.github.io.git
          # 注意替换为你的 Gitee 目标仓库地址
          destination-repo: git@gitee.com:somenzz/somenzz.git

      # 4、部署到 Gitee Pages
      - name: Build Gitee Pages
        uses: yanglbme/gitee-pages-action@main
        with:
          # 注意替换为你的 Gitee 用户名
          gitee-username: somenzz
          # 注意在 Settings->Secrets 配置 GITEE_PASSWORD
          gitee-password: ${{ secrets.GITEE_PASSWORD }}
          # 注意替换为你的 Gitee 仓库，仓库名严格区分大小写，请准确填写，否则会出错
          gitee-repo: somenzz/somenzz
          # 要部署的分支，默认是 master，若是其他分支，则需要指定（指定的分支必须存在）
          branch: master

      # 5、部署到 somenzz.cn 服务器
      - name: rsync deployments
        uses: burnett01/rsync-deployments@4.1
        with:
          # 这里是 rsync 的参数 switches: -avzh --delete --exclude="" --include="" --filter=""
          switches: -avzh
          path: public/
          remote_path: /home/ubuntu/public/
          remote_host: somenzz.cn
          remote_port: 22
          remote_user: ubuntu
          remote_key: ${{ secrets.MY_UBUNTU_RSA_PRIVATE_KEY }}
```

-   on 表示触发条件
-   jobs 表示要做的工作
-   jobs 下的 step 表示要做的步骤，前一步失败，后面不会继续执行。
-   jobs 下的 step 下有 name、uses、with 等，表示一个 action。
-   name 表示 action 的名称，uses 表示使用哪个插件，with 表示传给插件的参数。
-   secrets.XXX 这个 XXX 表示本仓库的环境变量，配置在仓库设置里面的 secrets 菜单栏，都是加密的。


### repo1 push repo2 {#repo1-push-repo2}

需要在 repo1 的仓库中设置 repo2 的 secrets.ACCESS_TOKEN。


### repo2 sync repo3 {#repo2-sync-repo3}

Gitee 上保存你账户对应的公钥，GitHub 仓库的 secrets.GITEE_RSA_PRIVATE_KEY 保存着私钥.

GitHub Actions 的服务器会使用账户登录 Gitee，Gitee 使用公钥加密后传输给这台服务器，这台服务器使用设置的私钥才能解密成功，通讯完成。

需要在 repo1 的仓库中设置 secrets.GITEE_RSA_PRIVATE_KEY 以及 secrets.GITEE_PASSWORD。


## Reference {#reference}

-   [actions-workflow-samples](https://github.com/Azure/actions-workflow-samples/blob/master/assets/create-secrets-for-GitHub-workflows.md)
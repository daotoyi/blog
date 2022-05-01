---
title: "Vuepress 使用小结"
lastmod: "2022-04-30 19:28:58"
tags: ["Vuepress"]
categories: ["VPS"]
draft: false
---

CLOSED: <span class="timestamp-wrapper"><span class="timestamp">[2022-03-26 周六 21:13]</span></span>


## Vue.js {#vue-dot-js}

Vue (读音 /vjuː/，类似于 view) 是一套用于构建用户界面的渐进式框架。与其它大型框架不同的是，Vue 被设计为可以自底向上逐层应用。


## VuePress {#vuepress}

VuePress 由两部分组成：

-   一个以 Vue 驱动的主题系统的简约静态网站生成工具
-   一个为编写技术文档而优化的默认主题。

它是为了支持 Vue 子项目的文档需求而创建的。


## use {#use}


### 全局安装 {#全局安装}

```shell
# 全局安装
npm install -g vuepress

# 创建一个 markdown 文件
echo '# Hello VuePress' > README.md

# 开始编写文档
vuepress dev

# 构建
vuepress build
```


### 本地安装/启动 {#本地安装-启动}


#### 安装 {#安装}

```shell
# 安装为本地依赖项
npm install -D vuepress
yarn add -D vuepress

# 创建一个 docs 目录 && markdown 文件
mkdir docs &&  echo '# Hello VuePress' > docs/README.md
# VuePress 会以 docs 为文档根目录，所以这个 README.md 相当于主页
```


#### 添加 scripts {#添加-scripts}

```json
  {
  "scripts": {
    "docs:dev": "vuepress dev docs",
    "docs:build": "vuepress build docs"
  }
}
```


#### 本地启动服务器 {#本地启动服务器}

&gt; npm run docs:dev
&gt; yarn docs:dev


### 更换主题 {#更换主题}

```shell
npm install vuepress-theme-reco --save-dev
```

reco 主题可实现加载 loading、切换动画、模式切换（暗黑模式）、返回顶部、评论等功能.


### 部署 {#部署}


#### 脚本部署 {#脚本部署}

docs/scripts/deploy.sh

&gt; npm run deploy.sh


#### Github Action 部署 {#github-action-部署}

example1

```yaml
# name 可以自定义
name: Deploy GitHub Pages

# 触发条件：在 push 到 main/master 分支后
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
      # 拉取代码
      - name: Checkout
        uses: actions/checkout@v2
        with:
          persist-credentials: false

      # 生成静态文件
      - name: Build
        run: npm install && npm run docs:build

      # 部署到 GitHub Pages
      - name: Deploy
        uses: JamesIves/github-pages-deploy-action@releases/v3
        with:
          ACCESS_TOKEN: ${{ secrets.ACCESS_TOKEN }} # 也就是我们刚才生成的 secret
          BRANCH: gh-pages # 部署到 gh-pages 分支，因为 main 分支存放的一般是源码，而 gh-pages 分支则用来存放生成的静态文件
          FOLDER: docs/.vuepress/dist # vuepress 生成的静态文件存放的地方
```

-   example2

<!--listend-->

```yaml
name: GitHub Actions Demo
on:
  push:
    branches:
      - master
jobs:
  Explore-GitHub-Actions:
    runs-on: ubuntu-latest
    steps:
      - run: echo "🎉 触发动作：${{ github.event_name }}"
      - run: echo "🐧 托管服务器：${{ runner.os }} server hosted by GitHub!"
      - run: echo "🔎 当前分支：${{ github.ref }} "
      - run: echo "🏠 当前仓库：${{ github.repository }}."
      - name: Check out repository code
        uses: actions/checkout@v2
      - run: echo "💡 获取源码：The ${{ github.repository }} repository has been cloned to the runner."
      - run: echo "🖥️ 工作流准备：The workflow is now ready to test your code on the runner."
      - name: Build and Deploy
        run: |
          yarn install
          yarn build
      - run: echo "✅依赖安装并编译完成"
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }} # 默认环境变量
          publish_dir: docs/.vuepress/dist # 发布本地文件地址
          - run: echo "🍏 This job's status is ${{ job.status }}."
```


### 定时推送百度 {#定时推送百度}

```yaml
## baiduPush.yml
name: 'baiduPush'

on:
  push:
  schedule:
    - cron: '0 23 * * *'

jobs:
  bot:
    runs-on: ubuntu-latest # 运行环境为最新版的Ubuntu
    steps:
      - name: 'Checkout codes' # 步骤一，获取仓库代码
        uses: actions/checkout@v1
      - name: 'Run baiduPush.sh' # 步骤二，执行sh命令文件
        run: npm install && npm run baiduPush # 运行命令。（注意，运行目录是仓库根目录）
```


## Note {#note}


### configuration {#configuration}

-   使用 npm 管理安装，dev 启动时插件加载会异常
-   包管理工具会在项目锁定文件,自动生成，不能混用
    -   npm： package-lock.json
    -   yarn: yarn.lock


### markdown {#markdown}

```nil
{{< figure src="https://pic4.zhimg.com/80/v2-1bb4dea5ae4f6ff7d1b9a1b405e09467_1440w.jpg" >}}
![](https://pic4.zhimg.com/80/v2-1bb4dea5ae4f6ff7d1b9a1b405e09467_1440w.jpg)
```

-   {{&lt;figure src="" &gt;}}格式,vuepress 不支持, hugo 支持


### build {#build}

如果 md 文件内容有问题，如找不到链接图片，在 dev 模式时，可以正常运行，但在 build 模式时无法正常生成。


## Reference {#reference}

-   [VuePress中文网](http://caibaojian.com/vuepress/guide/)
-   [VuePress中文网默认主题配置](http://caibaojian.com/vuepress/default-theme-config/)
-   [一篇带你用 VuePress + Github Pages 搭建博客](https://xie.infoq.cn/article/4d2f62c87d188331342e62563)
-   [GitHub Actions 实现自动部署静态博客](https://xugaoyi.com/pages/6b9d359ec5aa5019/)
-   [Vuepress + GitHub Actions 实现博客自动部署！](https://juejin.cn/post/7000572105154625567)
-   [GitHub Actions 定时运行代码：每天定时百度链接推送](https://xugaoyi.com/pages/f44d2f9ad04ab8d3/)
-   [批量操作front matter工具](https://doc.xugaoyi.com/pages/2b8e22/)
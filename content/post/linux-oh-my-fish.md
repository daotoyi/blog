---
title: "Linux oh-my-fish"
author: ["SHI WENHUA"]
date: "2024-03-25 11:46:00"
lastmod: "2024-03-26 08:22:24"
categories: ["Linux"]
draft: false
---

## install {#install}

```bash
brew install fish

# /etc/shells
/usr/local/bin/fish
ln -s /opt/homebrew/bin/fish /usr/local/bin/fish

chsh -s /usr/local/bin/fish

curl -L https://get.oh-my.fish | fish
```


## useage {#useage}

omf(oh my fish)是基于 fish shell 的框架，提供插件跟主题，具体使用方式：

```bash
omf update [omf] […] #//更新
omf install [|] #//安装
omf repositories [list|add|remove] #//管理用户安装的包仓库
omf list #//显示安装的包
omf theme #//设置主题，可查看主题列表https://github.com/oh-my-fish/oh-my-fish/blob/master/docs/Themes.md
omf remove #//移除
omf reload #//重载  omf 和所有插件
omf new pkg | theme #//编写自己包或主题
omf search -t|–theme / -p|–package #//搜索主题或者包
omf channelomf doctor #//不用说了，检查健康
omf destroy #//删除卸載 omf
```


## config {#config}

$OMF_CONFIG 这个是 omf 的配置目录，里面有主题插件的目录，但主要说下三个 fish 的脚本:

-   init.fish - 自定义 shell 启动后加载的脚本
-   before.init.fish - 自定义 shell 启动前加载的脚本
-   key_bindings.fish - 自定义快捷键绑定

export 写法：

```bash
cd $OMF_CONFIG
vi init.fish
set -xg PATH $PATH $HOME/.composer/vendor/bin
# export PATH=”$PATH:$HOME/.composer/vendor/bin”

# proxy
set -xg http_proxy http://127.0.0.1:1087
set -xg https_proxy http://127.0.0.1:1087

source $OMF_CONFIG/init.fish
```

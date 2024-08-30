---
title: "Linux debian9 中文输入法生效"
author: ["SHI WENHUA"]
date: "2024-08-04 11:45:00"
lastmod: "2024-08-04 12:32:12"
categories: ["Linux"]
draft: false
---

## 修改源 {#修改源}

-   /etc/apt/source.lst

<!--listend-->

```cfg
deb http://archive.debian.org/debian/ stretch main contrib non-free
deb http://archive.debian.org/debian/ stretch-proposed-updates main contrib non-free
```

更新源 `apt update`


## 安装包 {#安装包}

-   config

<!--listend-->

```bash
apt install fcitx-sunpinyin fcitx-pinyin
apt install fcitx-table*
apt install fcitx-frontend-gtk2 fcitx-frontend-gtk3 fcitx-frontend-qt4

# 添加候选词
apt install fcitx-ui-classic
```

配置 `im-configtool`

系统-首选项-其他-输入法-fcitx


## ref {#ref}

-   [在Debian系统下使用自带的Fcitx配置中文输入法](https://www.shuran.cn/?p=1101)

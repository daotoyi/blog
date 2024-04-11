---
title: "Linux fonts"
author: ["SHI WENHUA"]
lastmod: "2024-03-27 17:40:16"
categories: ["Linux"]
draft: true
---

## 字体说明 {#字体说明}


### True Type Fonts (TTF) {#true-type-fonts--ttf}

TrueType 是一个矢量字体的标准。


### Open Type Fonts (OTF) {#open-type-fonts--otf}

OpenType 是数字字体的一个新的标准，目标不仅是支持各类平台，而是支持世界范围的书写系统。


## Powerline fonts {#powerline-fonts}

Powerline 是一款 Vim statusline 的插件，它用到了很多特殊的 icon 字符。Powerline fonts 是一个字体集，本质是对一些现有的字体打 patch，把 powerline icon 字符添加到这些现有的字体里去，目前对 30 款编程字体打了 patch.

```bash
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
```

下载安装之后，如果用的是 macOS, 就可以在 Font Book 里来查看已安装的字体了。


## Nerd font {#nerd-font}

Nerd font 的原理和 Powerline fonts 是一样的，也是针对已有的字体打 patch，把一些 icon 字符插入进去。不过 Nerd font 就比较厉害了，是一个“集大成者”，他几乎把目前市面上主流的 icon 字符全打进去了，包括powerline icon 字符以及 Font Awesome 等几千个 icon 字符。

Nerd font 对 50 多款编程字体打了 patch，和 Powerline fonts 类似，也会在 patch 后，对名字做一下修改，比如 Source Code Font 会修改为 Sauce Code Nerd Font。

Nerd fonts 是 Powerline fonts 的超集，建议直接使用 Nerd font 。

```bash
brew tap homebrew/cask-fonts
brew cask install font-sourcecodepro-nerd-font-mono -v
```


## monaco 下载安装 {#monaco-下载安装}

从 <https://github.com/supermarin/powerline-fonts> 下载monaco字体点击/拖放安装即可。

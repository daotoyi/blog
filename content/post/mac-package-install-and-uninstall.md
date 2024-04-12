---
title: "macOS 软件包安装/卸載"
author: ["SHI WENHUA"]
lastmod: "2024-04-12 12:13:30"
categories: ["Mac"]
draft: false
---

CLOSED: <span class="timestamp-wrapper"><span class="timestamp">[2024-03-28 Thu 00:43]</span></span>


## 安装 {#安装}

1.  dmg 文件安装
2.  App Store 安装
    -   卸载方法与 dmg 文件安装一致
3.  pkg 安装包安装
4.  Homebrew 等包管理器安装


## 卸載 {#卸載}


### dmg {#dmg}

dmg 是苹果电脑上专用的磁盘镜像（disk image）文件，类似于 Windows 平台上的 iso 镜像，dmg 类似于一个压缩文档，支持压缩与加密，将程序与文档打包成 dmg 是一种比较流行的软件发布形式。

-   /Applications 目录中的主程序；
-   ~/Library/Preferences/目录中后缀名为“.plist”的配置文件；
-   软件处理的数据文件，图片处理软件一般在~/Pictures 目录找，
-   其他程序一般在~/Documents 目录找。

找出这些文件删除即可。


### pkg {#pkg}

当 App 有一些特定的需求，比如：向系统配置面板写配置程序、安装屏幕保护程序、读写特定的目录与文件等，才会使用 pkg 软件安装包格式。

安装的 pkg 软件包，都记录在以下:

```text
/Library/Receipts/InstallHistory.plist
/private/var/db/receipts
```

```bash
pkgutil --pkgs
pkgutil --pkg-info pkg-name

# pkgutil --pkg-info aria2
# delete get the location
sudo rm -r /usr/local/aria2
# 删除安装包记录
sudo pkgutil --forget aria2
```


### brew uninstall {#brew-uninstall}

```bash
brew uninstall app-name
```

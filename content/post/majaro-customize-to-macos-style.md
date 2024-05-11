---
title: "Manjaro 美化 macos"
author: ["SHI WENHUA"]
date: "2024-04-21 12:06:00"
lastmod: "2024-04-21 12:07:05"
tags: ["manjaro"]
categories: ["Linux"]
draft: false
---

## steps {#steps}


### 安装 WhiteSur-Gtk-theme {#安装-whitesur-gtk-theme}

登录 xfce-look.org 主题站，搜索 WhiteSur，在搜索结果中下载主题，图标，指针这三项主题资源包到本地进行安装。

-   WhiteSur-Gtk-theme，
-   WhiteSur-icon-theme，
-   WhiteSur-cursors

<!--listend-->

```bash
sudo git clone https://github.com/vinceliuice/WhiteSur-gtk-theme
sudo git clone https://github.com/vinceliuice/WhiteSur-icon-theme
sudo git clone https://github.com/vinceliuice/WhiteSur-cursors

cd WhiteSur-xxx
sudo ./install.sh
```

> ~/.themes                      该目录存放 theme 主题
> ~/.local/share/icons 该目录存放 icon 图标和 cursor 主题

-   打开 “开始菜单--&gt;设置管理-&gt;外观设置"，选择新安装的外观样式，选择新安装的图标；
-   返回所有设置，打开窗口管理器，选择窗口的样式主题，调整按钮布局，拖动 "菜单按钮" 和 "折叠按钮" 到隐藏区，将关闭，最小化，最大化按钮拖动到标题左侧。


### 安装 Plank {#安装-plank}

Plank 是一款轻量级的 Dock 工具栏软件.

打开 "会话和启动" (session and startup) 设置，选择 “应用程序自启动”，点击添加，将 plank 应用添加为自启动。

按住 CTRL 键，在 Dock 栏上点击鼠标右键，在弹出的菜单中选择 “首选项”，对 Plank 进行细节调整配置。


### 安装 vala-panel-appmenu {#安装-vala-panel-appmenu}

开添加删除软件管理器，打开首选项，设置软件源，启用 AUR 支持，勾选支持的选项。在软件管理器中搜索 vala-panel，选择安装以下三个软件包：

-   vala-panel-appmenu-common
-   vala-panel-appmenu-registrar
-   vala-panel-appmenu-xfce

安装搜索到的 appmenu-gtk-module 软件包,终端，执行以下内容

```bash
xfconf-query -c xsettings -p /Gtk/ShellShowsMenubar -n -t bool -s true
xfconf-query -c xsettings -p /Gtk/ShellShowsAppmenu -n -t bool -s true
```


### 安装 Albert {#安装-albert}

在 Add/Remove Software 中搜索 albert 软件安装。

默认快捷键与 utools 冲突，可自定义。


### 美化 firefox {#美化-firefox}

GitHub 的 WhiteSur-gtk-theme 项目中有一个如何设置 Firefox 的指导说明，按指导进行配置。


## reference {#reference}

-   [如何将 Manjaro xfce 美化的像 MacOS](https://mp.weixin.qq.com/s/sv7V5Hc8IGnmAPG_kki5-w)
-   xfce-look.org 主题站: <https://www.xfce-look.org/browse/>
-   WhiteSur-gtk-theme: <https://www.xfce-look.org/p/1403328>
-   WhiteSur-gtk-theme: <https://github.com/vinceliuice/WhiteSur-gtk-theme>
-   WhiteSur-icon-theme: <https://www.xfce-look.org/p/1405756/>
-   WhiteSur-icon-theme: <https://github.com/vinceliuice/WhiteSur-icon-theme>
-   WhiteSur-cursors: <https://www.xfce-look.org/p/1411743/>
-   WhiteSur-cursors: <https://github.com/vinceliuice/WhiteSur-cursors>

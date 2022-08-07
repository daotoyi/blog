---
title: "MobaXterm"
lastmod: "2022-08-06 16:50:46"
categories: ["Tools"]
draft: true
---

## 简介 {#简介}

-   功能很全，免费，有免安装版，支持多标签，同时自带文件传输系统
-   唯一的不足是对 Z-moderm 支持较差。

-   内建 X server，可远程运行 X 窗口程序
-   内建 SFTP 文件传输
-   直接支持 VNC/RDP/Xdmcp 等远程桌面
-   支持 mosh 协议，在弱网环境下取代 SSH
-   内建多标签和多终端分屏
-   内建 FTP、HTTP 等诸多服务器，一键开启
-   免费版可满足大部分使用需求
-   非常多的额外功能，支持插件


## linux 环境 {#linux-环境}

-   可以直接安装软件，或者官网下载插件
    -   apt-get install vim gnuplot
-   使用 linux 脚本操作 windows 下的 exe 命令
    -   {{< figure src="https://pic4.zhimg.com/v2-386349d7b161d87a686452e909e582ff_r.jpg" >}}


## 配置 {#配置}


### 隐藏菜单栏下的那排按钮 {#隐藏菜单栏下的那排按钮}

在菜单栏点击 「view」 --&gt; 「show menu bar」，即可隐藏此排按钮。


### 右键粘贴 {#右键粘贴}

在菜单栏点击 「settings」 --&gt; 「Configuration」，在弹出的对话框中选择 「terminal」，再将 「paste using right-click」 打上对勾即可。


### **关闭自动弹出 SFTP** {#关闭自动弹出-sftp}

在菜单栏点击 「settings」 --&gt; 「Configuration」，在弹出的对话框中选择 「SSH」，再将 「automaticall switch to SSH-browser tab after login」 前面的对勾去掉即可。


### 共享 windows 下的目录给他人 {#共享-windows-下的目录给他人}

[tools] --&gt; [servers management] --&gt; [FTP/TFTP/HTTP/SFTP/NFS/VNC server]


### 网络抓包/端口扫描 {#网络抓包-端口扫描}

[tools] --&gt; [Network packets capture]

[tools] --&gt; [Network scanner]


### 与后台服务器保持长链接 {#与后台服务器保持长链接}

[settings] --&gt; [SSH] --&gt; [SSH keepalive]


### 多个窗口执行同一命令 {#多个窗口执行同一命令}

分屏状态下， [MultiExec]
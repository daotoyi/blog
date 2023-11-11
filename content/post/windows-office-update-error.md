---
title: "Windows Office Update (应用程序无法正常启动)"
date: "2023-10-06 19:32:00"
lastmod: "2023-10-07 08:30:26"
categories: ["Windows"]
draft: false
---

### 前言

有时候打开office套件，如word，outlook时，会弹出**正在更新 Office，请稍候**，然后弹出一个错误框**应用程序无法正常启动(0xc0000142)。请单击"确定"关闭应用程序。**

### 解决

> +Win+r
> services.msc (打开服务)
> Microsoft office (即点即用服务)

> -   右键点击“Microsoft office即点即用服务”—属性
> -   启动类型由“自动”改为“禁用
> -   点击确定
> -   再把启动类型由“禁用”改为“自动”
> -   点击确定
> -   右键点击“Microsoft office即点即用服务”—重新启动
> -   重新打开
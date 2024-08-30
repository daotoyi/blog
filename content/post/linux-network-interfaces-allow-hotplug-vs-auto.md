---
title: "Linux 网络配置中 allow-hotplug 与 auto 的区别"
author: ["SHI WENHUA"]
date: "2024-06-29 08:15:00"
lastmod: "2024-06-29 08:17:46"
categories: ["Linux"]
draft: false
---

## auto {#auto}

-   在系统启动的时候启动网络接口，无论网络接口有无连接 (插入网线)。
-   如果该接口配置了 DHCP，则无论有无网线，系统都会去获取 DHCP。并且如果没有插入网线，则等该接口超时后才会继续 DHCP。

**配置这个命令，仅仅是用于开机启动时启动网络接口，如果不配置重启自动不会启动网络接口，就直接导致远程登录失败。**


## allow-hotplug {#allow-hotplug}

-   只有当内核从网络接口检测到热插拔事件后才会启动该接口。
-   如果系统开机时该接口没有插入网线，则系统不会启动该接口。
-   系统启动后，如果插入网线，系统会自动启动该接口。

**配置这个命令，是为了保证端口状态及时更新，或者避免由于手动操作导致的重启 network 失败。**


## note {#note}

如果设置的是 auto，不管你插不插网线，网卡都会启用，而且运行/etc/init.d/networking restart 之后网卡能自动起来

如果设置的是 allow-hotplug，它会在开机时启动插网线的网卡，运行/etc/init.d/networking restart 之后网卡不能自动重启


## refer {#refer}

[Debian 中 allow-hotplug 与 auto 的区别](https://www.cnblogs.com/arci/p/14977135.html)

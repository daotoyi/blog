---
title: "System Port"
date: "2022-03-02 16:02:00"
lastmod: "2022-04-30 12:45:28"
categories: ["Linux"]
draft: false
---

## netstat {#netstat}

提供有关网络连接的信息.

netstat -tunlp

1.  -t：显示 TCP 端口。
2.  -u：显示 UDP 端口。
3.  -n：显示数字地址而不是解析主机。
4.  -l：仅显示侦听端口。
5.  -p：显示监听器进程的 PID 和名称


## ss {#ss}

ss 的优势在于它能够显示更多更详细的有关 TCP 和连接状态的信息，而且比 netstat 更快速更高效。

ss -tunlp


## lsof {#lsof}

提供有关进程打开的文件的信息.

lsof -i:80


## Nmap {#nmap}

（网络映射器）是一种用于网络探索和安全审计的开源工具，它旨在快速扫描大型网络，虽然它可以很好地对抗单个主机。


## ufw {#ufw}

`sudo ufw allow 40`

Ubuntu 有一个名为 ufw 的防火墙，它负责处理端口和连接的这些规则，而不是旧的 iptables 防火墙。

ufw 规则不会在重启时重置,这是因为它已集成到引导过程中，并且内核使用 ufw 通过适当的配置文件保存了防火墙规则。
---
title: "Linux cmd brctl"
date: "2022-08-07 15:24:00"
lastmod: "2022-08-07 15:24:16"
tags: ["cmd"]
categories: ["Linux"]
draft: false
---

## 简介 {#简介}

“bridge control”的缩写，其功能是用于管理以太网网桥。属于 bridge-utils 软件包。


## 参数 {#参数}

| 参数         | 功能        |
|------------|-----------|
| addbr        | 创建网桥    |
| delbr        | 删除网桥    |
| addif        | 将网卡接口接入网桥 |
| delif        | 删除网桥接入的网卡接口 |
| show         | 查询网桥信息 |
| stp {on off} | 启用禁用 STP |
| showstp      | 查看网桥 STP 信息 |
| setfd        | 设置网桥延迟 |
| showmacs     | 查看 mac 信息 |


## 使用 {#使用}

```bash
# 创建一个网桥 br10
brctl addbr br10

brctl delbr br10
brctl show
brctl stp br10 on/off

# 网桥br10添加设备eth0
brctl addif br10
# 网桥设置IP，并启动
ifconfig br10 10.0.0.1 netmask 255.255.255.0 up

# 关闭网桥
brctl delif br10 eth1
brctl delif br10 eth0
ifconfig br10 down
brctl delbr br10
```
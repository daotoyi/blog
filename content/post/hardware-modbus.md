---
title: "Modbus"
date: "2022-08-30 20:36:00"
lastmod: "2022-08-30 20:36:06"
categories: ["Hardware"]
draft: false
---

## 简介 {#简介}

Modbus 是一种串行通信协议，是 Modicon 公司（现在的施耐德电气 Schneider Electric）于 1979 年为使用可编程逻辑控制器（PLC）通信而发表。

Modbus 已经成为工业领域通信协议的业界标准（De facto），并且现在是工业电子设备之间常用的连接方式。

Modbus 允许多个 (大约 240 个) 设备连接在同一个网络上进行通信


## 通信 {#通信}

Modbus 协议是一个 master/slave 架构的协议。有一个节点是 master 节点，其他使用 Modbus 协议参与通信的节点是 slave 节点。每一个 slave 设备都有一个唯一的地址。

Modbus 协议目前存在用于串口、以太网以及其他支持互联网协议的网络的版本。大多数 Modbus 设备通信通过串口 EIA-485 物理层进行。
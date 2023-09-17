---
title: "Linux ssh 本地/远程转发"
date: "2023-09-12 09:16:00"
lastmod: "2023-09-12 10:01:23"
categories: ["Linux"]
draft: false
---

## 本地转发 {#本地转发}

A 机通过 B 机连接 C 机

-   B 机

    ```bash
          ssh -L localport:remotehost:remotehostport sshserver

          说明：
          localport　　　　　　 本机开启的端口号
          remotehost　　　　　　最终连接机器的IP地址
          remotehostport      最终连接机器的端口号
          sshserver　　　　　　 转发机器的IP地址

          选项：
          -f 后台启用
          -N 不打开远程shell，处于等待状态（不加-N则直接登录进去）
          -g 启用网关功能
    ```


## 远程转发 {#远程转发}

A 机通过 B 机连接 C 机

-   B 机

    ```bash
          ssh -R sshserverport:remotehost:remotehostport sshserver

          说明：
          sshserverport     被转发机器开启的端口号
          remotehost    　  最终连接机器的IP地址
          remotehostport    最终连接机器的端口号
          sshserver         被转发机器的IP地址

          选项：
          -f 后台启用
          -N 不打开远程shell，处于等待状态（不加-N则直接登录进去）
          -g 启用网关功能
    ```


## 参考 {#参考}

-   [ssh端口转发(跳板机)实战详解](https://zhuanlan.zhihu.com/p/469638489)
-   [彻底搞懂SSH端口转发命令](https://zhuanlan.zhihu.com/p/148825449)
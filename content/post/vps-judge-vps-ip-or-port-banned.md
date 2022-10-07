---
title: "判断海外 VPS 的 ip/port 是否被封"
date: "2022-07-05 21:46:00"
lastmod: "2022-10-07 16:22:32"
categories: ["VPS"]
draft: false
toc: true
---

## 判断 IP {#判断-ip}

-   站长工具
    -   <https://ping.chinaz.com/>
-   ping.pe 检测
    -   <https://ping.pe/>
-   以上方法均从世界各地访问测试 ip，从而判断是否 ip 被封


## 判断 port {#判断-port}

-   国外的端口检测工具网站检测
    -   <https://www.yougetsignal.com/tools/open-ports/>
-   IP/PORT 可用性检测工具
    -   <https://www.toolsdaquan.com/ipcheck/>
    -   **推荐** ，可同时对比国内外 ICMP 和 TCP（SSL）连接，直观确定是否被封
        -   如国外 TCP 可用，国内不可用，即是被墙。
-   站长工具端口扫描
    -   <https://tool.chinaz.com/port/>


## 其他工具 {#其他工具}

-   Tcping
    -   端口检测工具也可以针对端口进行 ping
    -   tcping IP PORT
---
title: "Linux iptables"
date: "2022-08-07 09:28:00"
lastmod: "2024-01-19 08:33:33"
categories: ["Linux"]
draft: false
---

## 简介 {#简介}

-   集成在 Linux 内核中的包过滤防火墙系统。
-   iptables 默认维护着 4 个表和 5 个链，所有的防火墙策略规则都被分别写入这些表与链中。
-   “四表”是指 iptables 的功能
    -   filter 表（过滤规则表）
        -   控制数据包是否允许进出及转发
        -   可以控制的链路有 INPUT、FORWARD 和 OUTPUT
    -   nat 表（地址转换规则表）
        -   控制数据包中地址转换
        -   可以控制的链路有 PREROUTING、INPUT、OUTPUT 和 POSTROUTING
    -   mangle（修改数据标记位规则表）
        -   修改数据包中的原数据
        -   可以控制的链路有 PREROUTING、INPUT、OUTPUT、FORWARD 和 POSTROUTING
    -   raw（跟踪数据表规则表）
        -   控制 nat 表中连接追踪机制的启用状况
        -   可以控制的链路有 PREROUTING、OUTPUT
-   “五链”是指内核中控制网络的 NetFilter 定义的 5 个规则链，每个规则表中包含多个数据链
    -   INPUT（入站数据过滤）
    -   OUTPUT（出站数据过滤）
    -   FORWARD（转发数据过滤）
    -   PREROUTING（路由前过滤）
    -   POSTROUTING（路由后过滤）


## 流程 {#流程}


### 数据包传输 {#数据包传输}

{{< figure src="https://images0.cnblogs.com/blog2015/569491/201503/071933304925554.png" >}}


### “表”“链”分层结构 {#表-链-分层结构}

{{< figure src="https://images0.cnblogs.com/blog2015/569491/201503/071934139309258.png" >}}


### 管理和设置 iptables 规则 {#管理和设置-iptables-规则}

{{< figure src="https://images0.cnblogs.com/blog2015/569491/201503/071935158831919.jpg" >}}

{{< figure src="https://images0.cnblogs.com/blog2015/569491/201503/071936081026171.jpg" >}}


## 使用 {#使用}


### 语法格式 {#语法格式}

`iptables [-t table] COMMAND [chain] CRETIRIA -j ACTION`

iptables [-t 表名] &lt;操作命令&gt; [链名] [规则号码] [匹配条件] [匹配之后的操作]

-   -t：指定需要维护的防火墙规则表 filter、nat、mangle 或 raw。
    -   在不使用 -t 时则默认使用 filter 表。
-   COMMAND：子命令，定义对规则的管理。
-   chain：指明链表。
-   CRETIRIA：匹配参数。
-   ACTION：触发动作。


### 常用规则 {#常用规则}

```bash
# 删除INPUT链的第一条规则
iptables -D INPUT 1

# 拒绝进入防火墙的所有ICMP协议数据包
iptables -I INPUT -p icmp -j REJECT

# 允许防火墙转发除ICMP协议以外的所有数据包
iptables -A FORWARD -p ! icmp -j ACCEPT # “！”可以将条件取反

# 拒绝转发来自192.168.1.10主机的数据
# 允许转发来自192.168.0.0/24网段的数据
iptables -A FORWARD -s 192.168.1.11 -j REJECT
iptables -A FORWARD -s 192.168.0.0/24 -j ACCEPT

# 禁止其他主机ping防火墙主机，但是允许从防火墙上ping其他主机
iptables -I INPUT -p icmp --icmp-type Echo-Request -j DROP
iptables -I INPUT -p icmp --icmp-type Echo-Reply -j ACCEPT
iptables -I INPUT -p icmp --icmp-type destination-Unreachable -j ACCEPT

# 禁掉端口
iptables -A INPUT -p tcp --dport 53 -j DROP
iptables -A OUTPUT -p tcp --dport 53 -j DROP
# 允许转发来自192.168.0.0/24局域网段的DNS解析请求数据包
iptables -A FORWARD -s 192.168.0.0/24 -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -d 192.168.0.0/24 -p udp --sport 53 -j ACCEPT

# 禁止转发来自MAC地址为00：0C：29：27：55：3F的和主机的数据包
iptables -A FORWARD -m mac --mac-source 00:0c:29:27:55:3F -j DROP
```


### 保存与恢复 {#保存与恢复}

```bash
service iptables save
iptables-save > /etc/sysconfig/iptables
iptables-save | tee -a /etc/iptables.conf

iptables-restore < /etc/iptables.conf
```


## Ref {#ref}

-   [iptables详解](https://www.cnblogs.com/metoy/p/4320813.html)
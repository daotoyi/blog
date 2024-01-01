---
title: "Linux cmd dmidecode"
lastmod: "2023-12-29 11:38:30"
categories: ["Linux"]
draft: true
---

## 简述 {#简述}

midecode 是一个 Linux 命令行工具，用于从 BIOS（基本输入/输出系统）和硬件里获取系统相关的信息。该命令可以在终端里查看详细的硬件配置信息，包括处理器、主板、内存、硬盘、BIOS 版本等。

DMI (Desktop Management Interface)

-   -t  只显示指定条目的信息
-   -s  只显示指定 DMI 字符串关键字的信息


## 常用命令 {#常用命令}

-   用法 1

<!--listend-->

```bash
# 显示当前硬件信息
sudo lshw

dmidecode -t 0   # BIOS
dmidecode -t 2   # mainboard
dmidecode -t 4   # CPU
dmidecode -t 11  # OEM

dmidecode -t 4 | grep ID  # CPU ID

dmidecode | grep Serial             # Serial Number
dmidecode | grep 'Product Name'   # 查看服务器型号
dmidecode | grep 'Serial Number'  # 查看主板的序列号
dmidecode -s system-serial-number # 查看系统序列号
dmidecode -t memory               # 查看内存信息
```

-   用法 2

<!--listend-->

```nil
dmidecode --type <type>
bios: 查看BIOS信息
system: 查看系统信息
baseboard: 查看主板信息
chassis: 查看机箱信息
processor: 查看CPU信息，显示资讯类似 lscpu
memory: 查看内存信息
cache: 查看高速缓存信息
connector: 查看连接器信息
slot: 查看插槽信息
```
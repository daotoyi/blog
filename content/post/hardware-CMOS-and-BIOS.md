---
title: "CMOS 和 BIOS"
date: "2024-01-01 17:01:00"
lastmod: "2024-01-01 17:01:55"
categories: ["Hardware"]
draft: false
---

## CMOS {#cmos}

-   CMOS（Complementary Metal-Oxide-Semiconductor，互补金属氧化物半导体）是一块可读写的 RAM（随机存储器）芯片，位于计算机主板中。
-   它主要用于存储计算机系统的实时时钟、硬件配置信息以及一些系统设置。
-   CMOS 芯片的特点是低功耗、静态工作，因此在计算机断电后，它仍能保持数据。


## BIOS {#bios}

-   BIOS（Basic Input/Output System，基本输入输出系统）是一组固化在计算机主板 ROM（只读存储器）芯片上的程序。
-   BIOS 主要负责管理计算机硬件与软件之间的交互，包括系统启动、硬件检测、设备驱动和管理等。
-   BIOS 在计算机启动时执行，为操作系统提供硬件控制和初始化。


## 区别 {#区别}

-   存储位置：CMOS 存储在主板上的 RAM 芯片中，BIOS 存储在主板的 ROM 芯片中。
-   数据保存：CMOS 可以在计算机断电后保持数据，而 BIOS 在断电后无法保留数据。
-   功能：CMOS 主要负责存储系统配置和实时时钟等信息，而 BIOS 主要负责管理硬件与软件之间的交互。
-   访问方式：我们可以通过 BIOS 设置程序（例如：进入 BIOS 设置界面，修改系统参数）来修改 CMOS 中的数据。

CMOS 和 BIOS 的区别在于它们在计算机中的角色和功能。CMOS 是一个存储系统配置和实时时钟的 RAM 芯片，而 BIOS 是一组管理硬件与软件之间交互的程序。
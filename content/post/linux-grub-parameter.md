---
title: "Linux grub parameter"
author: ["SHI WENHUA"]
date: "2024-05-12 05:46:00"
lastmod: "2024-05-12 05:46:22"
categories: ["Linux"]
draft: false
---

-   quiet
    启动系统的过程中，如果没有 quiet，那么内核就会输出很多内核消息，这些内核消息就包括的了系统启动过程中运行了哪些程序.
-   splash
    splash 是一个不可或缺的参数，系统很多核心程序，都需要这个参数，且这个参数与可视化界面有关，没有就可能导致屏幕一片空白
-   nomodtest
    nomodeset，就可以告诉内核，系统启动过程中，暂时不运行图像驱动程序.
-   GRUB_CMDLINE_LINUX
    -   GRUB_CMDLINE_LINUX：一直生效
    -   GRUB_CMDLINE_LINUX_DEFAULT：仅引导过程中生效
    -   一般 linux 系统启动后，内核先走 GRUB_CMDLINE_LINUX 然后走 GRUB_CMDLINE_LINUX_DEFAULT，
    -   而如果是恢复模式 recovery mode，只会生效 GRUB_CMDLINE_LINUX

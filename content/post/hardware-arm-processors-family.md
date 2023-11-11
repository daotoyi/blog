---
title: "ARM 处理器家族"
date: "2023-10-14 17:11:00"
lastmod: "2023-10-14 17:11:33"
categories: ["Hardware"]
draft: false
---

ARM 处理器产品分为经典 ARM 处理器系列和最新的 Cortex 处理器系列。


## ARM 处理器家族 {#arm-处理器家族}

根据应用范围的不同，ARM 处理器可以分类成 3 个系列：

-   Application Processors （应用处理器）
    -   面向移动计算，智能手机，服务器等市场的的高端处理器。
    -   这类处理器运行在很高的时钟频率（超过 1GHz），
    -   支持像 Linux，Android，MS Windows 和移动操作系统等完整操作系统需要的内存管理单元（MMU）。
-   Real-time Processors （实时处理器）
    -   面向实时应用的高性能处理器系列，例如硬盘控制器，汽车传动系统和无线通讯的基带控制。
    -   多数实时处理器不支持 MMU，不过通常具有 MPU、Cache 和其他针对工业应用设计的存储器功能。
    -   实时处理器运行在比较高的时钟频率（例如 200MHz 到 &gt;1GHz ），响应延迟非常低。
-   MicrocontrollerProcessors （微控制器处理器）
    -   微控制器处理器通常设计成面积很小和能效比很高。
    -   通常这些处理器的流水线很短，最高时钟频率很低（虽然市场上有此类的处理器可以运行在 200Mhz 之上）。

![](https://pic4.zhimg.com/80/v2-d2670ac5a0a851ea02423d1615692557_1440w.webp)


## Cortex-M 处理器家族 {#cortex-m-处理器家族}

Cortex-M 处理器家族更多的集中在低性能端，但是这些处理器相比于许多微控制器使用的传统处理器性能仍然很强大。例如，Cortex-M4 和 Cortex-M7 处理器应用在许多高性能的微控制器产品中，最大的时钟频率可以达到 400Mhz。
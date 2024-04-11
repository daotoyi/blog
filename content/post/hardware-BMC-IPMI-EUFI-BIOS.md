---
title: "BMC、IPMI、UEFI 和 BIOS"
date: "2024-02-09 18:35:00"
lastmod: "2024-02-09 18:36:12"
categories: ["Hardware"]
draft: false
---

## BIOS {#bios}

（Basic Input Output System），即基础输入输出系统，是刻在主板 ROM 芯片上不可篡改的启动程序，BIOS 负责计算系统自检程序（POST，Power On Self Test）和系统自启动程序，因此是计算机系统启动后的第一道程式。由于不可篡改性，故程序存储在 ROM 芯片中，并且在断电后，依然可以维持原有设置。

BIOS 主要功能是控制计算机启动后的基本程式，包括硬盘驱动（如装机过程中优先选择 DVD 或者 USB 启动盘），键盘设置，软盘驱动，内存和相关设备。


## BMC 与 IPMC {#bmc-与-ipmc}

-   BMC（Baseboard Management Controller）基板管理控制器，
-   IPMI（Intelligent Platform Management Interface）智能型平台管理接口

是服务器的基本核心功能子系统，负责服务器的硬件状态管理、操作系统管理、健康状态管理、功耗管理等核心功能。
**BMC 是独立于服务器系统之外的小型操作系统** ，是一个集成在主板上的芯片，也有产品是通过 PCIE 等形式插在主板上，对外表现形式只是一个标准的 RJ45 网口，拥有独立 IP 的固件系统.

**IPMI 是一组交互标准管理规范** ，由 Intel、HP、Dell 和 NEC 公司于 1998 年 9 月 16 日共同提出，主要用于服务器系统集群自治，监视服务器的物理健康特征，如温度、电压、风扇工作状态、电源状态等。同时，IPMI 还负责记录各种硬件的信息和日志记录，用于提示用户和后续问题的定位。

IPMI 是独立于主机系统 CPU、BIOS/UEFI 和 OS 之外，可独立运行的板上部件，其核心部件即为 BMC。或者说，BMC 与其他组件如 BIOS/UEFI、CPU 等交互，都是经由 IPMI 来完成。在 IPMI 协助下，用户可以远程对关闭的服务器进行启动、重装、挂载 ISO 镜像等。

-   IPMI 逻辑图

{{< figure src="https://pic4.zhimg.com/80/v2-4be64d339c4f231c2161a6fb74ab95bb_1440w.webp" >}}


## EFI 与 UEFI {#efi-与-uefi}

EFI（Extensible Firmware Interface）， **可扩展固件接口** ，由于传统的 BIOS 是基于 16 位处理器开发的汇编程序，在面对 32/64 处理器时，效率低下的短板即暴露出来，因此， Intel 推出的一种计算系统中 BIOS 新的替代升级方案。

UEFI（Unified Extensible Firmware Interface）， **统一可扩展固件接口，是 EFI 的规范化版本，也是 BIOS 的进化版** 。为便于将 UEFI BIOS 与传统 BIOS 区分，传统 BIOS 又被称为 Legacy BIOS。

UEFI 负责加电自检（POST）、联系操作系统以及提供连接操作系统与硬件的接口。

UEFI BIOS 和 Legacy BIOS 都是为了初始化硬件平台并引导操作系统。两者主要差异在于 Legacy BIOS 无统一标准，而 UEFI BIOS 统一定义了固件和操作系统之间的接口标准。

优劣势比较：

1.  UEFI BIOS 主要以 C 语言编写，易于实现跨架构跨平台支持并共享代码模块，而 Legacy BIOS 通过则是汇编语言编写
2.  UEFI BIOS 完整支持新固件安全功能，从最大程度上降低固件被攻击的风
3.  Legacy BIOS 移植性差，重复开发现象严重


## 行业情况 {#行业情况}

根据指令集不同，可分为

-   X86 架构（CISC，复杂指令集） ，主要厂商包括 Intel/AMD/海光/兆芯；
-   非 X86 架构（RISC，精简指令集），主要厂商包括鲲鹏（ARM）、飞腾（ARM）、龙芯（MIPS）和申威（Alpha）。

在 BIOS/BMC 产业链中，CPU 处于产业上游，且上游 CPU 厂商系统核心代码授权与 BIOS/BMC 经营密切相关，固件厂商只有在获得 CPU 相关核心参数后，才有资质开发基于其版本的 BIOS/BMC 程序。

全球 X86 计算设备中，PC、服务器等采用的芯片主要是 Intel 的 X86 架构芯片，因此，Intel 授权代码是 BIOS/BMC 工作开展的前提，全球目前只有四家公司与英特尔签订合作协议，用于独立开发商业化用途的 X86 架构 BIOS，它们分别是：

-   美国的 AMI、Phoenix
-   中国台湾 Insyde
-   卓易信息全资子公司南京百敖。

-   BIOS/BMC 产业链一览

{{< figure src="https://pic3.zhimg.com/80/v2-17362572234ef7ae9dbf1843a9074162_1440w.webp" >}}

全球主流 X86 架构 BIOS 固件产品和技术，长期垄断在美国的 AMI、 Phoenix，中国台湾 Insyde 三家公司手中，其中 Phoenix 起步最早，AMI 当前规模最大，而 Insyde 为后起之秀。大陆 X86 架构独立厂商，仅卓易信息旗下全资子公司百敖具备 BIOS、BMC 固件产品研发能力，但整体市场规模、技术实力与上述厂商仍有差距。


## 参考 {#参考}

-   [什么是BMC、IPMI、UEFI和BIOS？](https://zhuanlan.zhihu.com/p/339738609)
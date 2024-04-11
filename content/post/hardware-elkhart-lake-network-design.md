---
title: "Elkhart lake 方案的网络设计"
date: "2023-10-13 21:53:00"
lastmod: "2024-01-23 17:51:23"
categories: ["Hardware"]
draft: false
---

-   CPU 支持 8 条 PCIe 通道，但只有 6 个 port 能接外设，分别如下使用：
-   目前方案中未使用 PCIe 桥，其中 4 个 Lane 接 4 路网络，1个 Lane 接主板，另 1 个 Lane 默认接背板，当有压缩卡需求时，可跳线接到压缩卡上。
-   6 网口配置时，其他 2 个网口用 PSE（Programmable Services Engine）实现。
-   在 J6413 CPU 中集成了 ARM Cotex-M7，使用其支持的 GbE 扩展两路网络，如下图：

{{< figure src="https://raw.githubusercontent.com/daotoyi/picsbed/main/img/202309242009605.jpg" >}}

{{< figure src="https://raw.githubusercontent.com/daotoyi/picsbed/main/img/202309242010411.jpg" >}}

-   在 Elkhart lake（.J6413）方案中，按 4/6 网口需求设计网络，若增加网络需求，需要再增加网络扩展。相应的扩展方案有如下选择：
-   常用使用桥芯片：PCIe（CPU）--- 桥芯片 ---- MAC --- PHY --- Transformer --- RJ45
    -   PCIe 桥扩展方案实现更多网络扩展需求，扩展网卡单个网卡可能实现 1000M 带宽，但所有扩展网卡的带宽受限于桥芯片的总带宽。
-   也可使用 FPGA 扩展方案(类似于国产网关机复旦微 FPGA 方案)：SGMII(PSE) --- FPGA --- PHY --- Transformer --- RJ45
    -   采用 FPGA 扩展方案只能支持 10M/100M 带宽。
    -   可以将 MAC 媒体访问控制协议集成在 FPGA 中。
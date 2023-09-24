---
title: "无线通信"
date: "2023-09-24 18:46:00"
lastmod: "2023-09-24 18:46:15"
categories: ["Hardware"]
draft: false
---

## 传输距离 {#传输距离}

-   短距离通信
    -   Zigbee
    -   Wi-Fi
    -   Bluetooth
    -   Z-wave
-   广域网通信
    -   低功耗广域网（LPWAN
        -   非授权频段
            -   Lora
            -   Sigfox
        -   授权频段（3GPP/3GPP2 等国家组织
            -   GSM
            -   CDMA
            -   WCDMA
            -   LTE


## NB-IoT {#nb-iot}

-   协商统一于
    -   NB-CIoT：Huawei、QualCOMMt 和 Neul 联合提出
    -   NB-LTE：ERIC、ZTE、Nokia 等厂商联合提出
    -   NB-CIoT 与 NB-LTE 区别
        -   前者对于 LTE 而言相当于提出了一种全新的空口技术，意味着与旧版 LTE 网络存在兼容问题，在网络侧理论上改动较大; 而后者倾向和现有 LTE 网络尽量兼容。
        -   NB-CIoT 在增强室内覆盖、支持巨量低速率终端、减少终端复杂度、降低功耗和时延、与 GSM/UMTS/LTE 的干扰共存、对 GSM/EDGE 基站的硬件影响等方面均满足研究设想的指标要求，最关键的是 NB-CIoT 模块的成本估算甚至可以低于 GSM 模块，而 NB-LTE 成本虽然比 eMTC 低但还是会高于 GSM 模块。
-   特性
    -   灵活部署、窄带、低速率、低成本、高容量
        -   独立部署：可以利用单独的频带，适合用于 GSM 频段的重耕
        -   保护带部署 Guard-band 模式：可以利用 LTE 系统中边缘无用频带;
        -   带内部署：可以利用 LTE 载波中间的任何资源块
    -   覆盖增强、低时延敏感
    -   低功耗
        -   NB-IoT 借助 PSM 和 eDRX 可实现更长待机，PSM(Power Saving Mode，节电模式)
    -   不支持连接态的移动性管理
        -   最初就被设想为适用于移动性支持不强的应用场景(如智能抄表、智能停车)，同时也可简化终端的复杂度、降低终端功耗
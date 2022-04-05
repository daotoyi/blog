+++
title = "v2ray 与 Xray"
date = 2022-04-03T21:44:00+08:00
lastmod = 2022-04-03T21:45:31+08:00
tags = ["Xray", "v2ray"]
categories = ["VPS"]
draft = false
+++

## v2ray/Project V {#v2ray-project-v}

V2Ray 的由来：V2Ray 是 继 Shadowsocks 作者@clowwindy 被请去喝茶之后，V2Ray 项目组为表示抗议而开发的，后破娃酱@breakwa11 也被请喝茶，V2Ray 项目原作者隐匿，项目长期停滞不前。于是，原 V2Ray 社区成员组建了 V2fly 社区，并继续 V2Ray 的维护开发，同时 Project V 项目由此诞生。

-   V2Ray 是构建特定网络环境工具的项目 Project V 下的最核心的工具之一（因为其核心不只有 V2Ray）;
-   Project V 其实是一个工具集，它可以帮助你打造专属的基础通信网络。


## Xray/Project X {#xray-project-x}

Xray 是 Project X 项目的核心模块。

由于 V2Ray 一直遵循 MIT 协议，Project V 项目社区(V2fly 社区)的维护团队发起投票，并最终认定 XTLS 不符合协议要求，于是在 V2ray-core 4.33.0 版移除了 XTLS 黑科技。

prx 和其支持者另起炉灶，很快就创建了 Project X 项目 和其核心 Xray，并以 XTLS 为核心协议陆续发布了 Xray-core 的多个版本，于是 Xray 诞生了。

Xray 和 Project X 项目与 V2Ray 和 Project V 项目几乎是一一对应的。

-   Xray 是 V2Ray 的超集，就是包含 V2Ray 所有的功能，并完全兼容 V2Ray；
-   而 Project X 就是 Project V 的超集，也是完全兼容。

因此，我们可以把 Xray 看成 V2Ray 的增强版，以 XTLS 为核心协议。
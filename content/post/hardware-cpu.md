---
title: "CPU"
date: "2023-01-01 11:02:00"
lastmod: "2023-04-12 10:31:06"
tags: ["cpu"]
categories: ["Hardware"]
draft: false
---

## 线程 {#线程}

操作系统是通过线程来执行任务的，一般情况下内核单元和线程是 1:1 对应关系，即几核 CPU 就拥有几个线程，如果采用了 CPU 的虚拟化技术(Virtualization Technolegy，简称 VT)，使核心数与线程数形成 1:2 的关系，可以大幅提升了其多任务、多线程性能。

-   多个物理 CPU,各个 CPU 通过总线进行通信，效率比较低
    ![](https://raw.githubusercontent.com/daotoyi/picsbed/main/img/202301011046235.png)

-   多核 CPU,不同的核通过 L2 cache 进行通信，存储和外设通过总线与 CPU 通信。
    ![](https://raw.githubusercontent.com/daotoyi/picsbed/main/img/202301011047695.png)

-   多核超线程每个核有两个逻辑的处理单元，两个线程共同分享一个核的资源。
    ![](https://raw.githubusercontent.com/daotoyi/picsbed/main/img/202301011048040.png)


## 温度 {#温度}

1.  Tjunction 温度
    -   CPU 核心中设置了一个半导体传感器，用来监测核心的温度，叫做 Tjunction 温度。
    -   一个核心一个 Tjunction 温度。
2.  Tcase 温度
    -   CPU 的顶盖，也就是 Tcase 温度
    -   一个 CPU 一个 Tcase 温度。
3.  主板 CPU 温度
    1.  如果主板在 CPU 下面设置了传感器，那么主板也能监测 CPU 温度。
4.  TjMax:
    -   是 Intel 定义的一个核心最高温度。
    -   如果运行期间 Tjunction 温度超过 TjMax 之后，就会触发温度墙进行限制，从而降低核心温度。
    -   TjMax 是每个核心都提供的，只不过一般来说每个核心的 TjMax 都一样。
    -   CPU 核心温度才是关键,其他温度值，只能是一个参考。


##  {#d41d8c}
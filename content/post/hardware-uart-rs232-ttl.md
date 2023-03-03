---
title: "UART、RS232、TTL 关系浅析"
date: "2023-01-31 22:50:00"
lastmod: "2023-02-01 08:25:07"
categories: ["Hardware"]
draft: false
---

## UART {#uart}

在通信和计算机科学中，Serial communication 是一个通用概念，泛指所有的串行的通信协议，如 RS232、USB、I2C、SPI、1-Wire、Ethernet 等。这里的串行（serial），是相对并行通信（parallel communication）来说的，如下图：

{{< figure src="https://pic1.zhimg.com/v2-5157663cc830482be4526ac4a5560a84_b.jpg" >}}

1.  发送端在发送串行数据的同时，提供一个时钟信号，并按照一定的约定（例如在时钟信号的上升沿的时候，将数据发送出去）发送数据，接收端根据发送端提供的时钟信号，以及大家的约定，接收数据。这就是常说的同步串行通信（Synchronous serial communication），I2C、SPI 等有时钟信号的协议，都属于这种通信方式。

2.  发送端在数据发送之前和之后，通过特定形式的信号（例如 START 信号和 STOP 信号），告诉接收端，可以开始（或者停止）接收数据了。与此同时，收发两方会约定一个数据发送的速度（就是大名鼎鼎的波特率），发送端在发送 START 信号之后，就按照固定的节奏发送串行数据，与此同时，接收端在收到 START 信号之后，也按照固定的节奏接收串行数据。这就是常说的异步串行通信（Asynchronous serial communication），我们本节的主角----串口通信，就是这种通信方式。

    UART(Universal Asynchronous Receiver/Transmitter) 即是规定编码格式、bit rate，产生通信所需的 bit 流的标准。


## COM 口和 RS232 {#com-口和-rs232}

COM 口是指针对串行通信协议的一种端口，是 PC 上异步串行通信口的简写，大部分为 9 针孔 D 型。COM 口里分 RS232，RS422 和 RS485，传输功能依次递增。由于历史原因，IBM 的 PC 外部接口配置为 RS232，成为实际上的 PC 界默认标准。

RS232 或者 RS485，它更多的是规定电气特性和各个引脚的功能定义，如 用-3V— -15V 之间的任意电平表示逻辑“1” ；用+3V — +15V 电平表示逻辑“0”，这里采用的是负逻辑。


## TTL {#ttl}

TTL 全名是晶体管-晶体管逻辑集成电路(Transistor-Transistor Logic)，这种串行通信，对应的物理电平，始终是在 0V 和 Vcc 之间，其中常见的 Vcc 是 5V 或 3.3V。TTL 高电平 1 是&gt;=2.4V，低电平 0 是&lt;=0.5V（对于 5V 或 3.3V 电源电压），这里是正逻辑。


## 关系 {#关系}

RS232 和 TTL 之间的转换，不仅仅是简单的电平转换，还要考虑到其他一些因素，比如调节和矫正一些电平（提高或降低对应的电平），确保可能的有害的 RS232 电压不会破坏微控制器的串口针脚。这里有很成熟的方案，我们可以通过 MAX3232 之类的芯片，把 TTL 电平转为 RS232 电平。

如何分辨究竟是 TTL 还是 RS232 呢？一般来说，由 SOC 芯片引脚直接引出的一般是 TTL，其高低电平不需要任何转换，可以由芯片之间驱动，节省费用；而中间接有转换芯片的可能就是 RS232 了。


## REF {#ref}

-   [UART、RS232、TTL关系浅析](https://zhuanlan.zhihu.com/p/25893717)
---
title: "Virtual Machine"
lastmod: "2023-08-29 15:39:12"
categories: ["Tools"]
draft: true
---

## 网络模式 {#网络模式}


### Bridged（桥接模式） {#bridged-桥接模式}

桥接模式就是将主机网卡与虚拟机虚拟的网卡利用虚拟网桥进行通信。在桥接的作用下，类似于把物理主机虚拟为一个交换机，所有桥接设置的虚拟机连接到这个交换机的一个接口上，物理主机也同样插在这个交换机当中，所以所有桥接下的网卡与网卡都是交换模式的，相互可以访问而不干扰。

在桥接模式下，虚拟机 ip 地址需要与主机在同一个网段，如果需要联网，则网关与 DNS 需要与主机网卡一致。


### NAT（网络地址转换模式） {#nat-网络地址转换模式}

如果网络 ip 资源紧缺，但是你又希望你的虚拟机能够联网，这时候 NAT 模式是最好的选择。NAT 模式借助虚拟 NAT 设备和虚拟 DHCP 服务器，使得虚拟机可以联网。

主机网卡直接与虚拟 NAT 设备相连，然后虚拟 NAT 设备与虚拟 DHCP 服务器一起连接在虚拟交换机 VMnet8 上，这样就实现了虚拟机联网。

这就是 NAT 模式，利用虚拟的 NAT 设备以及虚拟 DHCP 服务器来使虚拟机连接外网，而 VMware Network Adapter VMnet8 虚拟网卡是用来与虚拟机通信的。


### Host-Only（仅主机模式） {#host-only-仅主机模式}

Host-Only 模式其实就是 NAT 模式去除了虚拟 NAT 设备，然后使用 VMware Network Adapter VMnet1 虚拟网卡连接 VMnet1 虚拟交换机来与虚拟机通信的，Host-Only 模式将虚拟机与外网隔开，使得虚拟机成为一个独立的系统，只与主机相互通讯。


### 注意 {#注意}

-   桥接模式：自动生成的 IP 地址会随着主机的 IP 随时变化。
-   NAT 模式：虚拟机的 IP 地址一旦生成，就不会改变了。


### 虚拟网络编辑器 {#虚拟网络编辑器}

-   VMnet0（桥接模式）

VMnet0 表示的是用于桥接模式下的虚拟交换机。

-   VMnet1（仅主机模式）

VMnet1 表示的是用于仅主机模式下的虚拟交换机。对应主机下的 VMware Network Adapter VMnet1。

-   VMnet8（NAT 模式）

VMnet8 表示的是用于 NAT 模式下的虚拟交换机。对应主机下的 VMware Network Adapter VMnet18。


### 参考 {#参考}

-   [vmware 虚拟机三种网络模式 的区别](https://zhuanlan.zhihu.com/p/366372725)


## VirtualBox 显示界面小 {#virtualbox-显示界面小}


### 增强功能 {#增强功能}

1.  设备-安装增强功能
2.  挂载光盘后执行：=sudo ./VBoxLinuxAdditions.run=


### 显卡 {#显卡}

1.  设置-显卡-VBoxSVGA
2.  视图中自动缩放模式/自动调整窗口/显示大小
---
title: "HSR/PRP 冗余协议"
date: "2022-08-18 22:54:00"
lastmod: "2022-08-18 22:55:12"
categories: ["Hardware"]
draft: false
---

HSR/PRP 全称分别为 High-availability Seamless Redundancy（高可靠性无缝冗余）与 Parallel Redundancy Protocol（并行冗余协议）.


## PRP {#prp}

并行冗余协议

{{< figure src="http://5b0988e595225.cdn.sohucs.com/images/20181225/6a6219fb14334019a14b4816236ecaa2.png" >}}

帧通过兼容设备和交换机以并行方式遍历两个网络。即使在两个网络中的任何一个发生故障的情况下，这也可以保证帧无延迟地传输。


## HSR {#hsr}

高可用性无缝冗余协议

{{< figure src="http://5b0988e595225.cdn.sohucs.com/images/20181225/e06b1d6a58e94a10b858ee64bc3adca1.png" >}}

帧通过兼容设备和交换机在两个方向上以并行方式遍历该网络。即使在该环形网络发生单一故障的情况下，这也可以保证帧无延迟地传输。
+++
title = "GCP 笔记"
date = 2022-03-05T17:20:00+08:00
lastmod = 2022-03-11T08:03:33+08:00
tags = ["GCP"]
categories = ["VPS"]
draft = false
+++

[GCP（Google Cloud Platform）入门](https://zhuanlan.zhihu.com/p/40983101)


## 防火墙 {#防火墙}

建站之后若无法访问, 可能需要设置防火墙规则([入站防火墙](https://www.liuzhanwu.cn/4089.html))([GCP 建站及配置](https://blog.csdn.net/nicesnow5/article/details/104383313)).

-   流量方向是：入站
-   对匹配项执行的操作：允许
-   目标：网络中的所有实例
-   来源 IP 地址范围：0.0.0.0/0


## 结算账号 {#结算账号}

当免费试用期结束后(3 个月/年), 可以申请亲的结算账号,继续免费试用并且保持原有实例([谷歌云 | 谷歌云获取全新300美金后，更改结算账户不丢失原有实例](https://www.vediotalk.com/archives/18285)).
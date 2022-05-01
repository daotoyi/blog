---
title: "AWS 笔记"
date: "2022-04-10 22:15:00"
lastmod: "2022-04-30 12:50:17"
tags: ["AWS"]
categories: ["VPS"]
draft: false
---

## Amazon Web Services (AWS) {#amazon-web-services--aws}


## Notes {#notes}

-   注册 AWS 要使用从未在 AWS 上用过的信用卡，不然你就不符合 Free Tier 的使用条件，所有服务将会按需收费
-   申请免费成功后免费服务只有一年的有效期，到期时可导出数据并停止所有服务
    -   免费额度只够创建一个 EC2 实例
    -   创建实例时，要选带有免费提示的操作系统，这类系统是免费提供的，不另收费；
    -   每月的免费存储是 5G，另外 GET，POST 等操作可能会超出免费额度；
    -   流入 AWS 的流量完全是免费的，但每月的免费流出流量只有 15G，超出部分就要收费了。
-   弹性 IP 没有捆绑到 EC2 实例时，一定要记得释放，不然它会按小时收费。
    -   每月头 100 次捆绑 Elastic IP 到 EC2 实例是免费的，超出则收费啦
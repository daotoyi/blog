---
title: "Windows optimize settings"
lastmod: "2022-07-14 19:29:37"
categories: ["Tools"]
draft: true
---

## 删除恶意软件 {#删除恶意软件}

Win + r ---&gt; mrt ---&gt; 下一步


## 磁盘清理 {#磁盘清理}

-   C 盘
    -   属性
        -   常规
            -   磁盘清理
                -   确认
                -   清理系统文件
                    -   系统还原或卷影复制
                        -   确认
-   设置
    -   系统和保留空间
        -   **\***
            -   禁用系统保护
    -   挪走“虚拟内存”
        -   虚拟内存非常占用电脑的内存，但是可以保证系统的稳定性，所以出于稳定考虑，不禁用，建议挪走。
    -   系统
        -   存储
            -   配置存储感知或立即运行
                -   勾选“删除我的应用未在使用的临时文件”，打击“立即清
        -   临时文件
            -   勾选要删除的临时文件，点击“删除文件”
-   **关闭休眠功能** (5G+)
    -   win+R
        -   cmd
            -   powercfg -h off
-   浏览器清理
-   文件夹清理
    -   应用缓存文件
        -   C:\Users\\用户名\AppData\Local\Temp
        -   C:\Users\\用户名\AppData\Roaming\Adobe\Common\Media Cache
        -   C:\Users\\用户名\AppData\Roaming\Adobe\Common\Media Cache Files
    -   系统缓存文件
        -   C:\Windows\SoftwareDistribution\Download
        -   C:\Windows\Temp
-   临时文件转移
-   关闭 Win10“保留的存储”
    -   Win10 的“保留的存储”是为系统更新文件预留出来的空间，如果 C 盘吃紧了，可以禁用这个功能


## Ref {#ref}


### C 盘全面清理教程！彻底清理所有垃圾！ {#c-盘全面清理教程-彻底清理所有垃圾}


### [电脑C盘满了？试试这4招，保底清出10G以上空间！](https://mp.weixin.qq.com/s/NNVQQr2hFJUjq2MRslmjWQ) {#电脑c盘满了-试试这4招-保底清出10g以上空间}
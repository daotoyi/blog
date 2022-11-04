---
title: "Rsync"
lastmod: "2022-10-31 22:55:53"
categories: ["Tools"]
draft: true
---

## basic {#basic}

rsync 可以理解为 remote sync（远程同步），但它不仅可以远程同步数据（类似于 scp 命令），还可以本地同步数据（类似于 cp 命令）。

不同于 cp 或 scp 的一点是，使用 rsync 命令备份数据时，不会直接覆盖以前的数据（如果数据已经存在），而是先判断已经存在的数据和新数据的差异，只有数据不同时才会把不相同的部分覆盖。


## opreration {#opreration}

rsync 命令的基本格式有多种，分别是：

> [root@localhost ~]# rsync [OPTION] SRC DEST
> [root@localhost ~]# rsync [OPTION] SRC [USER@]HOST:DEST
> [root@localhost ~]# rsync [OPTION] [USER@]HOST:SRC DEST
> [root@localhost ~]# rsync [OPTION] [USER@]HOST::SRC DEST
> [root@localhost ~]# rsync [OPTION] SRC [USER@]HOST::DEST

OPTION 常用 -av

针对以上 5 种命令格式，rsync 有 5 种不同的工作模式：

-   第一种用于仅在本地备份数据；
-   第二种用于将本地数据备份到远程机器上；
-   第三种用于将远程机器上的数据备份到本地机器上；
-   第四种和第三种是相对的
-   同样第五种和第二种是相对的
-   它们各自之间的区别在于登陆认证时使用的验证方式不同。

使用 rsync 在远程传输数据（备份数据）前，是需要进行登陆认证的，这个过程需要借助 ssh 协议或者 rsync 协议才能完成。

在 rsync 命令中，如果使用单个冒号（:），则默认使用 ssh 协议；反之，如果使用两个冒号（::），则使用 rsync 协议。

> ssh 协议和 rsync 协议的区别在于，rsync 协议在使用时需要额外配置，增加了工作量，但优势是更加安全；反之，ssh 协议使用方便，无需进行配置，但有泄漏服务器密码的风险。
---
title: "Linux CIFS 与 SMB"
date: "2024-01-03 11:46:00"
lastmod: "2024-01-03 11:46:43"
categories: ["Linux"]
draft: false
---

## SMB {#smb}

Server Message Block - SMB，即服务(器)消息块，是 IBM 公司在 80 年代中期发明的一种文件共享协议。它只是系统之间通信的一种 **方式（协议）** ，并不是一款特殊的软件。

SMB 协议被设计成为允许计算机通过本地局域网（LAN）在远程主机上读写文件。远程主机上通过 SMB 协议开放访问的目录称为 共享文件夹。


## CIFS {#cifs}

Common Internet File System - CIFS，即通用因特网文件系统。CIFS 是 SMB 协议的衍生品，即 CIFS 是 **SMB 协议的一种特殊实现** ，由美国微软公司开发。


## CIFS 与 SMB {#cifs-与-smb}

由于 CIFS 是 SMB 的另一种实现 ，那么 CIFS 和 SMB 的客户端之间可以互访就不足为奇。

二者都是协议级别的概念，名字不同自然存在实现方式和性能优化方面的差别，如文件锁、LAN/WAN 网络性能和文件批量修改等。

CIFS 与 SMB：该用哪个？ 时至今日，仍旧应该使用 SMB 这个名称。 这里有两个原因：

-   CIFS 实现的协议至今仍很少被使用。大多数现代存储系统不再使用 CIFS，而是使用 SMB2 或 SMB3。在 Windows 系统环境中，SMB2 和 SMB3 是事实使用的标准。
-   在学术上 CIFS 有消极的含义。SMB2 和 SMB3 是对 CIFS 协议的重大升级，存储架构工程师大多不喜欢这种命名。


## Samba 和 NFS {#samba-和-nfs}

CIFS 和 SMB 远不是文件共享协议的全部，如果要与旧版系统相互操作，很可能还需要其他的协议。Samba 和 NFS 就是应该了解的另外两种优秀的文件共享协议。


## SAMBA {#samba}

Samba 是 \*一组不同功能程序组成的应用集合\*，它能让 Linux 服务器实现文件服务器、身份授权和认证、名称解析和打印服务等功能。

与 CIFS 类似，Samba 也是 SMB 协议的实现，它允许 Windows 客户访问 Linux 系统上的目录、打印机和文件（就像访问 Windows 服务器时一样）。重要的是，Samba 可以将 Linux 服务器构建成一个域控制器。这样一来，就可以直接使用 Windows 域中的用户凭据，免去手动在 Linux 服务器上重新创建的麻烦。


## NFS {#nfs}

Network File System - NFS，即网络文件系统。由 Sun 公司面向 SMB 相同的功能（通过本地网络访问文件系统）而开发，但它与 CIFS/SMB 完全不兼容。也就是说 NFS 客户端是无法直接与 SMB 服务器交互的。

NFS 用于 Linux 系统和客户端之间的连接。而 Windows 和 Linux 客户端混合使用时，就应该使用 Samba。
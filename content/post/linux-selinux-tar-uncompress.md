---
title: "Linux tar 备份还原系统后无法进入桌面"
author: ["SHI WENHUA"]
date: "2022-03-31 22:53:00"
lastmod: "2024-03-27 16:47:09"
tags: ["selinux"]
categories: ["Linux"]
draft: false
---

## 现象 {#现象}

如果因为某些缘故，所以你的系统必须要以备份的数据来回填到原本的系统中，那么得要 特别注意复原后的系统的 SELinux 问题！它可能会让你的系统⽆法存取某些配置⽂件内 容，导致影响到系统的正常使⽤权。


## 原因 {#原因}

⼤部分原因就是因为 `/etc/shadow` 这个密码⽂件的 `SELinux` 类型在还原时被更改了！导致系统的登⼊程序⽆法顺利的存取它， 才造成⽆法登⼊的窘境。


## 解决 {#解决}

简单的处理⽅式有这⼏个：

-   透过各种可⾏的救援⽅式登⼊系统，然后修改 /etc/selinux/config ⽂件，将 SELinux 改成 permissive 模式，重新启动后系统就正常了；
-   在第⼀次复原系统后，不要⽴即重新启动！先使⽤ restorecon -Rv /etc ⾃动修复⼀下 SELinux 的类型即可。
-   透过各种可⾏的⽅式登⼊系统，建⽴ /.autorelabel ⽂件，重新启动后系统会⾃动修复 SELinux 的类型，并且⼜会再次重新启动，之后就正常了！


## 验证 {#验证}


### /.autorelabel {#dot-autorelabel}

使⽤root⽤户在根目录执⾏命令 `touch /.autorelabel` 后重启


### /etc/selinux/config {#etc-selinux-config}

修改⽂件/etc/selinux/config 后重启

```bash
SELINUX=permissive
```

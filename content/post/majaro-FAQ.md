---
title: "Manjaro FAQ"
date: "2022-12-24 14:25:00"
lastmod: "2023-04-21 18:13:23"
categories: ["Linux"]
draft: false
---

## update systecm {#update-systecm}


### <span class="org-todo done DONE">DONE</span> - python-pip:xxx files exists. {#python-pip-xxx-files-exists-dot}

```bash
pacman -R python-pip
pacman -Syu
```


### <span class="org-todo done DONE">DONE</span> xxx:signature from "xxx &lt;xxx@manjaro.org&gt;" is unknown trust {#xxx-signature-from-xxx-xxx-manjaro-dot-org-is-unknown-trust}

将 /etc/pacman.conf 中的 SigLevel 值改为 Never

```cfg
[core]
#SigLevel = PackageRequired
SigLevel = Never
Include = /etc/pacman.d/mirrorlist
```

如果你的仓库包括 extra 和 community，在对应的节中也修改 SigLevel 的值 为 Never.

修改完保存，再运行 pacman 就没有问题了。

-   [pacman的 unknown trust 问题](https://www.cnblogs.com/jiqingwu/archive/2012/06/10/arch_linux_pacman_unknown_trust.html)


### Errors occurred, no packages were upgraded. {#errors-occurred-no-packages-were-upgraded-dot}

-   error: failed to commit transaction (invalid or corrupted package)

[Manjaro软件更新失败：无效或已损坏的软件包](https://juejin.cn/post/7091962125660192798)


## update openssl {#update-openssl}


### libcrypto.so.1.1: cannot open shared object file {#libcrypto-dot-so-dot-1-dot-1-cannot-open-shared-object-file}

单独升级 openssl 之后，部分命令（pacman suod ）无法使用，重启无法正常启动。

查看版本：openssl version

```sh
pacman: error while loading shared libraries: libcrypto.so.1.1: cannot open shared object file: No such file or directory
```

> 只升级 openssl 的版本，动态库版本没有升级，系统可用。
> 升级 openssl 版本，同时升级 libcrypto.so.1.1 动态库版本，导致严重的故障，系统不可用。

解决方案： 下载保存对应版本的 OpenSSL 安装包,解压,把/usr/lib 的文件(缺失的)复制到/lib 文件夹里面.

无法启动时，启动 live cd，进入系统 `chroot  /{mountsyspoint}  /bin/zsh` 切换到系统中：

```sh
tar Jxvf openssl-1.1.1.d-2-x86_64.pkg.tar.xz

cp usr/lib/libssl.so.1.1  /lib/libssl.so.1.1
cp usr/lib/libcrypto.so.1.1  /lib/libcrypto.so.1.1
```

-   [manjaro修复因降级OpenSSL导致pacman和sudo不能使用](https://blog.csdn.net/HD2killers/article/details/81145235)
-   [how to fix missing libcrypto.so.1.1?](https://unix.stackexchange.com/questions/723616/how-to-fix-missing-libcrypto-so-1-1)
-   [Index of _packages/o/openssl_](https://archive.archlinux.org/packages/o/openssl/)
-   [升级openssl导致libcrypto.so.1.1动态库不可用](https://blog.csdn.net/qpeity/article/details/115479297)
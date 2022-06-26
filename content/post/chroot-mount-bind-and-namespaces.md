---
title: "Linux chroot(mount –bind | mount namespaces)"
date: "2022-06-25 16:12:00"
lastmod: "2022-06-25 16:13:00"
categories: ["Linux"]
draft: false
---

## chroot {#chroot}

切换根文件系统并运行进程 ,可以改变一个进程的根目录.


## Bind Mount {#bind-mount}

可以将一个目录或文件映射到别处，可以跨越不同的卷。

mount --bind 命令是将前一个目录挂载到后一个目录上，所有对后一个目录的访问其实都是对前一个目录的访问


## Mount Namespaces {#mount-namespaces}

让挂载点在各个进程之间隔离.一个进程不能看到其他进程的挂载点，实现真正的安全。

能真正做到对真正根目录下的子目录做共享、独享（也就是将拥有一个子目录的副本）


## mount --bind | mount namespace {#mount-bind-mount-namespace}


### mount --bind  /etc /test/etc {#mount-bind-etc-test-etc}

它与 mount namespace 的区别是, /etc 仍然对所有进程可见。


## Useage {#useage}

```bash
mkdir /mnt/{dev,proc,sys,run}
# 挂载和构建/dev
mount -v --bind /dev /mnt/dev
# 挂载虚拟内核文件系统
mount -vt devpts devpts /mnt/dev/pts -o gid=5,mode=620
mount -vt proc proc /mnt/proc
mount -vt sysfs sysfs /mnt/sys
mount -vt tmpfs tmpfs /mnt/run
```


## Ref {#ref}

-   [mount --bind使用方法](https://www.cnblogs.com/xingmuxin/p/8446115.html)
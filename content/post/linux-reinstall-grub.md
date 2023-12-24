---
title: "Linux 重新安装 grub"
date: "2023-12-17 23:24:00"
lastmod: "2023-12-17 23:24:49"
categories: ["Linux"]
draft: false
---

```bash
~# mount /dev/sda1 /mnt
~# mount --bind /dev /mnt/dev
~# mount --bind /proc /mnt/proc
~# mount --bind /sys /mnt/sys
~# chroot /mnt

# 若以UEFI方式安装，以/dev/sda1为efi分区，/dev/sda2根分区为例
~# mount /dev/sda2 /tmp
~# mkdir -p /tmp/boot/efi
~# mount /dev/sda1 /tmp/boot/efi
~# for mt in dev proc sys ; do mount --bind /$mt /tmp/$mt ; done
~# chroot /tmp

~# grub-install /dev/sda
~# update-grub
~# exit                                                                #chroot
~# reboot
```
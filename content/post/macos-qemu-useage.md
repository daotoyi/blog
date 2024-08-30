---
title: "macOS qemu 安装 Archlinux"
author: ["SHI WENHUA"]
date: "2024-08-24 22:14:00"
lastmod: "2024-08-25 15:36:42"
categories: ["macOS"]
draft: false
---

## install qemu {#install-qemu}

```bash
brew install qemu

 qemu-system-x86_64 --version
 QEMU emulator version 9.0.2
 Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers
```


## startup archlinux {#startup-archlinux}


### create img {#create-img}

```bash
qemu-img Create -f qcow2 ~/QEMU/archlinux.qcow2 20G
```

-   占用的磁盘空间随着使用逐渐扩展，而非一次分配 20 G 磁盘空间。


### startup archlinux {#startup-archlinux}

```bash
ARCH_TYPE=x86_64 # iso镜像的架构
function archlinux_startup(){
  qemu-system-${ARCH_TYPE} \
    -smp 4 \
    -m 4G \
    -vga virtio \
    -display default,show-cursor=on \
    -usb \
    -device usb-tablet \
    -drive file=archlinux.qcow2,if=virtio \
    -cpu Nehalem-v1 \
    -net user,hostfwd=tcp::2222-:22 \
    -net nic \
    -cdrom archlinux-2024.08.01-x86_64.iso
    # -machine type=q35,accel=hvf \
    # -virtfs local,path=/mnt/shared,mount_tag=host0,security_model=passthrough,id=host0 \
  }
```


### install archlinux {#install-archlinux}

```bash
# 修改密码
passwd root

# 换源
# /etc/pacman.d/mirrors
Server = http://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch

# 磁盘分区
cfdisk /dev/vda
格式mbr
类型Linux
# mac && qume上gpt/linux filesystem无法安装grub，故无法启动
mkfs.ext4 /dev/vda1

# 安装系统
mount /dev/vda1 /mnt
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt  >> /mnt/etc/fstab
cat /etc/fstab
grub-install --root-directory=/mnt /dev/vda

# 切换进入新系统
arch-chroot /mnt
pacman -S grub
grub-install --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

exit
reboot
```


### config archlinux {#config-archlinux}

```bash
# 添加用户
useradd -m -G wheel -s /bin/bash daoyi
passwd daoyi
# 添加用户权限
echo "%wheel ALL=(ALL) ALL"  >> /etc/sudoers

# 安装界面
pacman -S xorg
pacman -S xfce4 xfce4-goodies
# 安装桌面显示管理器（以sddm(Simple Desktop Display Manager)为例）
pacman -S sddm
systemctl enable sddm

# 安装网络 有线和无线
pacman -S iw dialog wpa_supplicant networkmanager dhcpcd
systemctl enable dhcpcd
# 启动界面前要建立普通用户，否则没有合建入口，root不能直接登录
```

```bash
# 配置ssh服务器
pacman -S openssh
systemctl enable sshd
systemctl start sshd


# 配置电脑IP，远程时需要，不设置则无法连接
echo "127.0.0.1 localhost"  >> /etc/hosts
echo "::1 localhost"  >> /etc/hosts
# reboot

# qume启动时配置：hostfwd=tcp:2222-:22，意思是将虚拟机的22号端口映射到host的2222端口
# host 机上输入netstat -anp | grep 2222
# 以下即可登录
ssh -p 2222 root@0.0.0.0
```

-   `tcp4       0      0  *.2222                 *.*                    LISTEN`

<!--listend-->

```bash
# netstat -an | grep 2222
tcp4       0      0  127.0.0.1.2222         127.0.0.1.54456        ESTABLISHED
tcp4       0      0  127.0.0.1.54456        127.0.0.1.2222         ESTABLISHED
tcp4       0      0  *.2222                 *.*                    LISTEN
tcp4       0      0  172.16.254.78.62222    220.181.136.167.443    ESTABLISHED
tcp4    2222      0  172.16.254.78.65165    182.50.15.148.80       CLOSE_WAIT
```


### transfer file {#transfer-file}

-   host
    创建 share 目录，启动 qemu 时加载通过 virtfs 选项将其挂载到虚拟机上
    ```bash
    qemu-system-x86_64 \
        -virtfs local,path=/Users/wenhua/QEMU/share,mount_tag=host0,security_model=passthrough,id=host0 \
    # “-virtfs”选项指定了共享文件夹的参数，
    # “local”表示共享文件夹是本地文件夹，
    # “path”指定了共享文件夹的路径，
    # “mount_tag”指定了共享文件夹在虚拟机中的挂载点，
    # “security_model”指定了安全模型，
    # “id”是共享文件夹的标识符。
    ```
-   qemu vm
    在 qume 虚拟机上，挂载共享文件夹
    ```bash
    mount -t 9p -o trans=virtio,version=9p2000.L host0 /root/share
    # “-t”选项指定了文件系统类型，
    # “9p”是QEMU支持的文件系统类型，
    # “trans”指定了传输协议，
    # “version”指定了文件系统版本，
    # “host0”是共享文件夹的标识符，
    # “/mnt/share”是共享文件夹在虚拟机中的挂载点。
    ```


### Note {#note}

systemd-network

若安装时未配置网络无法联网，因为安装的镜像文件与联网相关的服务默认是关闭，可开启并设置开机自启动。

```bash
systemctl enable systems-networkd systems-resolved
systemctl enable iwd dhcpcd
```

配置自动获取 IP 配置后,开启 systems-networkd systems-resolve

-   /etc/systemd/networkd/00-en3.network
    ```cfg
    [Mathch]
    name=ens3

    [Network]
    DHCP=ipv4
    ```
-   systemctl start systems-networkd

注意在首次安装 archlinux 时就安装网络服务。

```bash
pacman -S iw dialog wpa_supplicant networkmanager dhcpcd
```


## reference {#reference}

-   [Parallels Desktop 安装 Archlinux](https://www.cnblogs.com/wangxu1714/p/17470202.html)
-   [在QEMU虚拟机和宿主机之间传输文件](https://blog.csdn.net/qq_44600038/article/details/130984640)

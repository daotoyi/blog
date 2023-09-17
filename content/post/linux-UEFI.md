---
title: "Linux UEFI"
lastmod: "2023-08-29 22:32:02"
categories: ["Linux"]
draft: true
---

## entrance {#entrance}

在现代基于 UEFI 固件的系统中，shim 已经成为目前所有 Linux 发行版本中必备的一阶 bootloader；而传统上我们熟悉的 grub2 变成了二阶 bootloader。

UEFI 规范里，在 GPT 分区表的基础上，规定了一个 EFI 系统分区（EFI System Partition，ESP），ESP 要格式化成 FAT32，EFI 启动文件要放在“\EFI\\&lt;厂商&gt;”文件夹下面.
├── EFI
│   ├── boot
│   │   └── bootX64.efi
├── Microsoft
├── Clover

/EFI/Boot 这个文件夹放哪个程序都行。无论是“\EFI\Microsoft\Boot\Bootmgfw.efi”，还是“\EFI\Clover\CloverX64.efi”，只要放到“\EFI\Boot”下并且改名“bootX64.efi”，就能在没添加文件启动项的情况下，默认加载对应的系统。


## shim {#shim}


### ESP {#esp}

├── EFI
│   ├── myos
│   │   ├── BOOT.CSV
│   │   ├── BOOTX64.CSV
│   │   ├── fonts
│   │   │   └── unicode.pf2
│   │   ├── grub.cfg
│   │   ├── grubenv
│   │   ├── grubx64.efi
│   │   ├── mmx64.efi
│   │   ├── MokManager.efi
│   │   ├── shim.efi
│   │   ├── shimx64-myos.efi
│   │   └── shimx64.efi
│   └── boot
│          ├── bootx64.efi
│          ├── fallback.efi
│          └── fbx64.efi
└── startup.nsh


### shim first boot {#shim-first-boot}

-   系统完成装机并进行第一次启动的时候，UEFI boot manager 会自动枚举出一个叫做 UEFI OS 的启动选项，该启动选项将 bootloader 程序的路径设置为/EFI/boot/bootx64.efi，即一阶 bootloader shim。
-   shim 的主要工作是启动二阶 bootloader；
    -   shim 会在当前目录下寻找 grubx64.efi，即/EFI/boot/grubx64.efi。
    -   如果不存在，shim 会加载/EFI/boot 目录下的 fbx64.efi(或 fallback.efi)。
    -   该程序的职责是枚举/EFI 目录下的、除 boot 子目录以外的所有子目录，并找到第一个 BOOTX64.CSV 文件。下面是一个记录了自定义的 myos 的 BOOTX64.CSV
        -   该文件记录了二阶 bootloader 的路径（该路径相对于当前的\\目录）和 title。title 字段会被用来创建一个全新的启动选项，该启动选项中的程序路径也会被设定为二阶 bootloader 所在的绝对路径(/EFI/&lt;二阶 bootloader 路径&gt;)
    -   fallback 的作用就是创建一个启动选项，该启动选项指向了/EFI/&lt;bootloader-id&gt;/shimx64.efi,fallback 程序的最后一个工作就是修改 BootOrder 变量，将新创建的启动选项设为最优先启动，然后 issue warm boot 重启系统。
-   /EFI/boot/bootx64.efi -&gt; /EFI/boot/fbx64.efi -&gt; /EFI/BOOTX64.CSV -&gt; 创建启动选项；
-   修改 BootOrder -&gt; /EFI/grubx64.efi -&gt; /EFI/grub.cfg -&gt; /boot/vmlinuz-\* 。


### shim normal boot {#shim-normal-boot}

正常情况下，UEFI boot manager 会根据新的 BootOrder 变量，从新的启动选项启动一阶 bootloader，即/EFI/&lt;bootloader-id&gt;/shimx64.efi。然后，/EFI/&lt;bootloader-id&gt;/shimx64.efi 在当前目录下找到 grubx64.efi，即/EFI/&lt;bootloader-id&gt;/grubx64.efi,进入 grub2 启动流程。


### shim boot {#shim-boot}

-   shim first boot
    -   默认启动选项 UEFI OS -&gt; /EFI/boot/bootx64.efi（本质就是/EFI/boot/shimx64.efi） -&gt; /EFI/boot/fbx64.efi -&gt; /EFI/myos/BOOTX64.CSV（记录了自定义启动选项的名称为 My Linux） -&gt; 自动创建启动选项，并修改 BootOrder 变量，然后自动执行 warm reboot。正常情况下，重启后会进入 shim normal boot 流程。
-   shim normal boot
    -   启动选项 My Linux -&gt; /EFI/myos/shimx64.efi -&gt; /EFI/myos/grubx64.efi -&gt; /EFI/myos/grub.cfg -&gt; /boot/vmlinuz-\* 。正常情况下，不管系统再经过多少次重启，每次都会走该启动流程，不会再执行 shim first boot。


### ref {#ref}

-   [shim启动流程分析](https://zhuanlan.zhihu.com/p/436456032?utm_id=0)
-   [grubx64.efi bootx64.efi](https://www.cnblogs.com/shamoguzhou/p/17380191.html)


## SecureBoot {#secureboot}

Secure Boot 的目的，是防止恶意软件侵入。它的做法就是采用密钥。

UEFI 规定，主板出厂的时候，可以内置一些可靠的公钥。然后，任何想要在这块主板上加载的操作系统或者硬件驱动程序，都必须通过这些公钥的认证。

也就是说，这些软件必须用对应的私钥签署过，否则主板拒绝加载。由于恶意软件不可能通过认证，因此就没有办法感染 Boot。


## shell {#shell}

UEFI Shell 是一个提供用户和 UEFI 系统之间的接口，类似于 CMD。

help 就可以输出所有指令，不做特殊说明，内置命令的命令行参数中的数值使用的是十六进制，和 Linux 不同的是不区分大小写。

常见命令：

| 命令    | 作用             |
|-------|----------------|
| ver     | 展示 shell 的版本号 |
| map -r  | 列出所有设备     |
| fs0:    | 设备号。通过设备号进入设备 |
| devices | 显示 EFI 驱动程序管理的设备 |
| drivers | 显示设备驱动     |
| dh      | 显示设备句柄     |
| ls      | 列出目录内容或者文件信息 |
| echo    | 关闭或者打开回显 |
| pci     | 显示 PCI 设备    |
| devtree | 显示设备树       |
| date    | 显示当前或者系统的日期 |


## grub install {#grub-install}

```bash
#系统默认已经安装grub，uefi环境下，安装的grub组件包括：grub-common、grub-efi-amd64、grub-efi-amd64-bin、grub2-common
apt list grub* #列出grub相关包，可以看出已经安装的grub包，确认是否uefi环境，然后继续

#1. 简单安装
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=mygrub
# grub-install --removable --no-floppy --target=x86_64-efi --boot-directory=/ --efi-directory=/boot
# x86_64-efi就是grub 的uefi引导框架
# --boot-directory=参数指定boot根文件夹
#--efi-directory这个指示了esp挂载的根在哪里。
#--bootloader-id 这个参数会在esp分区的/efi/目录下生成对应的文件夹,和mircosoft，ubuntu等文件夹平级。这个命令并不会生成esp分区的/efi/boot/bootx64.efi 默认启动器，只会生成对应文件夹的/efi/mygrub/grubx64.efi启动器，这个时候就没有默认的启动器，如果你想要,可以复制：

mkdir /boot/efi/efi/boot
mv /boot/efi/efi/mygrub/grubx64.efi /boot/efi/efi/boot


# 2. 定制安装
# 自动生成的启动器，符合大多数要求，为了演示，接下来对其中某些过程进行定制
# 首先要理解grub-install干了什么，它首先调用了grub-mkconfig生成了菜单，然后调用grub-mkimage生成启动映像

#2.1 生成菜单，会自动调用os-prober搜索磁盘的其他系统，生成菜单
mkdir -p /boot/efi/efi/grub2
grub-mkconfig -o /boot/efi/efi/grub2/grub.cfg

# 自动生成的菜单是根据/etc/grub.d/ 下的脚本，和/etc/default/grub来生成的。因为要定制，所以可以对这个生成后的脚本直接进行编辑。

cd /boot/efi/efi/grub2
nano grub.cfg
#一般只需要增加或删减菜单项即可
```


## ref {#ref}

-   [XORBOOT Uefi: 多系统引导程序](http://bbs.wuyou.net/forum.php?mod=viewthread&tid=157812)
-   [使用Grub2定制UEFI启动 (bootx64.efi)](http://bbs.wuyou.net/forum.php?mod=viewthread&tid=413597)
-   [UEFI启动文件bootx64.efi的定制](http://bbs.wuyou.net/forum.php?mod=viewthread&tid=413596)
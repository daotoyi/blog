---
title: "syslinux"
date: "2023-12-24 10:59:00"
lastmod: "2023-12-24 23:10:46"
categories: ["Tools"]
draft: false
---

## 简述 {#简述}

SYSLINUX 是一个小型的 Linux 操作系统，它的目的是简化首次安装 Linux 的时间，并建立修护或其它特殊用途的启动盘。

也是一个功能强大的引导加载程序，而且兼容各种介质。 它的安装很简单，一旦安装 syslinux 好之后，sysLinux 启动盘就可以引导各种基于 DOS 的工具，以及 MS-DOS/Windows 或者任何其它操作系统。


## 参数选项 {#参数选项}


### 适用于 syslinux 的所有版本的参数 {#适用于-syslinux-的所有版本的参数}

-   -s
    -   Safe, solw, stupid：这个参数可以提高 syslinux 的引导兼容性。
    -   此参数可以让 syslinux 工作在一些非常规的 BOIS 上，有些机器上-s 的选项(参数)是必需的，也就是说这是一个安全的选项(参数)，建议一般要用上这个选项(参数)。
-   -f
    -   Force installing：强制写入 syslinux 的引导代码
    -   这是一个可选的选项(参数)，如果你发现不能写入 syslinux 时，就可以使用这个选项(参数)
    -   一般建议：写入本地磁盘时加上这个选项(参数)。
-   -r
    -   Raid mode：RAID 模式。
    -   这是一个可选的选项(参数)，如果启动失败，告诉 BIOS 启动顺序(通常是下一个硬盘)，而不是给出错误信息后停止，这个一个 RAID 模式的选项(参数)，一般来说可以不使用。


### 只适用于 Windows 的版本的参数 {#只适用于-windows-的版本的参数}

-   -m
    -   MBR：将 syslinux 引导代码写入到驱动器的 MBR 启动扇区。
    -   这是一个可选的选项(参数)，建议使用此选项(参数)
    -   如果之前有将 GURB4DOS 写入磁盘的 MBR 中，那么你必须使用-m 选项(参数)，否则将写入失败。
    -   示例
        -   syslinux.exe -s -f -m -a -d /boot/syslinux x:
        -   (x: 为盘符)
-   -a
    -   Active：激活指定分区为活动分区
    -   这是一个可选的选项(参数)，当你不确定你所指定的分区是否是活动分区时可以加上这个选项(参数)
    -   实际上，就算你所指定的分区已经是活动的主分区了，也可以加上这个选项(参数)。(=bootable)


### 只适用于 Linux 的版本参数 {#只适用于-linux-的版本参数}

-   -o
    -   指定文件系统映像文件中的字节偏移量，它必须是一个可使用的磁盘映像文件。


## 创建启动磁盘 {#创建启动磁盘}

安装 syslinux 的磁盘将改变磁盘上的引导扇区，并复制 ldlinux.sys 文件到其根目录(或者复制到指定的目录)下。

注意：SYSLINUX 不支持 NTFS 文件系统，所以磁盘必须是 FAT(FAT16/FAT32)文件系统。


### NT/2K/XP {#nt-2k-xp}

语法：syslinux.exe [-sfmar][-d directory] &lt;drive&gt;: [bootsecfile]

例如：

-   Floppy:(a:为软驱)

syslinux.exe a:

-   硬盘/可移动磁盘等：(z:为盘符)

syslinux.exe -m -a -d /boot/syslinux z:

【将引导文件复制到其分区的/boot/syslinux 目录下，注意：/boot/syslinux 目录必须事先建好。】

**上例中的启动菜单配置文件(syslinux.cfg)要在/boot/syslinux 目录下**


### DOS {#dos}

语法：syslinux.exe [-sfmar][-d directory] &lt;drive&gt;: [bootsecfile]


### Linux {#linux}

语法：syslinux [-sfr][-d directory][-o offset] &lt;DeviceOrImage&gt;

例如：

-   syslinux /dev/fd0

syslinux /设备/第一个软驱

【将 syslinux 的引导代码写入第一个软驱】


## 配置 syslinux {#配置-syslinux}

所有的 syslinux 默认配置都可以在一个名为 syslinux.cfg 的文件里面更改。

syslinux 会在下列位置搜索 syslinux.cfg 配置文件：

-   /boot/syslinux/syslinux.cfg
-   /syslinux/syslinux.cfg
-   /syslinux.cfg

**syslinux.cfg 文件必须是 UNIX 或 DOS 格式的文本文件。**


### syslinx 配置 {#syslinx-配置}

下面简单的例子来看一下 syslinux.cfg 文件怎样引导一个 linux 内核：

```cfg
DEFAULT linux
LABEL linux
SAY Now booting the kernel from SYSLINUX...
KERNEL vmlinuz.img
APPEND ro root=/dev/sda1 initrd=initrd.img
```


### lilo 配置 {#lilo-配置}

SYSLINUX 与 LILO 是不同的，下面是一个 LILO 的例子：

```cfg
image = mykernel
label = mylabel
append = "myoptions"
```

而 SYSLINUX 是这样写的：

```cfg
label mylabel
kernel mykernel
append myoptions
```


## SYSLINUX 选项： {#syslinux-选项}

注：以下所有选项适用于 PXELINUX，ISOLINUX 和 EXTLINUX 以及 SYSLINUX，除非另有说明。

```text
例如：
LABEL maxdos
MENU LABEL [01] -- Run MaxDos
kernel /boot/syslinux/memdisk
append initrd=/boot/imgs/maxdos.img
```

-   KERNEL file【内核文件】

这个就是 SYSLINUX 指向的启动文件， **这个“kernel”不一定是 Linux kernel【Linux 内核】，它可以是启动扇区，或者 COMBOOT 文件。**


## 文件扩展名 {#文件扩展名}

以下所列出的为公认的文件扩展名(不区分大小写)：

extensions explain none or other Linux kernel image

-   .0 PXE bootstrap program (NBP) [PXELINUX only]
-   .bin "CD boot sector" [ISOLINUX only]
-   .bs Boot sector [SYSLINUX only]
-   .bss Boot sector, DOS superblock will be patched in [SYSLINUX only]
-   .c32 COM32 image (32-bit COMBOOT)
-   .cbt COMBOOT image (not runnable from DOS)
-   .com COMBOOT image (runnable from DOS)
-   .img Disk image [ISOLINUX only]
-   .ima Floppy image [ISOLINUX only]

| 扩展名 | 说明                                                 没有或其它 Linux 内核映像 |
|-----|---------------------------------------------------------------------|
| .0   | PXE 启动引导程序(NBP)【只用于 PXELINUX】                            |
| .bin | “光盘引导扇区”【只用于 ISOLINUX】                                 |
| .bs  | “磁盘引导扇区”【只用于 SYSLINUX】，例如：bsf，                    |
| .bss | “磁盘引导扇区”，用在 DOS 上，【只用于 SYSLINUX】                  |
| .c32 | COM32 映像文件【32-bitCOMBOOT】                                     |
| .cbt | COMBOOT 映像文件【不能运行于 DOS】                                  |
| .com | COMBOOT 映像文件【可运行于 DOS】                                    |
| .img | 磁盘映像文件【实际上可用于 ISOLINUX、SYSLINUX、PXELINUX】           |
| .ima | 软盘映像文件【实际上可用于 ISOLINUX、SYSLINUX、PXELINUX】           |

使用这些关键字之一而不 KERNEL 强制文件类型，与文件名无关。

-   LINUX image 可以直接使用这个，而不是使用 KERNEL file 来启动一个 Linux kernel image【Linux 内核映像】。
-   BOOT image 启动引导程序(.bs，.bsf，.bin)
-   PXE image PXE 网络启动引导程序(.0)
-   FDIMAGE image 软盘映像(.img，.ima)
-   COMBOOT image COMBOOT 程序(.com，.cbt)
-   COM32 image COM32 程序(.c32)
-   CONFIG image CONFIG 将重新启动引导程序而使用不同的配置文件
-   APPEND options...【附加选项】
    -   添加一个或多个选项(参数)到 kernel 命令行中，这些选项(参数)可以是手动或者是自动的。该选项(参数)是添加在 kernel 命令行的开始处，通常允许输入的选项覆盖。
    -   这点与 LILO 的“append”选项(参数)是相同的。
-   APPEND- 简单点说，不附加任何命令，可用于覆盖全局的 APPEND。
-   IPAPPEND flag_val 【只适用于 PXELINUX】
    -   这个 IPAPPEND 选项(参数)只适用于 PXELINUX，这个“flag_val”为下列选项(参数)：


## 命令行参数 {#命令行参数}

-   下列的选项(参数)将以如下格式添加到内核命令行：

`ip=<client-ip>:<boot-server-ip>:<gw-ip>:<netmask>`

以上基于 DHCP/BOOTP 或者 PXE 的启动服务器。 但不推荐使用此选项(参数)，使用 IP=DHCP 的内核命令行更为合适。

-   下列的选项(参数)将以如下格式添加到内核命令行：

`BOOTIF=<hardware-address-of-boot-interface>`

这在 PXELINUX 的文档中有相关的介绍，这将决定临时文件系统程序将从哪一个 Interface【端口】启动系统。

`LABEL label KERNEL image APPEND options... IPAPPEND flag_val`

【只适用于 PXELINUX】

以上表明，如果“LABEL”作为内核启动，其引导的“image”和指定的 APPEND 和 IPAPPEND 选项将取代配置文件中的全局(在第一个 LABEL 命令之前)命令。

“image”默认值与“label”相同，而且如果没有定义 APPEND，则使用全局命令(如果存在)。

-   LOCALBOOT type【ISOLINUX，PXELINUX】

在 PXELINUX，指定“LOCALBOOT 0”代替一个“KERNEL”选项(参数)，这个意味着调用此特定 LABEL 将会引导本地磁盘，而不是一个“KERNEL”。

所有其它的值都是未定义的。 如果不知道什么是 UNDI 和 PXE 堆栈，不要紧——你只要指定参数 0 就可以了。

-   INITRD initrd_file

从 3.71 版本开始，一个 initrd 可以指定一个单独的语句，（INITRD）而不是作为 APPEND 语句的一部分；这个功能添加“initrd=initrd_file”到内核命令行中。

它支持以逗号分隔的多个文件名，这主要是有益于 initramfs【一个新的 initial RAM disks 模型】，它可以支持多个单独的 cpio 或 cpio.gz 压缩文件。

> cpio 简介【摘自：维基百科】
>
> CPIO 是 Linux 下的一种新的内核启动镜像所附带的虚拟磁盘格式。他与传统的 Image 格式比较而言有一些改进，主要体现在打包速度和启动引导方式上。
>
> cpio 可以从 cpio 或 tar 格式的归档包中存入和读取文件, 归档包是一种包含其他文件和有关信息的文件。有关信息包括：文件名, 属主, 时标(timestamp), 和访问权限。归档包可以是磁盘上的 其他文件, 也可以是磁带或管道。
>
> Note: all files except the last one are zero-padded to a 4K page boundary. This should not affect initramfs.

-   DEFAULT command【默认命令】

SYSLINUX 启动时默认执行的命令项——当用户没有进行选择时。

如果没有配置文件存在，或在配置文件没有设置默认项时，默认是启动名为“linux”的内核，不会添加其它的选项(参数)。

例如：可以用于设置所要加载的菜单模块
default vesamenu.c32

-   UI module options【用户界面模块选项(参数)】

用于设置菜单模块(通常是“menu.c32”或“vesamenu.c32”)，也就是说这是一个命令行界面(菜单指令)，它可以覆盖 DEFAULT 和 PROMPT 指令。

-   PROMPT flag_val

如果 flag_val 为 0，启动将显示：“提示符”只有在 Shift 或 Alt 键被按下，或 Caps Lock 键或 Scroll lock 键设置（这是默认值）。如果 flag_val 是 1，启动时将始终：“提示符”。

-   NOESCAPE flag_val

如果 flag_val 设置为 1，那么将忽略 Shift/Alt/Caps Lock/Scroll Lock 退出，将强制使用此默认选择项目启动(也同时忽略 PROMPT 0)。

-   NOCOMPLETE flag_val

如果 flag_val 设置为 1，那么启动时将不会在显示标签中提示 Tab 键。

-   IMPLICIT flag_val

如果 flag_val 为设置为 0，将不会加载的 kernel image【内核映像】，除非它已在 LABEL 声明中明确指定。The default is 1【默认值为 1】。

-   ALLOWOPTIONS flag_val

如果 flag_val 为 0，用户将不能指定内核命令行的任何选项(参数)。唯一可用是在 APPEND 声明中所指定的选项。The default is 1。

-   TIMEOUT timeout【超时】

在执行默认启动菜单项前的等待时间。 其单位为：1/10 秒。

如果设置为 0，那么将将完全禁用 timeout(始终等待用户选择)，这也是默认的设置。

以下 timeout 为 30 秒： timeout 300

注：最大的值为 35996，建议设置为小于一小时。

-   TOTALTIMEOUT timeout

不会被用户的输入取消，用于处理串口故障或类似 "用户离开" 的状况。

默认值是 0。

```cfg
TIMEOUT 50
TOTALTIMEOUT 9000
```

-   ONTIMEOUT kernel options...

timeout 后调用的命令。一般与 DEFAULT 调用相同。如果指定，DEFAULT 只适用于用户按&lt;Enter&gt;启动时。

-   ONERROR kernel options...

如果一个内核映像没有找到(不存在或设置了 IMPLICIT)，运行指定的命令。

如果 ONERROR 指令为： ONERROR xyzzy plugh

并且用户输入的命令行是： foo bar baz

那么 SYSLINUX 将执行： xyzzy plugh foo bar baz

-   SERIAL port 【[baudrate] flowcontrol】

开启一个串口作为控制台，“port【端口】”是一个数字(0 = /dev/ttyS0 = COM1，etc。)或者 I/O 端口地址(例如：0x3F8)；如果省略“baudrate【波特率】”，波特率默认为 9600 bps。串行的硬编码是 8 bits，无奇偶校验，1个停止位。

下列为“flowcontrol【流控制】”的 bits 组合：

```cfg
0x001 - Assert DTR
0x002 - Assert RTS
0x010 - Wait for CTS assertion
0x020 - Wait for DSR assertion
0x040 - Wait for RI assertion
0x080 - Wait for DCD assertion
0x100 - Ignore input unless CTS asserted
0x200 - Ignore input unless DSR asserted
0x400 - Ignore input unless RI asserted
0x800 - Ignore input unless DCD asserted
```

所有其它的 bits 给予保留。

典型值为：

作为 SERIA【串口】指令，它必须保证工作正常，它在配置文件中应该是“First”指令。

-   CONSOLE flag_val

如果 flag_val 为 0，禁止输出到普通视频终端。

如果 flag_val 为 1，允许输出到视频终端(默认值)。

有些 BIOS 因为这个选项(参数)会令视频终端出现异常。 所以该选项(参数)允许你在这些系统上禁用视频控制台。

-   FONT filename

在显示任何输出之前，装载.psf 格式的字体(除了版权行，ldlinux.sys 本身被加载里就输出这些)。SYSLINUX 只装载字体到显卡。忽略.psf 文件包含的 Unicode 表。并且只工作于 EGA 和 VGA 显示卡。

注：.psf 格式的字体不支持中文。

-   KBDMAP keymap

装载一个简单的键盘映射。该重映射使用很简单(由于这个重映射是基于 BIOS 的，所以只有标准的美式键盘布局才能被映射)，不过这至少可以帮助使用 QWERTZ 和 AZERTY 键盘布局的人(这两个特殊字符大量用于 Linux 内核命令行)。

syslinux 的还附带一个名为“kbdmap.c32”的 comboot 模块文件，它允许动态地改变键盘映射，这样就可以在 syslinux 的配置文件中增加一个键盘选择菜单或键盘选择标签【keyboard-selection menu and/or keyboard-selection labels】。

-   SAY message

在屏幕上打印 Message【信息】。

-   DISPLAY filename

启动时在屏幕上显示指定文件(如果显示：则在启动前：“提示符”显示内容)。

请参阅下面一节的“DISPLAY file”。

注：如果指定的文件未找到，那么此选项(参数)将被完全忽略。

-   F[1-12] filename【F1 功能键到 F12 功能键】

基本书写格式：

在启动时按下相应的【F1-F12】功能键，将在屏幕上显示指定的文件。这个可用于实现开机前在线帮助。

在使用 serial console【串行控制台】时，可以按&lt;Ctrl+F1-F12&gt;转到帮助屏幕：

在配置文件中空行和注释行【#号空格后的内容】将被忽略。


## 引导文件(命令)解释 {#引导文件--命令--解释}

以下为 SYSLINUX【ISOLINUX、PXELINUX、EXTLINUX 也类似】主要文件的作用及说明：

| 文件         | 说明                                            |
|------------|-----------------------------------------------|
| isolinux.bin | 光盘映像引导文件                                |
| isolinux.cfg | 光盘映像启动菜单配置文件                        |
| syslinux.bin | 磁盘(U 盘/移动硬盘/本地磁盘)映像引导文件        |
| syslinux.cfg | 磁盘(U 盘/移动硬盘/本地磁盘)映像启动菜单配置文件 |
| memdisk      | 引导 IMG 映像的文件，如果你要引导 IMG/IMA 的映像文件，必须先加载 memdisk |
| vesamenu.c32 | 二种窗口模块之一                                |
| menu.c32     | 二种窗口模块之一                                |
| chain.c32    | 指定分区启动【如：chain.c32 hd0,1 (或 chain.c32 hd1,1)】 |
| reboot.c32   | 重新启动计算机                                  |
| back.png     | 窗口背景图片                                    |


## SYSLINUX.CFG/ISOLINUX.CFG 菜单解释 {#syslinux-dot-cfg-isolinux-dot-cfg-菜单解释}

```cfg
default vesamenu.c32        默认使用 vesamenu.c32 窗口模块（必填项）
timeout 60                  菜单停留时间，计时单位 1/10 秒（必填项）
F1 readme.txt               按 F1 阅读自述文件
F2 syslinux.cfg             按 F2 显示启动菜单配置文件
MENU BACKGROUND back.png    运行窗口背景图片（必填项）
MENU TITLE                  菜单标题
MENU WIDTH 40               菜单选择条长度（必填项）
MENU MARGIN 0               菜单选择条缩进，0不缩进 （若删除则自动使用默认值）
MENU ROWS 30                菜单选择条却换，0不能却换（若删除则自动使用默认值）
MENU HELPMSGROW 26          帮助信息位置（若删除则自动使用默认值）
MENU TIMEOUTROW 27          倒计时条下移，0不下移（若删除则自动使用默认值）
MENU TABMSGROW 28           TAB 显示条下移，0不下移 （若删除则自动使用默认值）
MENU CMDLINEROW 28          TAB 信息条下移，0不下移 （若删除则自动使用默认值）
# 上面这 2 项的参数必须一致，以免按 TAB 键后弹出的信息条易位

MENU HSHIFT 0                菜单选择条右移，0不右移 （若删除则自动使用默认值）
MENU VSHIFT 0                菜单选择条顶端，0不下移 （若删除则自动使用默认值）
# 以上两项，默认值不一定是 0。

menu color screen
37;40
#00000000 #00000000 none

menu color border
30;44
#00000000 #00000000 none（必填项）
menu color title
1;36;44
#00000000 #00000000 none

# 上面这三条有关整个菜单外框，如第二条 menu color border 可设置背景图片上的整个菜单外框的线条颜色，线条粗细，单线条或双线条等，还可设置为不显示菜单外框。如果都用默认，对应的条文均可删除，MENU TITLE 后只剩下下面 2 条：

MENU WIDTH 58
MENU color border 0 #0000 #0000 none

LABEL DOS Tools           设置标签为“DOS Tools”，LABEL 后面有一个空格，这个空格是必须的。（看得懂就可以了）
MENU LABEL DOS Tools      这个就大家在启动菜单上看到的启动项目，MENU 和 LABEL 后面都有一个空格，这个空格是必须的。（看得懂就可以了）
kernel /memdisk             # 指定要启动的内核，启动根目录的 memdisk 内核，默认是启动磁盘（hd0,0）的根目录(如果启动的内核在其它目录，在这里必须指明)，如果启动的是 linux 内核，那么不可以指定一些那个 linux 内核允许的 Option。kernel 后面有一个空格，这个空格是必须的。
append initrd=/dostools.img #指定要启动的映像文件。这个文件可以是，.img .ima .gz（gz 的压缩格式的可以引导文件），.bin(如果是.bin 的格式，就可以不用 kernel 去启动 memdisk 了，例如：kernel /pe.bin) ，等等。
```

<span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline"><span class="underline">\_\_</span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span></span>


## 使用心得 {#使用心得}

以下说说笔者的使用心得

-   再一次强调：SYSLINUX 目前还不支持 NTFS 文件系统，所以你的磁盘(U 盘/移动硬盘/本地磁盘)必须是 FAT(FAT16/FAT32)文件系统。
-   如果你使用的是 PATA(IDE)接口的磁盘，那么使用 SYSLINUX 都没有什么问题的，如果你使用的是 SATA(串口)接口的磁盘，那么有可能的情况是：你已经正常将 SYSLINUX 的引导代码写入磁盘的 MBR 了，可是在引导菜单部分会出现一问题（例如：不能显示背景图片，菜单不能正常显示），有时候 U 盘也可能会出现这种情况。那么这时候你就要用 BOOTICE(引导扇区制作工具——最好下载比较新的版本)将 SYSLINUX 引导代码写入磁盘(U 盘/移动硬盘/本地磁盘)的 PBR(分区引导记录)。
-   如果你要使用 SYSLINUX+GRUB4DOS 双引导，那么，在写入 SYSLINUX 的 PBR(分区引导记录)的引导代码后，可以用“grubinst gui”来将 GRUB4DOS 的引导代码写入 MBR(主引导记录)。
-   注意要选择好其中的选项：
    -   选择“启动时不搜索软盘”
    -   选择“优先引导原来 MBR”（这个是实现 SYSLINUX+GRUB4DOS 双引导的关键选项，一定要选择这项。）
    -   等待时间“默认是 5 秒”（你可以填一个你认为更适合的等待时间，也可以不填）
    -   热键“默认是 Space 键”（如果你不想要空格键作为热键，在这里更改，建议大家不要更改）
    -   其它的选项可以不用理会。

<!--listend-->

```cfg
LABEL runISO
   MENU LABEL < ^A > --- <加载 ISO 镜像> ---
   LINUX memdisk
   INITRD /****.iso
   APPEND iso raw
```


## 核心文件 {#核心文件}

SYSLINUX 只要以下几个文件就可以了：

-   vesamenu.c32
-   menu.c32
-   memdisk
-   chain.c32
-   reboot.c32
-   syslinux.bin &gt;&gt;&gt;&gt;&gt;&gt; 光盘中用 isolinux.bin
-   syslinux.cfg &gt;&gt;&gt;&gt;&gt;&gt; 这个文件一个文本文件，光盘中用 isolinux.cfg
-   back.png &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 这个是背景图片，也可以使用其它文件名或其它格式的图片
-   syslinux.exe &gt;&gt;&gt;&gt;&gt;&gt; 如果是用 BOOTICE(引导扇区制作工具)写入引导代码的，那么可以不用这个文件,其实这个文件写完代码就没有什么用处了


## SYSLINUX 的子菜单 {#syslinux-的子菜单}

只要再写一个.cfg 格式的文本文件就可以了， 在主菜单调用(假设要调用的子菜单为 bt3.cfg)：

```cfg
LABEL Loader Back Track 3 Menu
  MENU LABEL [02] -- Loader Back Track 3 Menu
  CONFIG /boot/syslinux/bt3.cfg
```


## 启动流程 {#启动流程}

-   阶段 I
    -   加载 BMR
        -   /usr/lib/syslinux/bios/mbr.bin
        -   /usr/lib/syslinux/bios/gptmbr.bin
    -   寻找活动分区
        -   一般 boot 分区
-   阶段 II
    -   执行卷启动记录程序
        -   /boot/syslinux/ldlinux.sys
        -   注意与 dlinux.c32 不同
    -   执行/boot/syslinux/ldlinux.sys
        -   ldlinux.sys 所处在的扇区位置不可更改，否则 syslinux 无法启动。
-   阶段 III
    -   加载/boot/syslinux/ldlinux.c32
        -   ldlinux.sys 加载剩下的 syslinux 的核心部分 /boot/syslinux/ldlinux.c32
        -   这部分是因为文件大小限制无法放入 ldlinux.sys 中的核心模块
-   阶段 IIII
    -   查找并加载配置文件/boot/syslinux/syslinux.cfg


## FAQ {#faq}


### Can SYSLINUX Handle Large Kernels? {#can-syslinux-handle-large-kernels}

【SYSLINUX 能处理大内核吗？】

这个版本的 SYSLINUX(syslinux 3.83)已经支持大内核了(bzimage 格式)，取消了对 bzimage 格式内核的 500K 大小限制。能自动检测和透明处理用户的 bzimage 格式内核。

这个版本的 SYSLINUX 还支持启动时加载 RAMDISK(initrd)，initrd 是从 DOS 文件加载的，其选项(参数)这：“initrd=filename”(这里的 filename 为 initrd 的映像文件名，并且这个文件必须在启动磁盘的根目录下。)

例如(EXTLINUX)：

```nil
append ro root=/dev/hda1 initrd=/boot/initrd.img
```

为了兼容 bzimage 和最近的 zimage 内核，SYSLINUX 1.30 和更高的的版本确定使用 ID byte 0x31，PXELINUX 识别使用 ID byte 0x32，ISOLINUX using ID byte 0x33，and EXTLINUX using ID byte 0x34，ID byte 0x35-0x3f 是预留给 SYSLINUX 之后版本的衍生工具使用。


### What is the DISPLAY File Format？ {#what-is-the-display-file-format}

【什么是 DISPLAY 文件格式？】

DISPLAY 和功能键帮助文件是 DOS 或者 UNIX 格式的文本文件。 此处，以下特殊代码将会被解释：

```nil
Clear the screen, home the cursor【清屏，重置光标】：
<FF>
<FF> = <Ctrl-L> = ASCII 12
```

注意：屏幕将被当前显示色所填充。


### Set the display colors to the specified background and foreground colors {#set-the-display-colors-to-the-specified-background-and-foreground-colors}

【设置显示颜色为指定的背景色和前景色】：

-   &lt;SI&gt;&lt;bg&gt;&lt;fg&gt;
-   &lt;SI&gt; = &lt;Ctrl-0&gt; = ASCII 15

这里的&lt;bg&gt;和&lt;fg&gt;为十六进制数，对于标准的 PC 显示属性为：


### Display graphic form filename {#display-graphic-form-filename}

【显示图像文件名】：

-   &lt;CAN&gt;filename&lt;newline&gt;
-   &lt;CAN&gt; = &lt;Ctrl-X&gt; = ASCII 24

如果当前是 VGA 显示，进入图形模式并显示指定的图形文件。该文件格式为 ad hoc 格式，称为 LSS16；所包含的 Perl 程序“ppmtolss16”可用于生成这样的图片。

该图像文件将被显示为 640x480 16 色模式，一旦进入图形模式，显示属性(由&lt;SI&gt;代码序列设置)稍有不同，背景色会被忽略，前景色是图像文件中指定的 16 种颜色。因此，ppmtolss16 允许你指定颜色索引。注意：颜色索引 0 和 7 应该注意选择：0是背景色，7是 SYSLINUX 自身打印文字的颜色。

Return to text mode【返回到文本模式】：

-   &lt;EM&gt;
-   &lt;EM&gt; &lt;Ctrl-Y&gt; = ASCII 25

如果当前是图形模式，则返回到文本模式。

选择哪一种模式打印消息的一部分：

-   &lt;DLE&gt;..&lt;ETB&gt;
-   &lt;Ctrl-P&gt;..&lt;Ctrl-W&gt; = ASCII 16-23

这些代码可用于选择那种模式会打印到消息文件的某个部分。任一控制字符选择特定的实际输出模式 (文本屏幕、图形屏幕、串口)。

示例：
&lt;DC1&gt;Text mode&lt;DC2&gt;Graphics mode&lt;DC4&gt;Serial port&lt;ETB&gt;

将以控制台输入模式输出。

End of file 文件终止：

-   &lt;SUB&gt;
-   &lt;SUB&gt; = &lt;Ctrl-Z&gt; = ASCII 26

文件终止(DOS 惯例)

Beep 提示音：

-   &lt;BEL&gt;
-   &lt;BEL&gt; = &lt;Ctrl-G&gt; = ASCII 7

扬声器提示音。


## BIOS 安装 {#bios-安装}

```bash
mkdir /boot/syslinux
cp /usr/lib/syslinux/bios/*.c32 /boot/syslinux/
extlinux --install /boot/syslinux
# 未挂载FAT分区
syslinux --directory syslinux --install /dev/sda1

# 继续安装适用于对应分区表的 Syslinux 引导代码
# MBR 分区表上会安装 mbr.bin
# GPT 分区表上会安装 gptmbr.bin

# MBR分区表
dd bs=440 count=1 conv=notrunc if=/usr/lib/syslinux/bios/mbr.bin of=/dev/sda

# GPT分区表
## 确保您的启动分区 /boot 被设置上了 2 号属性"传统BIOS可启动"（legacy BIOS bootable）
## Parted 可以使用"legacy_boot"参数实现
sgdisk /dev/sda --attributes=1:set:2

# 检查"传统BIOS可启动"属性
# sgdisk /dev/sda --attributes=1:show
1:2:1 (legacy BIOS bootable)
```


## UEFI 安装 {#uefi-安装}

```bash
mkdir -p esp/EFI/syslinux
cp -r /usr/lib/syslinux/efi64/* esp/EFI/syslinux

# 使用 efibootmgr 安装引导记录
efibootmgr --create --disk /dev/sdX --part Y --loader /EFI/syslinux/syslinux.efi --label "Syslinux" --verbose
```


## 典型使用 {#典型使用}


### 安装 {#安装}

```bat
cd syslinux-xx
mkdir  H:\boot\syslinux
\bios\win32>syslinux.exe -ma -d \boot\syslinux H:
\bios\win32>syslinux.exe --mbr --active --directory /boot/syslinux/ --install H:
```


### 必要文件 {#必要文件}

```cfg
memdisk             引导IMG镜像文件
menu.c32            窗口模块
vesamenu.c32        窗口模块
chain.c32           指定分区(硬盘)启动
reboot.c32          重新启动计算机
poweroff.c32        关闭计算机
```


### 配置 {#配置}

```nil
# WIN PE
LABEL Winpe
MENU LABEL Winpe
  kernel /boot/isope.bin
  append initrd=/boot/SETUPLDR.BIN

LABEL linux
MENU LABEL Puppy linux
  kernel /boot/linux/vmlinuz
  append initrd=/boot/syslinux/initrd.gz

# 硬盘
LABEL StartHD
  MENU LABEL StartHD
  COM32 /boot/syslinux/chain.c32 hd0

LABEL Poweroff
    MENU LABEL Poweroff
    COM32 /boot/syslinux/poweroff.c32

LABEL reboot
  MENU LABEL Reboot
  COM32 /boot/syslinux/reboot.c32
```

syslinux 支持 gzip 或 zip 压缩格式的(memdisk)，标准 floppy 镜像可直接引导启动，非标准(容量大于 2880K)要附加 CHS 参数 其中，CHS 参数可通过软件 GDParam 来获取

```nil
# 磁盘镜像引导
LABEL maxdos
  kernel memdisk
  append initrd=boot/maxdos.img floppy c=555 h=2 s=18

# ISO光盘
LABEL WIN7PE.iso
  LINUX memdisk
  INITRD /boot/wins/WIN7PE.iso
  APPEND iso raw

# LiveCD
LABEL CentOS
    MENU LABLE CentOS
    kernel /boot/CentOS/vmlinuz0
    append initrd=/boot/CentOS/initrd0.img root=UUID=4C9E-56D3 rootfstype=vfat rw quiet liveimg SQUASHED="/sysroot/boot/CentOS/squashfs.img"
#root=LABEL=FIX
```


## 参考 {#参考}

-   [Syslinux　Archlinx Wiki](https://wiki.archlinuxcn.org/wiki/Syslinux)
-   [Syslinux使用](https://www.cnblogs.com/hzl6255/p/3341374.html)
-   [syslinux引导文件名与菜单解释](https://www.cnblogs.com/lixuebin/p/10814607.html)
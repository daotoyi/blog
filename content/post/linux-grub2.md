---
title: "Linux Grub2 basic"
author: ["SHI WENHUA"]
date: "2023-08-30 10:09:00"
lastmod: "2024-05-11 21:27:52"
categories: ["Linux"]
draft: false
---

## grub2 新特性 {#grub2-新特性}


### grub2 和 grub 有很多不同的地方： {#grub2-和-grub-有很多不同的地方}

-   图形接口
    -   使用了模块机制，通过动态加载需要的模块来扩展功能
    -   支持脚本语言，例如条件判断，循环、变量和函数
    -   支持 rescue 模式，可用于系统无法引导的情况
    -   国际化语言。包括支持非 ASCII 的字符集和类似 gettext 的消息分类，字体，图形控制台等等
    -   有一个灵活的命令行接口。如果没有配置文件存在，GRUB 会自动进入命令模式
    -   针对文件系统、文件、设备、驱动、终端、命令、分区表、os loder 的模块化、层次化、基于对象的框架
    -   支持多种文件系统格式
    -   可访问已经安装的设备上的数据:j）支持自动解压
-   设备的命名
    -   grub2 同样以 fd 表示软盘，hd 表示硬盘（包含 IDE 和 SCSI 硬盘）。设备是从 0 开始编号，分区则是从 1 开始，主分区从 1-4，逻辑分区从 5 开始，而 grub 分区编号是从 0 开始的。下面给出几个例子 ：
    -   (fd0)：表示整个软盘
    -   (hd0,1)：表示 BIOS 中的第一个硬盘的第 1 个分区
    -   (hd0,5)/boot/vmlinuz：表示 BIOS 中的第一个硬盘的第一个逻辑分区下的 boot 目录下的 vmlinuz 文件


## grub2 安装与启动 {#grub2-安装与启动}


### 安装过程 {#安装过程}

grub 默认安装在第一硬盘（hd0）的 mbr，其实就是把引导文件 boot.img 写入硬盘的 mbr，当然，用户也可以选择不写入硬盘 mbr 而是写入 linux 分区的引导扇区。启动时根据 mbr 所提供信息找到启动分区后，加载分区内的 grub 核心文件 core.img 和配置文件 grub.cfg，进入选择菜单画面，在菜单画面，按上下箭号选择需要系统菜单项，按 Enter 进入选项。按 e 进入己选择菜单的编辑状态，在编辑状态下，由上下左右箭号来移动光标，enter 键换行，ctrl+x 以编辑的内容启动，ctrl+c 进命令行状态，按 Esc 退出，回到菜单项。

在需要使用额外的内核参数启动时，比如要加上 acpi=off 时，把光标移动到 linux 这一行最后，在 splash 后加上一空格再输入 acpi=off，然后按 ctrl+x 启动。按 c 进入命令行状态，按 Tab 键可查看所有可用的命令。

在命令行状态，可以根据需要加载或移除相应模块，也可用来启动在菜单没有显现的的系统。

比如，在第一硬盘的第一分区上装有 windows xp 系统，但在菜单上没显示出来，我们可以命令行状态下输入命令启动：

```bash
grub>set root=(hd0,1)
grub>chainloader +1
grub>boot
```

又比如启动第二硬盘第一逻辑分区上的 ubuntu 系统：

```bash
grub>set root=(hd1,5)
grub>linux /boot/vmlinuz-xxx-xxx root=/dev/sdb5
grub>initrd /boot/initrd.img-xxx-xxx
grub>boot
```

其中内核 vmlinuz 和 initrd.img 的版本号可用按 Tab 键自动查看。


### grub2 常用命令 {#grub2-常用命令}


#### help {#help}

查看命令用法，如 help search：查看 search 命令详细用法


#### set {#set}

设置变量值，如 set default=0set timeout=5set root=(hd0,3)等等.需要调用变量 AA 的值时，使用\\({AA}，如 set root=(hd1,1)，则\\){root}=(hd1,1)


#### default {#default}

定义默认引导的操作系统。0 表示第一个操作系统，1表示第 2 个，依此类推


#### timeout {#timeout}

定义在时间内用户没有按下键盘上的某个按键，自动引导 default 指定的操作系统。


#### root {#root}

指定用于启动系统的分区。


#### insmod 和 rmmod {#insmod-和-rmmod}

加载或移除某模块，如 insmod jpeg,insmod pnginsmod ntfsrmmod png


#### drivemap {#drivemap}

drivemap 兼容 grub 的 map，主要用于只能从第一硬盘(hd0)引导启动的系统如 win2000 xp 2003，比如要添加第二硬盘第一分区上的 xp 系统：

```bash
menuentry "Windows XP" {
    set root=(hd1,1)
    drivemap -s (hd0) ${root}
    chainloader +1
}
```


#### ls {#ls}

列出当前的所有设备。如(hd0)，(hd0,1)，(hd0,5)，(hd1)，(hd1,1)，(hd1,2)等

-   ls -l 详细列出当前的所有设备。对于分区，会显示其 label 及 uuid。
-   ls /列出当前设为 root 的分区下的文件
-   ls (hd1,1)/ 列出(hd1,1)分区根目录的文件


#### search {#search}

-   search -f /ntldr 列出根目录里包含 ntldr 文件的分区，返回为分区号 search -l LINUX 搜索 label 是 LINUX 的分区。
-   search --set -f /ntldr 搜索根目录包含 ntldr 文件的分区并设为 root，注意如果多个分区含有 ntldr 文件，set 失去作用。


#### loopback {#loopback}

loopback 命令可用于建立回放设备，如 loopback lo0 (hd1,1)/abc.iso 可以使用 lo0 设备来访问 abc.iso 里的内容，比如说，可以从 abc.iso 里的软盘映像中启动 loopback lo0 (hd1,1)/aa.isolinux (lo0)/memdisk
initrd (lo0)/abc.img

要删除某一回放设备，可以使用-d 参数：loopback -d lo0


#### pager {#pager}

分页显示。set pager=1 显示满一页时暂停，按 space 继续 set pager=0 取消分页显示


#### linux {#linux}

用 linux 命令取代 grub 中的 kernel 命令


#### chainloader {#chainloader}

调用另一个启动器，如 chainloader (hd0,1)+1 调用第一硬盘第一分区引导扇区内的启动器，可以是 windows 或 linux 的启动器


#### grub2 挂载软盘镜像 {#grub2-挂载软盘镜像}

```bash
menuentry "Boot from DOS IMG" {
    linux16 /memdisk
    initrd16 /win98.img
}
# 对非标准的 1.4M 和 2.8M 的其他镜像挂载方法，需要指定 CHS 参数：menuentry "Boot from IMG" {
linux16 /memdisk c=* h=* s=* floppy
initrd16 /xxx.img}
```


## grub2 配置文件详解 {#grub2-配置文件详解}

grub2 改用 grub.cfg 为配置文件，配置文件包含以下基本内容：


### 00_header {#00-header}

```bash
### BEGIN /etc/grub.d/00_header ###
load_env
#加载变量，如果在 grubenv 保存变量，则启动时装载
set default="0"#设置默认引导项，默认值为 0
insmod ext2
#插入文件系统支持的模块，除了用作启动的分区外，其他分区格式可在 menuentry 底下再添加
set root=(hd0,8)
# 指定系统 root 分区，也就是 / 分区
search --no-floppy --fs-uuid --set 2d61e5f9-1d2a-4167-a6f1-b991ba00878b
#指定 uuid=2d61e5f9-1d2a-4167-a6f1-b991ba00878b 的分区为 root 分区，如果前面的分区号(hd0,8)的#uuid 与这里的 uuid 一致，这两句作用一样，如果不一致，则指定 uuid的起作用。
if loadfont /usr/share/grub/unicode.pf2 ; then
#设置终端字体，unicode.pf2 支持中文字符显示
set gfxmode=640x480
#设置显示分辨率，默认为 640x480，可用 800x600，1024x768，建议跟你想设定的图片大小一致
insmod gfxterm
#插入终端模块 gfxterm，支持中文字符显示和支持 24 位图像
insmod vbe
#插入 vbe 模块，GRUB2 引入模块化机制，要使用它，需要在这里加入
if terminal_output gfxterm ; then true ; else
# For backward compatibility with versions of terminal.mod that don't# understand terminal_output
terminal gfxterm
#设定 grub2 终端为 gfxterm
fifi
if [ ${recordfail} = 1 ]; then
set timeout=-1 # 若有启动失败的记录，则菜单项不再倒计时
else
set timeout=10 #倒计时 10 秒后进按默认启动项启动
fi
#设定默认启动前等待时间，默认为 10 秒
### END /etc/grub.d/00_header ###
```


### 05_debian_theme {#05-debian-theme}

```bash
### BEGIN /etc/grub.d/05_debian_theme ###
set menu_color_normal=white/black
#设定菜单字体及背景颜色
set menu_color_highlight=black/blue
#设定选择项字体及背景颜色 #如果使用默认，背景将完全被蓝色挡住了，需要修改 blue 为 black，背景图片才能显示
### END /etc/grub.d/05_debian_theme ###
```


### 10_linux {#10-linux}

10_linux 为系统自动添加的当前 root 分区 linux 引导项

```bash
### BEGIN /etc/grub.d/10_linux ###
#每个菜单项要包括 menuentry 双引号" "和大括号{ }才完整，否则不显示菜单
menuentry "Ubuntu, Linux 2.6.31-10-generic" {
    set quiet=1insmod ext2set root=(hd0,8)
    search --no-floppy --fs-uuid --set 2d61e5f9-1d2a-4167-a6f1-b991ba00878b
    #这句与 set root=(hd0,8)效果一样，可删除其一，二者不一致以这句为准
    linux /boot/vmlinuz-2.6.31-10-generic
    root=UUID=2d61e5f9-1d2a-4167-a6f1-b991ba00878b ro quiet splash
    #不喜欢看到一长串的， roo=UUID=***可用 root=/dev/sda8(/分区的分区号)代替
    initrd /boot/initrd.img-2.6.31-10-generic
}…
### END /etc/grub.d/10_linux ###
```


### 20_memtest86+ {#20-memtest86-plus}

20_memtest86+为系统自动添加的内存测试菜单项

```bash
### BEGIN /etc/grub.d/20_memtest86+ ###
menuentry "Memory test (memtest86+)" {
    linux16 /boot/memtest86+.bin
}
menuentry "Memory test (memtest86+, serial console 115200)" {
    linux16 /boot/memtest86+.bin console=ttyS0,115200n8
}
### END /etc/grub.d/20_memtest86+ ###
```


### 30_os-prober {#30-os-prober}

30_os-prober 或 30_others 为系统自动查找并添加其他系统菜单项，按 windows，linux，macos 顺序

```bash
#查找并添加，支持 windows 7 识别
### BEGIN /etc/grub.d/30_os-prober ###
### END /etc/grub.d/30_os-prober ###
### BEGIN /etc/grub.d/30_otheros ###
# This entry automatically added by the Debian installer for a non-linux OS# on /dev/sda1
menuentry "Microsoft Windows XP Professional" {
    set root=(hd0,1)
    search --no-floppy --fs-uuid --set e852-230bdrivemap -s (hd0) $root
    #对以 ntldr 引导的系统如 win2000，xp，win2003，因其引导机制只能从第一硬盘启动，系统会自动添加#映射命令，对 vista 和 win7 就没有这句命令
    chainloader +1
}
### END /etc/grub.d/30_otheros ###
```


### 40_custom {#40-custom}

40_custom 为自定义的启动项，如启动 cdlinux

```bash
    ### BEGIN /etc/grub.d/40_custom ###
  menuentry "CDLinux"{
      set root=(hd0,8)
      linux /CDlinux/bzImage root=/dev/ram0 vga=791 CDL_LANG=zh_CN.UTF-8
      initrd /CDlinux/initrd
  }
  ### END /etc/grub.d/40_custom ###
# 定制个性化的配置文件，可以加入背景图片，使用中文字符，让启动画面独具特色，而不是单调的黑、白、蓝三色。
```


## grub2 配置脚本修改 {#grub2-配置脚本修改}

系统安装完成后，用户就会发现/boot/grub/grub.cfg 文件只有 root 权限可读，如果要直接修改 grub.cfg 文件，要先修改其权限。好不容易把 grub.cfg 修改好了，系统内核或 grub 升级时，会自动执行 update-grub，grub.cfg 文件就会被打回原形，如何保证修改后的配置文件能一直保留下来呢？

其实不用修改 grub.cfg，只要把个性化配置写入/etc/default/目录下的 grub 和/etc/gurb.d 目录下的脚本文件，以后不管升级内核或者是升级 grub 所执行的 update-grub，都会按要求创建个性化的 grub.cfg。


### /etc/default/grub {#etc-default-grub}

先从应用程序－附件里打开终端，输入 `sudo gedit /etc/default/grub` 用户密码看看打开的文件可作什么修改：

```cfg
# If you change  this file, run 'update-grub' afterwards to update# /boot/grub/grub.cfg.
GRUB_DEFAULT=0   # ->设置默认启动项，按 menuentry 顺序。比如要默认从第四个菜单项启动，数字改为 3，若改为 saved，则默认为上次启动项。
GRUB_HIDDEN_TIMEOUT=0                   #默认为 0，单系统时启动菜单自动隐藏，要取消自动隐藏菜单，改为大于 0 再 sudo update-grub。GRUB_HIDDEN_TIMEOUT_QUIET=true
GRUB_TIMEOUT="3"                        # 设置进入默认启动项的等候时间，默认值 10 秒，按自己需要修改
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash" #>添加内核启动参 数，这个为默认
GRUB_CMDLINE_LINUX="noresume"             #添加内核启动参数，比 如 acpi=off noapic 等可在这里添加，加 text 参数启动进入字符模式。
# Uncomment to disable graphical terminal (grub-pc only)
GRUB_TERMINAL=console           #>设置是否使用图形介面。去除前面#，仅使用控制台终端，不使用图形介面
# The resolution used on graphical terminal
# note that you can use only modes which your graphic card supports via VBE
# you can see them in real GRUB with the command `vbeinfo'#GRUB_GFXMODE=640x480 设定图形介面分辨率，如不使用默认，把前面#去掉，把分辨率改为 800x600 或 1024x768
# Uncomment if you don't want GRUB to pass "root=UUID=xxx" parameter to Linux
GRUB_DISABLE_LINUX_UUID=true       #设置 grub 命令是否使用 UUID，去掉#，使用 root=/dev/sdax 而不用 root=UUDI=xxx
# Uncomment to disable generation of recovery mode menu entrys
GRUB_DISABLE_LINUX_RECOVERY="true" #>设定是否创建修复模式菜单项
```


### /etc/grub.d 目录 {#etc-grub-dot-d-目录}

00_header，05_debian_theme，10_linux，20_memtest86+，30_os- prober，40_custom 这五个脚本对应 grub.cfg 上的各个部分，有的版本的 grub 可能把 30_osprober 分出另一部分为 30_os-others，这并不影响。

怎样修改这些脚本文件才能保证不会破坏 update-grub 的运行，又能让生成的 grub.cfg 合乎意愿呢？ 其实很简单，只要在脚本文件中找到 `cat << EOF************************EOF` 这类语句，EOF 中间的文本会直接写入 grub.cfg 中相应位置，所以个性化的语句添加在这地方就可以了。


#### 00_header {#00-header}

```bash
# cat << EOF
load_env  #加载由 save_env 保存在 grubenv 的变量
set default="${GRUB_DEFAULT}" #使用/etc/default/grub 中的设定值
if [ \${prev_saved_entry} ]; thensaved_entry=\${prev_saved_entry}
   save_env saved_entryprev_saved_entry= #变里设置的变量由下句保存到 grubenv
   save_env prev_saved_entry
fi
#这里回车添加新行后可插入需要添加的模块
insmod jpeg #添加背景图片格式支持，如 jpeg，png，tga 等。
insmod fat  #添加文件系统格式支持如 fat，ntfs，也可在 menuentry 下添加
# EOF

# cat << EOF
if [ \${recordfail} = 1 ]; then
    set timeout=-1 #-------->设定为若有启动失败记录，不倒计时，不会进入默认启动，需手动选择才能启动选择项，若要设置为即使曾启动错误也进行默认启动，可把时间设为 合适的正值，如 set timeout=5else
    set timeout=${GRUB_TIMEOUT} #------>使用/etc/default/grub 中的设定值
fi #-------->这行后添加行
background_image (hd0,7)/boot/images/002.jpg #-------->添加背景图片的绝对路 径，可以按 05_debian_theme 修改图片路径。
#EOF
```


#### 05_debian_theme {#05-debian-theme}

修改字体及背景颜色、添加背景图片

```bash
# cat << EOF
set menu_color_normal=white/black # ------->设置菜单全局的字体和背景颜色
set menu_color_highlight=black/white #------->设置选择项的字体和背景颜色。
# EOF

# 可供使用菜单颜色有：
# black(当背景色时为透明)，blue，green，cyan，red，magenta，brown，lightgray，dark-gray，light-blue，light-green， light-cyan，light-red，light-magenta，yellow，white

#添加背景图片，看这一段
source /usr/lib/grub/grub-mkconfig_lib
# this allows desktop-base to override our settingsf=/usr/share/desktop-base/grub_background.sh
if test -e ${f} ; then
    source ${f}else
    WALLPAPER="/usr/share/images/desktop-base/moreblue-orbit-grub.png"COLOR_NORMAL="black/black"COLOR_HIGHLIGHT="magenta/black"
fi
#c这里会自动搜索背景文件，把合适的背景图片更名为 moreblue-orbitgrub.png(moreblue-orbit-grub.tga 或 moreblue-orbit-grub.jpeg)，再放在/usr/share/ images/desktop-base/目录 下，然后执行 sudo update-grub，会出现如下的 Generating grub.cfg ... Found background image: moreblue-orbit-grub.png......
# 再重启，漂亮的背景图片就会出现了。
```


### 10_linux {#10-linux}

这部分是自动搜索当前系统，建立当前系统的启动菜单，包括系统头，内核等信息，不要随便修改，要使用个性菜单名，比如中文菜单，可适当添加：

```bash
# cat << EOF
menuentry "$1" { #-------->双引号内可添加个性化字符，$1 变量也可改为定值，如改为 menuentry "启动 Ubuntu Karmic" {recordfail=1
    save_env recordfail #-------->如不要保存启动失败记录的，这两句可删除
# EOF
if [ "x$3" = "xquiet" ]; then
    set quiet=1
fi
#->启动画面不用 splash，要用跳动字符的，这段可删除
# 个性化菜单项也可在这里修改，即上面的 menuenrty "$1"不变，修改下面的数值：
linux_entry "${OS}, Linux ${version}"
#------->可改为
linux_entry "启动 Ubuntu, Linux ${version}"\
            "${GRUB_CMDLINE_LINUX} ${GRUB_CMDLINE_EXTRA}${GRUB_CMDLINE_LINUX_DEFAULT}" \
            quiet

if [ "x${GRUB_DISABLE_LINUX_RECOVERY}" != "xtrue" ]; then
    linux_entry "${OS}, Linux ${version} (recovery mode)" \
    #--------->可改为
    linux_entry "启动 Ubuntu, Linux ${version} (修复模式)"\
                "single ${GRUB_CMDLINE_LINUX}"
fi
# 注意只修改引号内的字符，前面的 menuentry，linux_entry 和后面的\不要做修改。
```


### 20_memtest86+ {#20-memtest86-plus}

自动添加内存测试启动项

```bash
# cat << EOF
menuentry "Memory test (memtest86+)" { #-------->双引号内可添加个性字符如
    menuentry "启动 内存测试"linux16 $MEMTESTPATH
}
menuentry "Memory test (memtest86+, serial console 115200)" {
    linux16 $MEMTESTPATH console=ttyS0,115200n8
}
# EOF
#上面有两内存测试项，可删除其中一个。
```


### 30_os-prober {#30-os-prober}

查找其他分区中存在的系统并建立菜单项，依次为 windows，linux，macos。对于单系统，默认会隐藏菜单，可在这里去掉隐藏先打开文件 sudo gedit /etc/grub.d/30_os-prober

单 ubuntu 系统会自动隐藏菜单，要取消隐藏菜单，可把这部份的三个 timeout=0 改为和/etc/default/grub 中的 timeout 一致，比如 timeout=10。

```bash
# cat <<EOF
if [ \${timeout} != -1 ]; then
    if keystatus; then
        if keystatus --shift; then
            set timeout=-1
        else
            set timeout=0
        fi
    else
        if sleep$verbose --interruptible 3 ; then
            set timeout=0
        fi
    fi
fi
# EOF

# cat << EOF
if [ \${timeout} != -1 ]; then
    if sleep$verbose --interruptible ${GRUB_HIDDEN_TIMEOUT} ; then
        set timeout=0
fi
    fi
#EOF

# 下面这段自动查找并添加 windows、linux 和 macos 启动项，可在 menuentry 内修改个性字符
#windows 启动项
for OS in ${OSPROBED} ; do
    if [ -z "${LONGNAME}" ] ; then
        LONGNAME="${LABEL}"
    fi
done

 cat << EOF
menuentry "${LONGNAME} (on ${DEVICE})" { #------->比如改为
menuentry "启动 Windows XP" {
EOF


  linux 启动项 linux)
LINUXPROBED="`linux-boot-prober ${DEVICE} 2> /dev/null | tr ' ' '^' | paste -s -d' '`"

if [ -z "${LLABEL}" ] ; then
   LLABEL="${LONGNAME}"
fi

# cat << EOF
menuentry "${LLABEL} (on ${DEVICE})" { -------->比如改为 menuentry "启动
andriva" {EOF
macos 启动项 macosx)
OSXUUID="`grub-probe --target=fs_uuid --device ${DEVICE} 2> /dev/null`"cat << EOF
menuentry "${LONGNAME} (on ${DEVICE})" { -------->比如改为 menuentry "启动
acOS" {EOF
```


### 40_custom {#40-custom}

自定义启动项，按菜单标准格式在后面添加即可

```bash
#!/bin/sh
exec tail -n +3 $0
# This file provides an easy way to add custom menu entries. Simply type the# menu entries you want to add after this comment. Be careful not to change# the 'exec tail' line above.
menuentry "启动 Veket" {
    set root=(hd0,8)
    linux /veket/vmlinuz root=/dev/ram0 PMEDIA=hd
    initrd /veket/initrd.gz
}
menuentry "启动 CDLinux" {
    set root=(hd0,8)
    linux /CDlinux/bzImage root=/dev/ram0 vga=791 CDL_LANG=zh_CN.UTF-8
    initrd /CDlinux/initrd
}
```

把各项脚本修改保存后，在终端执行 sudo update-grub

怎样让系统默认为从 windows 启动?

在 /etc/grub.d 目录中的脚本文件的文件名都是以数字开头，这确定了在执行 updategrub 时各文件内容被执行的顺序，我们只要把 30_os-prober 这个文件名的数字 30 改为 05 到 10 之间的数字即可（没多少可选 06、07、08、09），比如改为 08_os-prober，这样创建出来的 grub.cfg 内的菜单项，windows 的排序就会自动在 ubuntu 之前。


## 使用 grub2 常见错误及修复方法 {#使用-grub2-常见错误及修复方法}


### 双系统，重装 windows 引起没有 ubuntu 启动项 {#双系统-重装-windows-引起没有-ubuntu-启动项}

使用安装版的 windows 重装 windows 时会改写 mbr，造成 grub 丢失，可以用 grub4dos 引导进入 ubuntu 后修复 grub 或用 livecd 启动后修复 grub。


#### 用 grub4dos 修复 ubuntu {#用-grub4dos-修复-ubuntu}

先下载最新版的 grub4dos，下载地址<http://nufans.net/grub4dos/> ，如果是 xp 系统，把 grub4dos 压缩包内的 grldr 复制到 C 盘根目录下，修改 boot.ini，在最后加上一行 c:\grldr="grub4dos"，对 于 vista/win7 系统，把压缩包内的 grldr.mbr 和 grldr 复制到 C 盘根目录下，在 C 盘自己建立一个 boot.ini 文件，若有 boot 隐 藏分区的，先给 boot 分区分配盘符，再把 grldr，grldr.mbr 和 boot.ini 放在 boot 分区下，boot.ini 内容如下：
Win7 使用软改激活的请不要使用此方法，否则会造成 win7 不能启动。然后在根目录新建一个 menu.lst，内容为:

```cfg
timeout 0
default 0
title grub2
find --set-root /boot/grub/core.imgkernel /boot/grub/core.img
boot
#  有/boot 分区的改为
find –set-root /grub/core.imgkernel /grub/core.img
```

重启后选择 Grub4Dos 会自动转入 grub2，从 grub2 菜单项选择 ubuntu 启动后，在终端执行 sudo grub-install /dev/sda 将 grub 装入第一硬盘的 mbr，如要装入第二硬盘的 mbr 把 sda 改为 sdb，第三硬盘为 sdc，类推。


#### 用 livecd 修复 grub {#用-livecd-修复-grub}

用 ubuntu9.10 的 livecd 启动后，打开终端假如你的 ubuntu 的 / 分区是 sda7，又假如 /boot 分区是 sda6，用 livecd 启动，在终端下输入

```bash
sudo -i
mount /dev/sda7 /mnt
mount /dev/sda6 /mnt/boot
#（如果没 /boot 单独分区这步跳过）
grub-install --root-directory=/mnt /dev/sda

# 如果 grub.cfg 己丢失，或 grub.cfg 出现错误，需要重建的继续执行下面操作：
mount --bind /proc /mnt/proc
mount --bind /dev /mnt/dev
mount --bind /sys /mnt/sys
chroot /mnt
update-grubumount /mnt/sys
umount /mnt/devumount /mnt/procexit
```


#### 用带 grub 启动的光盘或 U 盘修复 {#用带-grub-启动的光盘或-u-盘修复}

如果手上有 grub 启动的工具盘，用工具盘启动，在 grub 菜单上按 c 进入命令行状态，在 grub&gt;提示符下输入

```bash
grub>find /boot/grub/core.img
# (有/boot 分区的用 find /grub/core.img)(hdx,y) (显示查找到的分区号）
grub>root (hdx,y)
grub>kernel /boot/grub/core.img
# (/boot 分区的用 kernel /grub/core.img)
grub>boot
# 执行 boot 后能转入 grub2 菜单，启动 ubuntu 后，再在 ubuntu 终端下执行 sudo grub-install /dev/sda (或 sdb，sdc 等）修复 grub。
# 如果 ubuntu 的启动分区使用 ext4 格式，要有支持 ext4 格式的 grub 才能修复。
```


#### 没安装引导器的 grub4dos 引导 ubuntu 的方法 {#没安装引导器的-grub4dos-引导-ubuntu-的方法}

按第一步的方法使用 boot.ini 建立 grub4dos 引导项，自己编写 menu.lst，内容如下

```bash
timeout 3
default 0
title Ubuntu 9.10
root (hdx,y) # --------> (hd0x,y) 为 /boot 分区的分区号
kernel /vmlinuz-xxx-generic root=/dev/sdxy #------->/dev/sdxy 为 / 分区的分区号 initrd /initrd.img-xxx-generic 没 /boot 分区的用 timeout 3default 0
title Ubuntu 9.10root (hdx,y)
kernel /boot/vmlinuz-xxx-generic root=/dev/sdxy
initrd /boot/initrd.img-xxx-generic
```


### 安装时 grub 没装在 mbr 上而选择装在 linux 分区的 pbr 上，怎么引导 ubuntu {#安装时-grub-没装在-mbr-上而选择装在-linux-分区的-pbr-上-怎么引导-ubuntu}


#### 方法 1 {#方法-1}

按前面的方法一，以 grub4dos 引导转入 grub2。


#### 方法 2 {#方法-2}

把 ubuntu 分区/boot/grub 目录下的 boot.img 提取出来，放到 C 盘根目录下，然后修改 boot.ini，在最后添加一行 C:\boot.img="grub2"

对 vista/7 可在 C 盘新建一个 boot.ini，内容为

```cfg
[boot loader]timeout=0default=c:\boot.img
[operating systems]c:\boot.img="grub2"
```

重启后选择 grub2 就可进入 grub2 菜单。此法兼容性较差，成功率低，仅供测试。


### 由于分区调整引起分区号或分区 UUID 改变造成的 grub2 不能正常启动 {#由于分区调整引起分区号或分区-uuid-改变造成的-grub2-不能正常启动}

己安装好系统，对硬盘再次进行分区调整时可能会改变现有分区的分区号发生变化，或者某种原因改变启动分区的 UUID，都会造成 grub2 不能正常启动，而启动进入修复模式（grub rescue)，这时就要对 grub 进行修复。

1.  用 ubuntu9.10 的 livecd 光盘启动，进入试用桌面系统后，再修复 grub，操作方法如第一种情况的第二种方法—

2.  在 rescue 模式下启动并修复

由于分区问题，启动时会自动进入 rescue 模式，只要 grub 核心文件还在分区内，就能由 rescue 模式转到 normal 模式，进而通过命令进入系统。下面这个就是 rescue 介面：

由于在 rescue 模式下，只有少量的基本命令可用，必须通过一定的操作才能加载正常模块，然后进入正常模式。

rescue 模式下可使用的命令有：set，ls，insmod，root，prefix(设置启动路径)

先假设 grub2 的核心文件在(hd0,8)分区，再来看看怎样从 rescue 模式进入从(hd0,8)启动的正常模式(normal)。在 rescue 模式下 search 命令不能用，对不清楚 grub2 文件处于哪个分区的，可以用 ls 命令查看，比如
ls (hd0,8)/ 查看(hd0,8)分区根目录，看看有没有 boot 文件夹 ls (hd0,8)/boot/ 查看(hd0,8)分区的/boot 目录下文件 ls (hd0,8)/boot/grub/ 查看(hd0,8)分区/boot/grub 目录下文件.通过文件查看，可以确定 grub2 核心文件处于哪个分区，接下来就可以进行从 rescue 到 normal 的转变动作：

\\先 ls 看看分区，根据分区列表，猜下 / 分区的编号再 ls (hd0,x)/ 看分区目录下文件确定找到 / 分区，不对的话继续找。找到 / 分区的 (hd0,x) 继续

```bash
grub rescue>root=(hd0,x)
grub rescue>prefix=/boot/grub
grub rescue>set root=(hd0,x)
grub rescue>set prefix=(hd0,x)/boot/gru
bgrub rescue>insmod normal
rescue>normal #-------->若出现启动菜单，按 c 进入命令行模式
rescue>linux /boot/vmlinuz-xxx-xxx root=/dev/sdax
rescue>initrd /boot/initrd.img-xxx-xxxrescue>boot
# 内核版本号 -xxx-xxx 可以按 Tab 键查看后再手动补全。
# 有 /boot 分区的，要先找出 /boot 分区 (hd0,x)，再找出 / 分区的 (hd0,y)，同样用 ls(hd0,x)/ 和 ls (hd0,y)/ 的方式确定分区
grub rescue>root=(hd0,x)
grub rescue>prefix=/grub
grub rescue>set root=(hd0,x)
grub rescue>set prefix=(hd0,x)/grub
grub rescue>insmod normal
rescue>normal #-------->若出现启动菜单，按 c 进入命令行模式
rescue>linux /vmlinuz-xxx-xxx root=/dev/sday
rescue>initrd /initrd.img-xxx-xxxrescue>boot
```

说明：

-   由于 grub2 版本的的不一致，有的可能在第 9 步 insmod normal.mod 加载正常模块后直接进入 normal 模式，即出现了 normal grub&gt;的提示符，这种情况就不能执行第 10 步，即可以跳过 normal 命令的输入。
-   虽然输入 normal 命令会出现菜单，但由于缺少加载内核的 Linux 命令，直接从菜单不能进入系统，需要按 c 在命令行继续操作。
-   使用/boot 单独分区的，要正确修改路径，如 prefix=(hd0,8)/grub \\ insmod /grub/normal.mod 另外 root=/dev/sda8 也要修改根分区的分区号。
-   按 boot 启动系统后，再在系统下打开终端，执行命令修复 grub 重建配置文件 grub.cfg,sudo update-grub 重建 grub 到第一硬盘 mbrsudo grub-install /dev/sda


### 双硬盘双系统 Grub Loading 时间过长的解决方案 {#双硬盘双系统-grub-loading-时间过长的解决方案}

grub2 的 boot.img 设定 root 的 uuid 从第一分区开始搜索分区的/boot/grub 下的模块并加载， 如果 linux 分区处于第二硬盘甚至第三硬盘，会导致搜索时间过长而，出现菜单时间会长达 10 多秒。对双（多）硬盘的情况建议把 grub 安装在 ubuntu 所在硬盘的 mbr 上，/boot 分区或 / 分区 尽量靠前，并设该硬盘为启动盘，会大大缩短启动时间。


### 单 linux 系统或硬盘安装时 iso 放在 C 盘，umount /isodevice 引起的误认为单系统不能出现菜单项的几种处理方法。 {#单-linux-系统或硬盘安装时-iso-放在-c-盘-umount-isodevice-引起的误认为单系统不能出现菜单项的几种处理方法}

-   开机自检后时按几下 shift 键，可调出菜单项
-   sudo update-grub 重建 grub.cfg，会发现新的系统而改写 grub.cfg，一般能出现菜单项。
-   如第二种方法不能解决，直接修改 grub.cfg

把在### BEGIN /etc/grub.d/30_os-prober　中的这一段

```bash
if keystatus; then
    if keystatus --shift; then
        set timeout=-1
    else
        set timeout=0
    fi
else
    if sleep$verbose --interruptible 3 ; then
        set timeout=0
    fi
fi
```

整段删除或修改三处 set timeout=&lt;大于 0&gt;，再执行 sudo update-grub


### 安装 ubuntu 9.10 后出现 Error : No such device: xxx-xxx-xxx，不能启动的修复办法（未经实机测试） {#安装-ubuntu-9-dot-10-后出现-error-no-such-device-xxx-xxx-xxx-不能启动的修复办法-未经实机测试}

由于 grub2 兼容性问题，少部分电脑安装完 ubuntu9.10 重启时会出现 `Error：no such device:3c7c1d30-86c7-4ea3-ac16-30d6b0371b02Failed to boot default entries.Press any key to continue.`

原因是电脑不支持 uuid 的搜索， soier 的修复过程证实了这个问题，见<http://forum.ubuntu.org.cn/viewtopic.php?f=139&t=238346>(原贴使用的是 live DVD 进入修复系统模式，的 shell 下 change root 修复，livecd 没有修复系统模式，现的根据他的方法写个 livecd （能支持 ext4 读写的其他版本的 liveLinux ）下的修复办法，希望有这个问题的朋友测试下看行不行:

1.  livecd 启动进入试用系统
2.  挂载 / 分区，比如 / 分区为 /dev/sda7,sudo mount /dev/sda7 /mnt,如果有 /boot 单独分区，则挂载 /boot 分区
3.  修改 grub.cfg
    ```bash
    sudo chmod +w /mnt/boot/grub/grub.cfg
    sudo chmod +w /mnt/grub/grub.cfg #(/boot 单独分区的)
    sudo gedit /mnt/boot/grub/grub.cfg
    sudo gedit /mnt/grub/grub.cfg #(/boot 单独分区的)找到 grub.cfg 可所有的这句 search --no-floppy --fs-uuid --set 3c7c1d30-86c7-4ea3-ac16-30d6b0371b02 # 的前面加上 # 号注释掉
    search --no-floppy --fs-uuid --set 3c7c1d30-86c7-4ea3-ac16-30d6b0371b02 # 这句的 grub.cfg 中有好几处，后面的 uuid 不尽相同，要全部找到并注释掉
    ```
4.  重启试试能否进入系统，可这进系统再进行下个步
5.  sudo gedit /usr/lib/grub/grub-mkconfig_lib 找到 173-175 行
    ```bash
    if fs_uuid="`${grub_probe} --device ${device} --target=fs_uuid 2> /dev/null`" ; then
        echo "search --no-floppy --fs-uuid --set ${fs_uuid}"
    fi
    #前面全部加#注释掉，记住从 if 开始到 fi 结束，以防止语法错误

    # if fs_uuid="`${grub_probe} --device ${device} --target=fs_uuid 2> /dev/null`" ; then
    # echo "search --no-floppy --fs-uuid --set ${fs_uuid}"
    # fi
    # 然后
    sudo update-grub
    # 这样重建出来的 grub.cfg 就没有
    search --no-floppy --fs-uuid --set 3c7c1d30-86c7-4ea3-ac16-30d6b0371b02 的语句
    ```


### 如何从 grub2 回到 grub {#如何从-grub2-回到-grub}

```bash
sudo apt-get purge grub-pc # ------>清除 grub2
sudo rm -fr /boot/grub/*
sudo apt-get install grub #------->安装 grub
sudo grub-install /dev/sda #-------->安装 grub 到第一硬盘 mbr，第二硬盘为/dev/sdb，若安装到分区引导扇区则为分区号如 /dev/sda7 等
sudo update-grub #-------->重建 menu.lst
```


### 重装 windows 后出现 error: no such device {#重装-windows-后出现-error-no-such-device}

由于重装 windows 时会改变 windows 引导分区的 uuid，原来的配置文件 grub.cfg 中的 search --no-floppy --fs-uuid --set xxx-xxx 在搜索分区时会按原来的 uuid 查找分区，找不到相应的 uuid，就出现 error: no such device，在 ubuntu 下执行 sudo update-grub 重建 grub.cfg，就能解决。此方法也适用于用 convert 命令把 fat 改为 ntfs 格式时出现的 error。

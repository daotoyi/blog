---
title: "Linux cmd screen"
author: ["SHI WENHUA"]
date: "2024-07-10 14:04:00"
lastmod: "2024-07-10 14:04:19"
categories: ["Linux"]
draft: false
---

## screen {#screen}

Screen 是 Linux 下的一款远程会话管理工具，可以在多个进程之间多路复用一个物理终端的全屏窗口管理器。它可以创建多个会话（Session），每个会话中可以创建多个窗口（Window），每个窗口中可以运行单独的任务，并且互相之间不受影响，还可以方便快速的在不同的窗口和会话之间切换。


## common cmd {#common-cmd}

```bash
screen		#新建一个screen会话
screen vi test.sh       #新建一个运行vi test.sh的screen会话，退出vi会自动退出该会话
screen -S <screen_name>	#新建一个名为<screen_name>的screen会话
screen -ls			        #列出当前所有screen会话

screen -r <screen_pid>  #恢复id为<screen_pid>的会话
screen -r <screen_name> #恢复名称为<screen_name>的会话

screen -d <screen_name> #断开名称为<screen_name>的会话，但是会话的任务会继续执行
screen -d               #断开当前的会话，但是会话的任务会继续执行
screen -D -r <screen_pid> #用户断线后重连踢掉attached的screen会话

exit                   #在screen内输入exit会退出并关闭会话
screen -S <screen_name> -X quit #杀死名称为<screen_name>的会话
```


## keybinding {#keybinding}

给 screen 发送命令使用了特殊的键组合 C-a。这是因为我们在键盘上键入的信息是直接发送给当前 screen 窗口，必须用其他方式向 screen 窗口管理器发出命令，默认情况下，screen 接收以 C-a 开始的命令。这种命令形式在 screen 中叫做键绑定（key binding），C-a 叫做命令字符（command character）。

可以通过 C-a ?来查看所有的键绑定：

```bash
C-a ?	#显示所有键绑定信息
C-a w	#显示所有窗口列表
C-a C-a	#切换到之前显示的窗口
C-a c	#创建一个新的运行shell的窗口并切换到该窗口
C-a n	#切换到下一个窗口
C-a p	#切换到前一个窗口(与C-a n相对)
C-a 0..9	#切换到窗口0..9
C-a a	#发送 C-a到当前窗口
C-a A   #给窗口起名字
C-a d	#暂时断开screen会话
C-a C-d #同上
C-a k	#杀掉当前窗口
C-a [	#进入拷贝/回滚模式
```

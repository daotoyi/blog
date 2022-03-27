+++
title = "CMD stty"
date = 2022-03-25T21:03:00+08:00
lastmod = 2022-03-25T22:12:21+08:00
categories = ["Linux"]
draft = false
+++

## Stty 指令简介 {#stty-指令简介}

TTY 是 Teletype 或 Teletypewriter 的缩写，原来是指电传打字机，后来这种设备逐渐键盘和显示器取代。不管是电传打字机还是键盘显示器，都是作为计算机的终端设备存在的，所以 TTY 也泛指计算机的终端(terminal)设备。

Linux 系统中，stty(set tty，设置 tty)命令，即改变并打印终端行设置，用于检查和修改当前注册的终端的通信参数。


## 常用串口操作 {#常用串口操作}

```shell
# 查看串口驱动
cat /proc/tty/driver/serial

# 查看串口设备
dmesg | grep ttyS*
dmesg | grep ttyUSB*

# 查看串口有没有设备
grep tty /proc/devices

 # 查看串口属性
stty -a -F /dev/ttyS0

# 设置串口属性
stty -F /dev/ttyS0 speed 115200 cs8 -parenb -cstopb
# 设置串口ttyS0波特率为115200，8位数据位，1位停止位，无校验位
```

-   parameter
    -   [-]cstopb    每个字符使用 2 位停止位 (要恢复成 1 位配合"-"即可)
    -   [-]parenb    对输出生成奇偶校验位并等待输入的奇偶校验位
    -   [-]parodd    设置校验位为奇数 (配合"-"则为偶数)

---

版权声明：本文为博主原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接和本声明。

本文链接：<https://blog.csdn.net/qq_34796705/article/details/116013286>
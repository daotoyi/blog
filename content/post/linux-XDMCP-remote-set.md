---
title: "Linux XDMCP remote Set(Redhat6)"
date: "2023-10-06 19:12:00"
lastmod: "2023-10-06 19:12:47"
categories: ["Linux"]
draft: false
---

## Linux 配置

### **/etc/gdm/custom.conf**

``` conf
[daemon]
RemoteGreeter=/usr/libexec/gdm-simple-greeter

[security]
AllowRemoteRoot=true

[xdmcp]
Enable=1
Port=177
DisplaysPerHost=5

[greeter]
Browser=true

[chooser]

[debug]

```

另外，如果想开机免登录，可以在\[daemon\]字段下添加

``` conf
[daemon]
TimedLoginEnable=True
AutomaticLoginEnable=false
TimedLogin=root
AutomaticLogin=false
TimedLoginDelay=3
```

### **/etc/init/prefdm.conf**

``` conf
start on stopped rc RUNLEVEL=5
stop on starting rc RUNLEVEL=[!5]

console output
respawn
respawn limit 10 120

#exec /etc/X11/prefdm -nodaemon
exec /usr/sbin/gdm
```

### 关闭防火墙，或开放177端口

> **service iptables stop**(推荐)

or

> iptables -A INPUT -p udp -s 0/0 -d 0/0 --dport 177 -j ACCEPT

or

> 在/etc/sysconfig/iptables文件中加入：
> \-A RH-Firewall-1-INPUT -m state --state NEW -m udp -p udp --dport 177 -j ACCEPT

之后重启防火墙

> $service iptables restart

### 确认xdmcp启动

> #lsof -i:177
> COMMAND PID USER FD TYPE DEVICE SIZE/OFF NODE NAME
> gdm-binar 1839 root 11u IPv4 11907 0t0 UDP \*:xdmcp

出现上面的文字，说明已经启动。（注意要用root用户执行，否则可能命令不报错，但是没有输出。）

[通过xmanager连接linux远程主机桌面](https://blog.csdn.net/kadwf123/article/details/79564293)

## Windos 配置

[Windows闭防火墙入站规则之开放端口](https://blog.csdn.net/mineskey/article/details/110929469)

## XDMCP 界面配置

[单击键盘出现两个字符的问题解决办法](https://www.cnblogs.com/jeshy/p/11058865.html)

点击`Xmanager6`上面的`工具`菜单，并点击 `Xconfig 开始（C)`,`右键`点击`Default Profile`,选择`属性`。

在打开的界面里面选择`高级`,`XKEYBOARD`字段默认是打上对勾的，`取消选择`，重新远程登录即可。
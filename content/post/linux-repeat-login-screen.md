---
title: "Linux 在 login 界面闪退"
date: "2023-10-06 19:17:00"
lastmod: "2023-10-06 19:17:12"
categories: ["Linux"]
draft: false
---

## Linux终端无法登录

### 1）环境变量引起pam\_limits.so丢失

1.  使用 XShell 或者 SecureSRT 远程连接
2.  进入 /etc/pam.d/login 文件
    在/etc/pam.d/login里面的最后一行：

> session required /lib/security/pam\_limits.so

改成：

> session required /lib64/security/pam\_limits.so

或者

> cp /lib64/security/pam\_limits.so /lib/security/

3.  保存重启！

参考：[Linux 控制台登陆用户输入密码正确无法进入，反复提示登录](https://blog.csdn.net/young_0609/article/details/78038970)

### 2）.Xauthority文件拥有者变成了root

问题原因：**主目录下的.Xauthority文件拥有者变成了root，从而以用户登陆的时候无法都取.Xauthority文件**

1.  在需要输入密码的登录界面，按下ctrl+alt+F1组合键，进入tty1终端
2.  将Xauthority的拥有者改为用户linux（用户名为linux）

> $ sudo chown linux:linux .Xauthority

3.  能主拥有者已经变为用户

> $ ls .Xauthority -l
> \-rw------- 1 linux linux 100 1月 4 17:09 .Xauthority

4.  按下ctrl + alt + F7切换回图形登陆界面登陆即可

参考：[Linux输入登陆密码正确 闪回登陆界面 无法登录](https://jingyan.baidu.com/article/08b6a591b16dbf14a80922e4.html)
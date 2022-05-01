---
title: "Linux 用户及用户组"
lastmod: "2022-05-01 18:16:06"
categories: ["Linux"]
draft: true
---

## useradd {#useradd}

```bash
# 新建了一个用户gem，该用户的登录Shell是 /bin/sh，它属于group用户组，同时又属于adm和root用户组，其中group用户组是其主组。
useradd -s /bin/sh -g group –G adm,root gem

# 选项是 -r，它的作用是把用户的主目录一起删除
userdel -r user_name
```


## usermod/groupmod {#usermod-groupmod}

```bash
# 将用户sam的登录Shell修改为ksh，主目录改为/home/z，用户组改为developer
usermod -s /bin/ksh -d /home/z –g developer sam

# 将组group2的标识号改为10000，组名修改为group3
groupmod –g 10000 -n group3 group2
```


## chown {#chown}

```bash
# 将文件 file1.txt 的拥有者设为 runoob，群体的使用者 runoobgroup :
chown runoob:runoobgroup file1.txt

# 目录下的所有文件
chown -R runoob:runoobgroup *

# 所有者
chown root
```


## chgrp {#chgrp}

```bash
[root@localhost test]# ll
---xrw-r-- 1 root root 302108 11-13 06:03 log2012.log
[root@localhost test]# chgrp -v bin log2012.log

# "log2012.log" 的所属组已更改为 bin
[root@localhost test]# ll
---xrw-r-- 1 root bin  302108 11-13 06:03 log2012.log
```
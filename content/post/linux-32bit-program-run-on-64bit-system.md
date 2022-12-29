---
title: "Linux 64 位系统运行 32 位程序"
date: "2022-07-11 12:55:00"
lastmod: "2022-12-24 14:40:22"
categories: ["Linux"]
draft: false
---

## step {#step}

linux 64 位系统默认不支持 32 位程序运行.

```bash
# 查看程序
file program_name

# 查看系统
uname -a

# 安装32位库
# ubuntu
apt-get install ia32-libs

# centos
yum  install  xulrunner.i686
# yum  install  ia32-libs.i686 glibc.i686 vim*

# redhat
# 使用centos源
yum  install  xulrunner.i686
```


## Ref {#ref}

-   [64位的Linux配置32位运行库[附:Yum源配置]​](https://blog.csdn.net/KamRoseLee/article/details/80368283)
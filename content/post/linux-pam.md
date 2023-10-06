---
title: "Linux pam.d faillock 配置"
date: "2023-10-06 19:14:00"
lastmod: "2023-10-06 19:14:57"
categories: ["Linux"]
draft: false
---

## 导言

> Removed deprecated pam\_tally and pam\_tally2 modules, use pam\_faillock instead.

-   pam\_tally2配置

``` bash
sed -i '1s/^/auth required pam_tally2.so  onerr=fail deny=5 unlock_time=600 even_deny_root root_unlock_time=60/' /etc/pam.d/login
sed -i '1 i auth required pam_tally2.so  onerr=fail deny=5 unlock_time=600 even_deny_root root_unlock_time=60' /etc/pam.d/sshd
```

## 建立存储目录

> [mkdir](https://so.csdn.net/so/search?q=mkdir&spm=1001.2101.3001.7020) /var/log/faillock

faillock相关的信息会以用存储在这个目录下

## 配置

1.  远程登录文件`/etc/pam.d/sshd`

``` conf
auth     requisite                    pam_faillock.so    preauth
auth     [success=1 default=bad]      pam_unix.so        shadow nullok
auth     [default=die]                pam_faillock.so    authfail
auth     sufficient                   pam_faillock.so    authsucc

account    required     pam_unix.so shadow nullok
password   required     pam_unix.so shadow nullok
session    required     pam_unix.so shadow nullok
session    required     pam_loginuid.so
```

-   success=1 表示此行成功后，跳过下面
-   default=die 表示之后的不执行了，因为succ成功后，会抹去登录失败的记录信息

2.  faillock配置文件`/etc/security/faillock.conf`

``` conf
dir = /var/log/faillock
deny = 5
fail_interval = 180
unlock_time = 600

even_deny_root# root也受限
root_unlock_time = 60
```

## 测试

`faillock --dir /var/log/faillock --user root`

``` bash
faillock --dir /var/log/faillock --user root
root:
When                Type  Source                                           Valid
2021-04-21 09:49:49 RHOST 172.16.254.216                                       V
2021-04-21 09:49:52 RHOST 172.16.254.216                                       V
```

-   v表示有效，i表示无效

## faillock命令

> faillock --reset # 解锁所有用户
> faillock --user user --reset # 解锁一个用户账户
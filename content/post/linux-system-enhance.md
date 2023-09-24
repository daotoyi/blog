---
title: "Linux 系统安全加固"
date: "2023-09-24 20:48:00"
lastmod: "2023-09-24 20:48:31"
categories: ["Linux"]
draft: false
---

## passwd {#passwd}


### 密码复杂度 {#密码复杂度}

口令长度不 得小于 8 位，且为字母、数字或特殊字符的混合组合，用户名和口令不得相同，禁止明文存 储口令，应使用 MD5、SHA1、DES 等较复杂的加密算法对密码进行密文存储.

-   /etc/pam.d/common_password
    中添加

<!--listend-->

```bash
password requisite
pam\_cracklib.so debug minlen=8 ucredit=-2 lcredit=-1 dcredit=-4 ocredit=-1 enforce\_for_root
```

**此语句必须添加在第一行 ，否则无法生效**

-   具体参数含义如下：
    -   minlen：最小密码长度
    -   ucredit：最少大写字母
    -   lcredit：最少小写字母
    -   dcredit：最少数字
    -   ocredit：最少特殊字符

**enforce\\_for\\_root：使限制作用于超级用户，否则显示告警后仍能修改成功.**

-   /etc/login.defs

<!--listend-->

```cfg
PASS_MAX_DAYS	 99999
PASS_MIN_DAYS	 0
PASS_WARN_AGE 7
PASS_MIN_LEN 8
```


## 登录锁定 {#登录锁定}


### Debian {#debian}

启用登录失败处理功能，可采取结束会话、限制非法登录次数和自动退出等措施：应限制同一用户连续失败登录次数，主机登录失败超过预设值锁定账户一定时间。

在\`/etc/pam.d/common-auth\` 配置文件中添加

```cfg
auth required pam\_tally2.so deny=5 unlock\_time=600 even\_deny\_root root\_unlock\_time=60
```

在\`/etc/pam.d/common-account\` 配置文件中添加

```cfg
account required pam_tally2.so
```

**（如果不修改此配置文件，则会出现即使登录成功，系统的登录失败计数器也会不停的累加，从而导致用户一直被锁定无法登录，这是一个 BUG，只有修改此文件才可以避免此问题）**


### Update Linux {#update-linux}

-   \`vi /etc/pam.d/login\`,在文件首行添加

<!--listend-->

```bash
auth required pam_tally2.so  onerr=fail deny=5 unlock_time=600 even_deny_root root_unlock_time=60
```

-   参数解释：
    -   onerr=fail 表示定义了当出现错误（比如无法打开配置文件）时的缺省返回值；
    -   even_deny_root 表示也限制 root 用户；
    -   deny               表示设置普通用户和 root 用户连续错误登陆的最大次数，超过最大次数，则锁定该用户；
    -   unlock_time 表示设定普通用户锁定后，多少时间后解锁，单位是秒；
    -   root_unlock_time   表示设定 root 用户锁定后，多少时间后解锁，单位是秒；

上面的配置只是限制了用户从 tty 终端登录，而没有限制远程 ssh 登录，如果想 **限制远程登录** ，需要在\`/etc/pam.d/sshd\`文件里配置:
`vim /etc/pam.d/sshd`  （同样添加到 auth 区域的第一行）

```bash
auth required pam_tally2.so  onerr=fail deny=5 unlock_time=600 even_deny_root root_unlock_time=60
```


#### ARM {#arm}

<span class="timestamp-wrapper"><span class="timestamp">[2020-10-29 周四 08:00]</span></span>
Removed deprecated pam_tally and pam_tally2 modules, use pam_faillock instead.

```cfg
auth     required       pam_securetty.so
auth     required       pam_env.so
auth     required       pam_nologin.so
# optionally call: auth requisite pam_faillock.so preauth deny=4 even_deny_root unlock_time=1200
# to display the message about account being locked
auth     [success=1 default=bad] pam_unix.so
auth     [default=die]  pam_faillock.so authfail deny=4 even_deny_root unlock_time=1200
auth     sufficient     pam_faillock.so authsucc deny=4 even_deny_root unlock_time=1200
auth     required       pam_deny.so
account  required       pam_unix.so
auth     required       pam_nologin.so
auth     required       pam_faillock.so preauth silent deny=4 even_deny_root unlock_time=1200
# optionally use requisite above if you do not want to prompt for the password
# on locked accounts, possibly with removing the silent option as well
auth     sufficient     pam_unix.so
auth     [default=die]  pam_faillock.so authfail deny=4 even_deny_root unlock_time=1200
auth     required       pam_deny.so
account  required       pam_faillock.so
# if you drop the above call to pam_faillock.so the lock will be done also
# on non-consecutive authentication failures
account  required       pam_unix.so
password required       pam_unix.so shadow
session  required       pam_selinux.so close
session  required       pam_loginuid.so
session  required       pam_unix.so
session  required       pam_selinux.so open
```


## 删禁账户 {#删禁账户}

修改 /etc/passwd 文件，将多余账户末尾的 shell 显示为 /sbin/nologin ,或者账户行首为 #.


## 审计 audit {#审计-audit}

-   系统应开启日志进程：\`ps -ef | grep syslogd\`或\`ps aux | grep rsyslogd\`.
-   系统是否开启审计进程\`ps aux | grep audit\`。
-   查看日志配置文件\`/etc/syslog.conf\`或\`/etc/rsyslog.conf\`是否具备日志
    记录策略，默认配置符合要求。


## 超时锁定 {#超时锁定}

根据安全策略设置登录终端的操作超时锁定,修改\`/etc/profile\`文件，进行 TMOUT 设置，添加\`export TMOUT=600\`语句.


## 历史命令 {#历史命令}

修改/etc/profile 配置，添加语句\`export HISTSIZE=10\`
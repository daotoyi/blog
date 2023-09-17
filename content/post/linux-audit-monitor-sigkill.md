---
title: "Linux audit 监控 SIGKILL 的信号"
date: "2023-08-13 11:33:00"
lastmod: "2023-08-13 11:33:08"
categories: ["Linux"]
draft: false
---

## audit {#audit}

audit 是用户空间的一个组件，一般默认安装，配合内核的审计模块一起工作。可以记录与安全相关的内核事件。

```bash
# install
$ yum list audit audit-libs

# conf
/etc/audit/auditd.conf

# rule
/etc/audit/audit.rules

# log
/var/audit/audit.log


# add rule
# 如果是32位的系统将b64替换为b32
auditctl -a entry,always -F arch=b64 -S kill -k kill_signals


# restart service
service auditd start
service auditd restart
```


## ausearch {#ausearch}

```bash
ausearch -k teste_kill
```


## output {#output}

-   log

    ```bahs
    tailf /var/log/audit/audit.log
    ```
-   ausearch

    ```bash
    time->Thu Jan 10 16:58:57 2018
    type=OBJ_PID msg=audit(1515661137.703:156743): opid=29236 oauid=0 ouid=0 oses=23836 obj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 ocomm="push"
    type=SYSCALL msg=audit(1515661137.703:156743): arch=c000003e syscall=62 success=yes exit=0 a0=7234 a1=9 a2=0 a3=7234 items=0 ppid=48597 pid=24814 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts9 ses=23836 comm="sh" exe="/bin/bash" subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key="teste_kill"
    ```

**ppid**.


## reference {#reference}

-   <https://access.redhat.com/solutions/36278>
-   <https://blog.csdn.net/furzoom/article/details/79041443>
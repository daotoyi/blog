---
title: "Selinux"
date: "2022-04-15 14:46:00"
lastmod: "2022-06-25 15:56:56"
categories: ["Linux"]
draft: false
---

```bash
## Reahdet
# 查看SELinux状态：
/usr/sbin/sestatus -v
# SELinux status:  enabled

# or
getenforce

# 关闭SELinux：
# 临时关闭（不用重启机器）：
setenforce 0 # 设置SELinux 成为permissive模式
setenforce 1 # 设置 SELinux 成为 enforcing 模式
```

修改配置文件需要重启机器：

/etc/selinux/config ,将 SELINUX=enforcing 改为 SELINUX=disabled

```bash
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.
SELINUX=disabled
# SELINUXTYPE= can take one of these three values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted
```
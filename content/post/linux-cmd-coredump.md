---
title: "Linux cmd coredump"
lastmod: "2022-07-27 19:08:26"
categories: ["Linux"]
draft: true
---

## 简介 {#简介}

coredumpctl 工具用于提取与处理先前由 systemd-coredump 保存的内存转储数据.

当某个进程（或属于应用程序的所有进程）崩溃时，此工具默认会将核心转储记录到 systemd 日记（如有可能还包括回溯），并将核心转储储存在 /var/lib/systemd/coredump 中的某个文件内。


## 配置 {#配置}

/etc/systemd/coredump.conf

```bash
Storage=none  # 默认是不生成 coredump 文件,在日记中记录核心转储，但不储存
              # external 储存在 /var/lib/systemd/coredump 中
              # journal — 将核心储存在 systemd 日记中
```


## 使用 {#使用}

```bash
coredumpctl list
coredumpctl list --since=today
# “PID” 列包含用于标识崩溃进程的进程 ID

# MYPID=<PID>
# 显示所有 PID=$MYPID 的进程 所产生的内存转储的详细信息
coredumpctl info $MYPID

# 选定的核心输出到 gdb
coredumpctl gdb $MYPID

coredumpctl debug #为最近一次内存转储调用 gdb 调试器
```
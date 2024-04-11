---
title: "Linux cmd pv"
date: "2024-01-13 10:28:00"
lastmod: "2024-01-13 10:28:15"
tags: ["cmd"]
categories: ["Linux"]
draft: false
---

## 简述 {#简述}

显示当前在命令行执行的命令的进度信息，管道查看器。

pv 命令 Pipe Viewer 的简称，由 Andrew Wood 开发。意思是通过管道显示数据处理进度的信息。这些信息包括已经耗费的时间，完成的百分比(通过进度条显示)，当前的速度，全部传输的数据，以及估计剩余的时间。


## 选项 {#选项}

```cfg
-p, --progress           显示进度条
-t, --timer              显示已用时间
-e, --eta                显示预计到达时间 (完成)
-I, --fineta             显示绝对估计到达时间
                         (完成)
-r, --rate               显示数据传输速率计数器
-a, --average-rate       显示数据传输平均速率计数器
-b, --bytes              显示传输的字节数
-T, --buffer-percent     显示正在使用的传输缓冲区百分比
-A, --last-written NUM   显示上次写入的字节数
-F, --format FORMAT      将输出格式设置为FORMAT
-n, --numeric            输出百分比
-q, --quiet              不输出任何信息

-W, --wait               在传输第一个字节之前不显示任何内容
-D, --delay-start SEC    在SEC秒过去之前不显示任何内容
-s, --size SIZE          将估算的数据大小设置为SIZE字节
-l, --line-mode          计算行数而不是字节数
-0, --null               行以零结尾
-i, --interval SEC       每SEC秒更新一次
-w, --width WIDTH        假设终端的宽度为WIDTH个字符
-H, --height HEIGHT      假设终端高度为HEIGHT行
-N, --name NAME          在可视信息前面加上名称
-f, --force              将标准错误输出到终端
-c, --cursor             使用光标定位转义序列

-L, --rate-limit RATE    将传输限制为每秒RATE字节
-B, --buffer-size BYTES  使用BYTES的缓冲区大小
-C, --no-splice          从不使用splice()，始终使用读/写
-E, --skip-errors        跳过输入中的读取错误
-S, --stop-at-size       传输--size字节后停止
-R, --remote PID         更新过程PID的设置

-P, --pidfile FILE       将进程ID保存在FILE中

-d, --watchfd PID[:FD]   监视进程PID,打开的文件FD

-h, --help               显示帮助
-V, --version            显示版本信息
```


## 实例 {#实例}

```bash
# 如果没有指定选项，默认使用 -p, -t, -e, -r 和 -b 选项
# 复制文件时显示进度条
pv getiot.db > getiot.db.bak

# 文件压缩
pv /var/log/syslog | zip > syslog.zip
# 目录无法直接压缩，需要先打包
tar -cf - test | pv -s $(du -sk test | awk '{print $1}') | gzip > test.tar.gz

# 文件解压
pv rootfs.tar.bz2 | tar -jxf - -C rootfs/
pv rootfs.tgz | tar --xattrs --xattrs-include=* -xmf - -C /path/

# 字符一个个匀速在命令行中显示出来
echo "Tecmint[dot]com is a community of Linux Nerds and Geeks" | pv -qL 10

# 用 dd 命令将 iso 写入磁盘，pv来实现进度条的显示
sudo pv -cN source < /path/to/file.iso | sudo dd of=/dev/disk2 bs=4m

# 监控通知
pv -d $(ps -ef | grep -v grep | grep "<key-word>" | awk '{print $2}') && <notice-script>
```
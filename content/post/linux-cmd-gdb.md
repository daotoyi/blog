---
title: "Liunx cmd gdb"
lastmod: "2022-07-27 19:14:53"
categories: ["Linux"]
draft: true
---

## 命令 {#命令}

```bash
命令               简写形式         说明
backtrace          bt、where       显示backtrace
break              b               设置断点
continue           c、cont         继续执行
delete             d               删除断点
finish                             运行到函数结束
info breakpoints                   显示断点信息
next               n               执行下一行
print              p               显示表达式
run                r               运行程序
step               s               一次执行一行，包括函数内部
x                                  显示内存内容
until              u               执行到指定行
其他命令
directory          dir             插入目录
disable            dis             禁用断点
down               do              在当前调用的栈帧中选择要显示的栈帧
edit               e               编辑文件或者函数
frame              f               选择要显示的栈帧
forward-search     fo              向前搜索
generate-core-file gcore           生成内核转存储
help                h              显示帮助一览
info                i              显示信息
list                l              显示函数或行
nexti               ni             执行下一行(以汇编代码为单位)
print-object        po             显示目标信息
sharelibrary        share          加载共享的符号
stepi               si             执行下一行
```


## 常用操作 {#常用操作}


### 断点 {#断点}

```bash
# 根据行号设置断点
(gdb) b 5
(gdb) b test.c:5

# 根据函数设置断点
(gdb) b main

# 根据偏移量设置断点
(gdb) b +12

# 设置临时断点, 临时断点只生效一次
(gdb) tbreak test.c:12

# 显示所有断点
(gdb) info break

# 清除断点
(gdb) delete 4  # 清除某个断点
(gdb) delete    # 清除所有断点
(gdb) clear     # 当前行断点
```


### 运行 {#运行}

```bash
# 运行
r

# 继续单步调试
n

# 继续执行到下一个断点
c

# 查看源码和行号
l
```


### 打印 p {#打印-p}


### 退出 q {#退出-q}
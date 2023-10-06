---
title: "Linux 不同 shell 文件中的函数调用"
date: "2023-10-03 15:30:00"
lastmod: "2023-10-03 15:30:46"
tags: ["shell"]
categories: ["Linux"]
draft: false
---

## 执行外部脚本或命令 {#执行外部脚本或命令}

使用 source 命令或.运算符执行另一个脚本文件。这将导致另一个脚本中的所有命令在当前脚本的上下文中执行。

例如，有两个脚本文件，scriptA.sh 和 scriptB.sh。在 scriptA.sh 中调用 scriptB.sh 中的函数，可以使用以下语法：

```bash
# scriptA.sh
source scriptB.sh
```

或

```bash
# scriptA.sh
./scriptB.sh
```


## 使用函数库 {#使用函数库}

可以将一组相关的函数定义在一个函数库文件中，然后在需要时在其他脚本中导入该函数库并调用其中的函数。

例如，在一个名为 functions.sh 的函数库文件中定义函数 my_function：

```bash
# functions.sh
my_function() {
    echo "Hello from my_function in function library!"
}
```

然后，在其他脚本中导入该函数库并调用其中的函数：

```bash
# scriptA.sh
source functions.sh
my_function
```


## 导出函数 {#导出函数}

使用 export 命令将函数导出到环境中，以便其他 Shell 或脚本可以访问到导出的函数。

例如，在 scriptA.sh 中定义并导出函数 my_function：

```bash
# scriptA.sh
my_function() {
    echo "Hello from my_function in scriptA!"
}
export -f my_function
```

然后，在 scriptB.sh 中导入并调用导出的函数：

```bash
# scriptB.sh
source scriptA.sh
my_function
```
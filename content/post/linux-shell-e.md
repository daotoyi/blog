---
title: "Linux shell 脚本中-e 参数"
date: "2023-03-03 22:15:00"
lastmod: "2023-03-03 22:15:25"
categories: ["Linux"]
draft: false
---

## set -e {#set-e}

在文件开头加上 set -e,这句语句告诉 bash 如果任何语句的执行结果不是 true 则应该退出。这样的好处是防止错误像滚雪球般变大导致一个致命的错误.

如果要增加可读性，可以使用 `set -o errexit` ，它的作用与 `set -e` 相同。


## ref {#ref}

-   [Unix/Linux shell脚本中 “set -e” 的作用](https://blog.51cto.com/sf1314/2062713)
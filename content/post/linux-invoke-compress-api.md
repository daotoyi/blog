---
title: "Linux 调用压缩解压接口"
author: ["SHI WENHUA"]
date: "2024-08-12 21:12:00"
lastmod: "2024-08-12 21:13:00"
categories: ["Linux"]
draft: false
---

在 Linux 系统下通常使用解压缩命令去压缩/解压缩文件。在 C++程序中，要实现该功能，我们有两种方式：

1.  通过 system 函数调用 7z 等命令去执行压缩或者解压缩；
    -   操作起来很简便，但是它比较死板，以解压缩为例，就一定要将压缩包解压出来生成文件，再进行后续使用
2.  通过使用 C++调用解压缩工具库去执行压缩或者解压缩；
    -   比较灵活但是使用要求更高


## 调用 shell 命令 {#调用-shell-命令}


### system {#system}

```c
#include<stdlib.h>
main()
{
  system(“ls -al /etc/passwd /etc/shadow”);
}
```


### popen {#popen}

```c
#include<stdio.h>
main()
{
  FILE * fp;
  char buffer[80];
  fp=popen(“cat /etc/passwd”,”r”);
  fgets(buffer,sizeof(buffer),fp);
  printf(“%s”,buffer);
  pclose(fp);
}
```


## minizip 库 {#minizip-库}

Zipper is a C++11 wrapper around minizip compression library.


### comile library {#comile-library}

```bash
git clone https://github.com/lecrapouille/zipper.git --recursive
cd zipper
make download-external-libs
make compile-external-libs
make -j`nproc --all`
```


### invoke library {#invoke-library}

```c++
#include <Zipper/Unzipper.hpp>
#include <Zipper/Zipper.hpp>
```

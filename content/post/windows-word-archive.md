---
title: "Word archive"
date: "2022-11-07 18:55:00"
lastmod: "2023-09-06 09:42:27"
categories: ["Windows"]
draft: false
---

## 模板 {#模板}

-   [一劳永逸，打造自己的word常规模板](https://zhuanlan.zhihu.com/p/22737822)


## hyper-VT 虚拟化选项 {#hyper-vt-虚拟化选项}

管理员权限执行批处理。

```bat
pushd "%~dp0    "
dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hyper-v.txt
for /f %%i in ('findstr /i . hyper-v.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"
del hyper-v.txt
Dism /online /enable-feature /featurename:Microsoft-Hyper-V-All /LimitAccess /ALL
```
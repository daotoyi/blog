---
title: "cmake"
lastmod: "2023-10-06 18:21:48"
categories: ["Code"]
draft: true
---

## windows cmake {#windows-cmake}

```shell
#  打印出所有 generator
cd build/;
cmake .. -G

# 生成 unix 下的 MakeFiles
cd build/
cmake  ..  -G "Unix Makefiles"
# 简化`-G "Unix Makefiles"`（cmake  ..）,在 CMakeLists.txt 文件的同级目录下，写入`PreLoad.cmake`文件内容。
set(CMAKE_GENERATOR "Unix Makefiles" CACHE INTERNAL "" FORCE)

 # 编译 exe
 make
```
---
title: "Python 调用 C++的方式"
date: "2022-08-07 13:09:00"
lastmod: "2022-08-07 13:10:02"
categories: ["Python"]
draft: false
---

## 调用 Python 的自有模块 ctypes(.cpp 编译好的.so) （简单） {#调用-python-的自有模块-ctypes--dot-cpp-编译好的-dot-so--简单}

```python { linenos=table, linenostart=1 }
from ctypes import *
import os
sotest = cdll.LoadLibrary(os.getcwd()+ "/libcdll.so")
```

```shell
gcc -fPIC test.c -o example.so -shared  -I/usr/include/python2.7
```

-fPIC：生成位置无关目标代码，适用于动态连接；
-L path：表示在 path 目录中搜索库文件，如-L.表示在当前目录；
-I path：表示在 path 目录中搜索头文件；
-o file：制定输出文件为 file；
-shared：生成一个共享库文件；


## 调用 c/c++编写的扩展模块（推荐） {#调用-c-c-plus-plus-编写的扩展模块-推荐}

```c++
// #include "Python.h"
#include <Python.h>
using namespace std;

extern "C"
int add_func(int a,int b)
{
    return a+b;
}

extern "C"{
static PyObject *_add_func(PyObject *self, PyObject *args)
{
    int _a,_b;
    int res;

    if (!PyArg_ParseTuple(args, "ii", &_a, &_b))
        return NULL;
    res = add_func(_a, _b);
    return PyLong_FromLong(res);
}
}

extern "C"{
static PyMethodDef exCplusMethods[] =
{
    {"add_func", _add_func, METH_VARARGS, ""},
    {NULL, NULL, 0, NULL}
};
}

// Python 3.x中不再使用Py_InitModule.
// extern "C"
// PyMODINIT_FUNC initlibexdll(void)
// {
//     (void) Py_InitModule("libexdll", exCplusMethods);
// }

// 创建一个 PyModuleDef结构，然后将引用传递给 PyModule_Create。
static struct PyModuleDef exdll = {
           PyModuleDef_HEAD_INIT,
           "add_func", /* name of module */
           NULL, /* module documentation, may be NULL */
           -1,   /* size of per-interpreter state of the module,
                       or -1 if the module keeps state in global variables. */
           exCplusMethods
};

PyMODINIT_FUNC PyInit_libexdll( void )
{
  return PyModule_Create( &exdll );
}
```

```shell
cl /LD exdll.cpp /o libexdll.pyd -I C:\Python27\include C:\Python27\libs\python27.lib

g++ -fPIC exdll.cpp -shared -o libexdll.so -I /usr/include/python3.8/ -lpython3.8
```

函数介绍：

-   包裹函数_add_func。它负责将 Python 的参数转化为 C 的参数（PyArg_ParseTuple），调用实际的 add_function，并处理 add_function 的返回值，最终返回给 Python 环境。

-   参数解析 PyArg_ParseTuple，将 python 的变量解析成 C/C++变量，按照 ii,si,ss 等格式
-   导出表 exCplusModuleMethods。它负责告诉 Python 这个模块里有哪些函数可以被 Python 调用。导出表的名字可以随便起，每一项有 4 个参数：
    -   第一个参数是提供给 Python 环境的函数名称，这个名称可以任取，
    -   第二个参数是_add_function，即包裹函数。
    -   第三个参数的含义是参数变长，
    -   第四个参数是一个说明性的字符串。导出表总是以{NULL,NULL, 0,NULL}结束。

-   导出函数 initcpp_module。这个的名字不是任取的，是你的 module 名称添加前缀 init。导出函数中将模块名称与导出表进行连接。


## 调用.cpp 编译好的.exe 文件 {#调用-dot-cpp-编译好的-dot-exe-文件}

```python { linenos=table, linenostart=1 }
import commands
import os

main = "./cppexec"
if os.path.exists(main):
    rc, out = commands.getstatusoutput(main)
    print('rc = %d, \nout = %s' % (rc, out))

cpptest="cppexec.exe" #in linux without suffix .exe
if os.path.exists(cpptest):
  f=os.popen(cpptest)
  data=f.readlines() #read the C++ printf or cout content
  f.close()
  print(data)

print("python execute cpp program:")
os.system(cpptest)
```
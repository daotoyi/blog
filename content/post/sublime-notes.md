---
title: "Sublime Notes"
date: "2022-04-12 11:58:00"
lastmod: "2022-04-30 12:48:35"
categories: ["Tools"]
draft: false
---

## python {#python}


### default python config {#default-python-config}

使用默认配置报错 `Unable to create process`.因为默认配置使用 `“C:\Program Files\WindowsApps\PythonSoftwareFoundation.Python.3.9_3.9.1520.0_x64__qbz5n2kfra8p0\python3.9.exe”` .

tools -&gt; build system -&gt; new build system ; 新建 `Python.sublime-build`

```cfg
{
  "cmd":["D:/Program Files/JetBrains/Anaconda3/python.exe", "-u", "$file"],
  "file_regex": "^[ ]*File \"(...*?)\", line ([0-9]*)",
  "selector": "source.python",
  "encoding": "utf-8" ,
  "env": {"PYTHONIOENCODING": "utf8"}
}
```
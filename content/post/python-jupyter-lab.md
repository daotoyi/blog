---
title: "Jupyter Notebook/Lab"
date: "2022-04-16 13:31:00"
lastmod: "2022-04-30 12:46:06"
categories: ["Python"]
draft: false
---

## notebook {#notebook}


## lab {#lab}

```bash
pip install jupyterlab
jupyter lab
```

```bat
rem echo off
@echo off
if "%1"=="h" goto begin
start mshta vbscript:createobject("wscript.shell").run("""%~nx0"" h",0)(window.close)&&exit
:begin

e:
cd Refine\Python\Jupyter

rem activate base
rem manual start jupyterLab, `activate base` needed
rem in jupyterlab.bat, if activate, it will not work.

::.\jupyter.exe.lnk lab
jupyter lab

pause
```
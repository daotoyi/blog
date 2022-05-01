---
title: "XYplorer"
lastmod: "2022-04-30 19:13:36"
tags: ["XYplorer"]
categories: ["Tools"]
draft: true
---

## 批量重命名 {#批量重命名}

XYplorer 的重命名功能有些“怪异”，它将重命名分解成三个子项，分别是：

-   Batch Rename
-   Regex Rename
-   Search and Replace


### Batch Rename {#batch-rename}

处理“整体”文件名, **加前后缀，或者加序号**

点击文件-重命名，或按快捷键 F2:

-   &lt;#01&gt;.\* : 给选中的文件添加前缀排列序号

<!--listend-->

```cfg

All examples are applied to Test.txt (dated 2011-Aug-25) on 2011-Oct-23.

Simple syntax:
    New  =  New.txt (New-01.txt etc. ... if New.txt exists)

Syntax for increments:
    New<#1>  =  New1.txt, New2.jpg, ... New74.png ...
    New<#00>  =  New00.txt, New01.jpg, ... New235.png ...

Syntax for date variables:
    New_<date yyyy-mm-dd>  =  New_2011-10-23.txt (date now)
    New_<datem yyyy-mm-dd>  =  New_2011-08-25.txt (date modified)
    New_<datec yyyy-mm-dd>  =  New_2004-09-19.txt (date created)

Wildcards * and ?:
    New-*  =  New-Test.txt (* = original base)
    *-<date yyyy>  =  Test-2011.txt
    ?-<#001>  =  txt-001.txt (? = original extension)

Switches /e /i /s (can be combined to /eis):
    *-<date yyyy>.dat /e  =  Test-2011.dat (/e = drop original extension)
    *-<date yyyy>.dat /ei  =  Test-2011-01.dat (/i = add increment on collision)
    Test-<#001> /s  =  Test-002.txt (/s = skip existing index)

The original file extensions remain unchanged. Unless the pattern is suffixed with /e.
```


### Regex Rename {#regex-rename}

```cfg

Syntax:
    Format 1: RegExpPattern > ReplaceWith     (case-insensitive: a=A)
    Format 2: RegExpPattern > ReplaceWith\    (case-sensitive)

The separator between RegExpPattern and ReplaceWith is currently set to ' > ' (can be modified at INI key RegExpRenameSep).

Renaming includes file extensions.
```


### Search and Replace {#search-and-replace}

```cfg

Examples:
    before/now  =  replace all 'before' with 'now'
    äöü>>aou  =  replace all ä with a, ö with o, ü with u
    Ä|Ö|Ü|ä|ö|ü>>Ae|Oe|Ue|ae|oe|ue  =  replace all Ä with Ae, Ö with Oe, etc.
    []{};,!>_ =  replace each of these characters with _
    123>Num =  replace all 1, 2, and 3 with Num
    []{};,!  =  remove all these characters

The original file extensions remain unchanged.
```


### Ref {#ref}

-   [XYplorer 实用技巧：批量重命名使用方法](https://www.jb51.net/softjc/511250.html)
-   [利用XYplorer对文件进行批量编号重命名](https://zhuanlan.zhihu.com/p/143934309)
-   [批量修改文件名，只是这个神器最小的功能](https://blog.csdn.net/weixin_39975055/article/details/112671528)
-   Notes
    -   使用说明可参考右键--- Rename Special --- 各模式窗口的说明中
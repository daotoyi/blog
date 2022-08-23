---
title: "Linux locale"
date: "2022-04-03 17:09:00"
lastmod: "2022-08-09 09:25:43"
categories: ["Linux"]
draft: false
---

## locale {#locale}

```cfg
$ locale

LANG=en_US.UTF-8
LC_CTYPE="en_US.UTF- 8"                     #用户所使用的语言符号及其分类
LC_NUMERIC="en_US.UTF- 8"                 #数字
LC_TIME="en_US.UTF-8"                       #时间显示格式
LC_COLLATE="en_US.UTF-8"                 #比较和排序习惯
LC_MONETARY="en_US.UTF-8"             #LC_MONETARY
LC_MESSAGES="en_US.UTF- 8"             #信息主要是提示信息,错误信息, 状态信息, 标题, 标签, 按钮和菜单等
LC_PAPER="en_US.UTF- 8"                     #默认纸张尺寸大小
LC_NAME="en_US.UTF-8"                     #姓名书写方式
LC_ADDRESS="en_US.UTF-8"               #地址书写方式
LC_TELEPHONE="en_US.UTF-8"             #电话号码书写方式
LC_MEASUREMENT="en_US.UTF-8"         #度量衡表达方式
LC_IDENTIFICATION="en_US.UTF-8"       #对自身包含信息的概述
LC_ALL=
```


## location {#location}

-   Locale 定义文件放在/usr/share/i18n/locales
-   自定义 locale 放在/usr/lib/locale/目录中


## priority {#priority}

-   设定 locale 就是设定 12 大类的 locale 分类属性，即 12 个 LC_\*。
-   除了这 12 个变量可以设定以外，为了简便起见，还有两个变量：LC_ALL 和 LANG。
-   它们之间有一个优先级的关系： `LC_ALL > LC_* > LANG` 。

可以这么说，LC_ALL 是最上级设定或者强制设定，而 LANG 是默认设定值.


## useage {#useage}


### example {#example}

```cfg
LANG="en_US.UTF-8"，xwindow会显示英文界面，
LANG="zh_CN.GB18030", xwindow会显示中文界面。
```


### localdef {#localdef}

```bash
localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
```

是用来产生编码文件，这一步不是必须，编码文件一般都存在，运行 localedef –help 能查看当前编码文件所在的路径。


### export LC_\* {#export-lc}

```bash
export LC_ALL=zh_CN.utf8
```


### i18n {#i18n}

更改当前的编码为 zh_CN.utf8，如果要永久更改：

-   运行： echo "export LC_ALL=zh_CN.utf8"&gt;&gt; /etc/profile
-   或者修改/etc/sysconfig/i18n 文件配置。


### $HOME/.i18n {#home-dot-i18n}

cp _etc/sysconfig/i18n $HOME_.i18n

**修改$HOME/.i18n 文件,就可以改变个人的界面语言，而不影响别的用户.**


## Note {#note}

Windows 的默认编码为 GBK，Linux 的默认编码为 UTF-8。在 Windows 下编辑的中文，在 Linux 下显示为乱码。

UTF-8 是编码方式. en_US.UTF-8 和 zh_CN.UTF-8 是语言环境，也就是字符集.

"C"是系统默认的 locale，"POSIX"是"C"的别名。

cat /etc/sysconfig/i18n

```cfg
LANG="zh_CN.UTF-8"
LANGUAGE="zh_CN.GB18030:zh_CN.GB2312:zh_CN"
SUPPORTED="zh_CN.UTF-8:zh_CN:zh:en_US.UTF-8:en_US:en"
SYSFONT="lat0-sun16"
SYSFONTACM="8859-15"
```


## Ref {#ref}

-   [**详解 Linux 中文乱码问题终极解决方法**](https://www.jb51.net/article/96559.htm)
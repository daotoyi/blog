---
title: "locale"
date: "2022-04-03 17:09:00"
lastmod: "2022-04-30 12:45:41"
categories: ["Linux"]
draft: false
---

## locale 分类 {#locale-分类}

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


## prority {#prority}

-   设定 locale 就是设定 12 大类的 locale 分类属性，即 12 个 LC_\*。
-   除了这 12 个变量可以设定以外，为了简便起见，还有两个变量：LC_ALL 和 LANG。
-   它们之间有一个优先级的关系： `LC_ALL > LC_* > LANG` 。

可以这么说，LC_ALL 是最上级设定或者强制设定，而 LANG 是默认设定值.


## cmd {#cmd}

```bash
localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
```

是用来产生编码文件，这一步不是必须，编码文件一般都存在，运行 localedef –help 能查看当前编码文件所在的路径。

```bash
export LC_ALL=zh_CN.utf8
```

更改当前的编码为 zh_CN.utf8，如果要永久更改，运行： echo "export LC_ALL=zh_CN.utf8"&gt;&gt; /etc/profile
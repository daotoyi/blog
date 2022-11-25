---
title: "Org Archive"
date: "2022-11-25 23:07:00"
lastmod: "2022-11-25 23:07:35"
categories: ["emacs"]
draft: false
---

## org-mode {#org-mode}


### basic {#basic}

> touch **\***.org
> C-c-e   export menuone
> R-B     broswer to reveal.js html


### block {#block}

> s    #+begin_src ... #+end_src
> e    #+begin_example ... #+end_example  : 单行的例子以冒号开头
> q    #+begin_quote ... #+end_quote      通常用于引用，与默认格式相比左右都会留出缩进
> v    #+begin_verse ... #+end_verse      默认内容不换行，需要留出空行才能换行
> c    #+begin_center ... #+end_center
> l    #+begin_latex ... #+end_latex
> L    #+latex:
> h    #+begin_html ... #+end_html
> H    #+html:
> a    #+begin_ascii ... #+end_ascii
> A    #+ascii:
> i    #+index: line
> I    #+include: line


### parameter {#parameter}

```c { linenos=table, linenostart=1 }
...code...
```

其中：
  c 为所添加的语言
  -n 显示行号
  -t 清除格式
  -h 7 设置高度为 7 -w 40 设置宽度为 40
以‘#‘开头的行被看作注释，不会被导出区块注释采用如下写法：


## customize {#customize}

M-x customize-group 后选择对应的插件名称，可以进入可视化选项区对指定的插 件做自定义设置。

当选择 Save for future session 后，刚刚做的设计就会被保存在你的 配置文件（ init.el ）中。


## config {#config}

```lisp
;; 添加 Org-mode 文本内语法高亮
(require 'org)								;'
(setq org-src-fontify-natively t)

;; 设置默认 Org Agenda 文件目录
(setq org-agenda-files '("~/org"))			;'

;; 设置 org-agenda 打开快捷键
(global-set-key (kbd "C-c a") 'org-agenda)	;'

C-c . 		插入当前日期
C-u C-c . 	插入当前日期和时间
C-c C-s 	选择想要开始的时间
C-c C-d 	选择想要结束的时间
C-c a 		可以打开 Agenda 模式菜单并选择不同的可视方式（ r ）
```


## fcit {#fcit}

```lisp
spacemacs/chinese layer
(chinese :variables chinese-enable-fcitx t )
;; 或者
fcitx.el - Better fcitx integration for Emacs.
```
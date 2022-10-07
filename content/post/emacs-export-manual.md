---
title: "Org(eamcs) set&export"
date: "2022-03-11 17:46:00"
lastmod: "2022-09-13 22:59:07"
tags: ["org"]
categories: ["emacs"]
draft: false
---

## [Emacs: Align Text](http://xahlee.info/emacs/emacs/emacs_align_and_sort.html) {#emacs-align-text}


## [Export Settings](https://orgmode.org/manual/Export-Settings.html) {#export-settings}


## [org-mode各种设定](https://blog.csdn.net/railsbug/article/details/107173083) {#org-mode各种设定}


## highlight inline {#highlight-inline}

`=code=`, `~code~`


## highlight in export file {#highlight-in-export-file}

`code-src`


## export pdf (LATEX_HEADER) {#export-pdf--latex-header}

```org
#+LATEX_HEADER: documentclass{article}
#+LATEX_CLASS_OPTIONS: [a4paper]
#+LATEX_HEADER: usepackage{xeCJK}
#+LATEX_HEADER: usepackage{minted}
#+LATEX_HEADER: usepackage[margin=2cm]{geometry}
#+LATEX_HEADER: setminted{fontsize=small,baselinestretch=1}
```


## 防止页面溢出 {#防止页面溢出}

如果一个 table 太宽了，导出成 pdf 时会超出页面。把它搞成 longtable 就可以 解决了。这样可以设置每一列的长度。

```org
  #+ATTR_LATEX: :environment longtable :align l|lp{3cm}r|l
| ..... | ..... |
| ..... | ..... |
```
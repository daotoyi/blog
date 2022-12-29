---
title: "Org Export Pdf"
date: "2022-12-24 14:46:00"
lastmod: "2022-12-24 14:47:24"
tags: ["org"]
categories: ["emacs"]
draft: false
---

## Table {#table}


### 溢出表格 {#溢出表格}


#### 整体缩放 {#整体缩放}

表格前后增加以下内容

```org
#+LaTeX: \resizebox{\textwidth}{!}{

| 姓名 | 身高 | 颜值 | 爱好 | 交往系数 |
|------+-----+------+------+---------|
|      |     |      |      |         |
#+LaTeX: }
```


#### +ATTR_LATEX {#plus-attr-latex}

改字号+longtable+align+隐藏列,用 landscape 旋转为横向

```org
#+LATEX: \begin{landscape}
#+LATEX: \zihao{-6}
#+ATTR_LATEX: :environment longtable :align l|l|l|p{0.7cm}|p{0.7cm}|p{0.7cm}|p{0.7cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|p{0.8cm}|l|
.....

#+LATEX: \end{landscape}
```


#### align {#align}

```org
# #+ATTR_LATEX: :environment longtable :align l|lp{3cm}r|l
# #+attr_latex :font \tiny :float sideways
```


## Item {#item}


### 缩进 {#缩进}

所有序号都缩进两个汉字

```org
#+LaTeX: \begin{adjustwidth}{1.2em}{0em}

1. 卧梅又闻花
2. 暗枝伤恨底
3. 遥闻卧似水
4. 易透达春绿
5. 岸似透黛绿
#+LaTeX: \end{adjustwidth}
```


## Ref {#ref}

-   [org-mode导出latex，如何调整org表格的大小](https://emacs-china.org/t/org-mode-latex-org/8044/15)
-   [Tables in LaTeX export](https://orgmode.org/manual/Tables-in-LaTeX-export.html)
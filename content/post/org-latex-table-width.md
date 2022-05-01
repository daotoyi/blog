---
title: "Table: Org-mode 导出表格过宽溢出页面"
date: "2022-02-19 12:43:00"
lastmod: "2022-04-30 12:45:13"
categories: ["Latex"]
draft: false
---

## 表格横置 `\usepackage(lscape)` {#表格横置-usepackage--lscape}

-   建议加在表格的最外层


## 表格横置 `\usepackage{rotating}` {#表格横置-usepackage-rotating}


## 页面横置 `\usepackage{pdflscape}` {#页面横置-usepackage-pdflscape}


## 自动调整字体的大小 `\usepackage{graphix}` {#自动调整字体的大小-usepackage-graphix}


## 缩小字体 `\footnotesize` {#缩小字体-footnotesize}

在\begin{table}后使用\footnotesize 或其他指定的 font size 使得 table 字体变小, 注意太宽的表格变化后还有可能过宽, 此法只能暂时用.


## 缩放表格 `\scalebox` {#缩放表格-scalebox}


## 参考资料 {#参考资料}

-   [org-manual](https://orgmode.org/manual/LaTeX-Export.html)
-   [Latex表格太宽处理方法 (How to shorten Latex table length)](https://www.cnblogs.com/jins-note/p/9513362.html)
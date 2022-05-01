---
title: "Table: latex 表格超详细教程"
date: "2022-02-19 12:44:00"
lastmod: "2022-04-30 12:45:13"
categories: ["Latex"]
draft: false
---

## 常用配置说明 {#常用配置说明}

-   \begin{table\*}[t], \*号，是为了让表格宽度与页面等宽而不是二分之一宽
-   \begin{center}让表格居中
-   \caption{Your first table.}写表格的标题
-   \begin{tabular}{l|c|r}这里面的{l|c|r}
    -   包含了三个字母，代表了表格总共有三列第一列靠左偏移，第二列居中，第三列靠右偏移。
    -   竖线代表列之间用线分隔开来

latex 里的表格是一行行来绘制的,每一行里面用 `&` 来分隔各个元素，用 `\\` 来结束当前这一行的绘制.

-   \hline，它的作用是画一整条横线
    -   画一条只经过部分列的横线，则可以用 cline{a-b}


## 表格单元占据多个行(multirow)或者列(multicolumn) {#表格单元占据多个行--multirow--或者列--multicolumn}

要引入相关的包 `\usepackage{multirow}`

`\multirow{NUMBER_OF_ROWS}{WIDTH}{CONTENT}`

-   NUMBER_OF_ROWS 代表该表格单元占据的行数
-   WIDTH 代表表格的宽度，一般填 \* 代表自动宽度
-   CONTENT 则是表格单元里的内容

`\multicolumn{NUMBER_OF_COLUMNS}{ALIGNMENT}{CONTENT}`

-   NUMBER_OF_COLUMNS 代表该表格单元占据的列数
-   ALIGNMENT 代表表格内容的偏移（填 l,c 或者 r）
-   CONTENT 则是表格单元里的内容


## multirow 与 multicolumn 结合 {#multirow-与-multicolumn-结合}

只需要把 `\multirow{NUMBER_OF_ROWS}{WIDTH}{CONTENT}` 的 **CONTENT** 写成 **multicolumn** 就可以了.


## 参考 {#参考}

-   [（table, tabular, multirow, multicolumn）](https://blog.csdn.net/weixin_41519463/article/details/103737464)
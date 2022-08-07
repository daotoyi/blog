---
title: "HTML、XML、XPath"
lastmod: "2022-08-07 10:49:15"
categories: ["Code"]
draft: false
---

## HTML {#html}

-   Hyper Text Markup Language（超文本标记语言）的缩写.
-   在浏览器中看到的内容都是 HTML 代码经过浏览器渲染的结果


## XML {#xml}

-   EXtensible Markup Language（可扩展标记语言）的缩写
-   类似 HTML 的标记语言，不过 XML 的设计宗旨是传输数据，而非显示数据。


## XPath {#xpath}

-   XML Path Language（XML 路径语言）的缩写
-   在 XML 文档中查找信息的语言，用来提取 XML 文档中的元素和属性
-   XPath 语言获取 HTML 中的内容时，先将 HTML 转换成 XML 文档，然后根据 XML 的树形结构来定位到指定的元素和属性，提取数据。


### 路径表达式 {#路径表达式}

> nodename   选取此节点的所有子节点。
> /   从根节点选取。正斜杠也是路径分隔符。
> //  从任意位置选取文档中的节点。
> .   选取当前节点。
> ..  选取当前节点的父节点。
> @   选取当前节点的属性


### 通配符 {#通配符}

> \\\*    任意元素。
> @\*   任意属性。
> node()  任意子节点（元素，属性，内容)。


### 谓语 {#谓语}

> //a[n] n 为 1 开始的整数，选取排在第 n 个位置的&lt;a&gt;元素。
> //a[last()] last()表示选取排在最后位置的&lt;a&gt;元素。
> //a[last()-1] 和上面同理，表示选取倒数第二个&lt;a&gt;元素。
> //a[position()&lt;3] 选取第一个和第二个&lt;a&gt;元素。
> //a[@href] 选取拥有 href 属性的&lt;a&gt;元素。
> //a[@href='www.baidu.com'] 选取 href 属性值为'www.baidu.com'的&lt;a&gt;元素。
> //a[@price&gt;10] 选取 price 属性值大于 10 的&lt;a&gt;元素。
> //a[@price&gt;10]/span  选取 price 属性值大于 10 的&lt;a&gt;元素下的&lt;span&gt;元素。

谓语用来查找某个特定的节点，或包含某个指定值的节点，语法写在元素名后的方括号中，可以写元素的位置编号、函数、用@选取属性等


### 选取多个路径 {#选取多个路径}

> //book/title | //book/price  选取&lt;book&gt;元素的所有&lt;title&gt;和&lt;price&gt;元素。
> //title | //price  选取所有&lt;title&gt;和&lt;price&gt;元素。
> /bookstore/book/title | //price  选取属于&lt;bookstore&gt;元素的&lt;book&gt;元素的所有&lt;title&gt;元素，以及所有的&lt;price&gt;元素。


### 运算符 {#运算符}

> -   - \* div 加减乘除。
>
> = != 等于，不等于。
> &lt; &lt;= 小于，小于等于。
> &gt; &gt;= 大于，大于等于。
> or and  或，与
> mod   计算余数


### 常用函数 {#常用函数}

> contains(@属性,string) 选取属性里包含字符串 string 的元素。
> text()  获取元素中的内容。
> last()  选取最后一个元素。
> position() 用于选取多个元素中某些位置（数字编号）的元素。
> count()  返回元素的数量。
> max() 返回最大的元素，min(),avg(),sum()同理。


### lxml 解析 {#lxml-解析}

lxml 是 Python 中用来解析 HTML/XML的第三方库，lxml的主要功能是生成一个解析器，解析和提取HTML/XML中的数据。
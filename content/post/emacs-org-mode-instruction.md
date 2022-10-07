---
title: "Org-mode 简介"
lastmod: "2022-09-24 08:46:08"
categories: ["emacs"]
draft: false
---

## 列表 {#列表}

常用快捷键：

-   M-RRT 插入同级列表项
-   M-S-RRT 插入有 checkbox 的同级列表项
-   C-c C-c 改变 checkbox 状态
-   M-left/right 改变列表项层级关系
-   M-up/dowm 上下移动列表项

-   [-] 任务 1 <code>[33%]</code>
    1.  [ ] 子任务 1

    2.  [X] 子任务 2

    3.  [ ] 子任务 3

-   [ ] 任务 2

<!--listend-->

-   treeroot
    -   branch1

    -   branch2


## 表格 {#表格}


### 表格创建 {#表格创建}

创建表格时，首先输入表头：


#### 手动创建 {#手动创建}

```text
input | Name        |  Phone | sub1 | sub2 | total |
|-
```

然后按 tab，表格就会自动生成


#### 自动创建 {#自动创建}

也可以按 C-c | 然后输入表格大小即可。默认是 5x2 也就是 5 列 2 行的，且其中一行是 header


#### 智能创建 {#智能创建}

直接将 buffer 上已有的数据格式化成表格：

-   如果是以逗号(,)分隔的 CSV 格式的数据，选中，然后使用 "C-c |" 这个快捷键
-   如果数据之间是用空格分隔的，选中后使用快捷键"C-u 1 C-c |"即可


### 简单操作 {#简单操作}

-   C-c C-c 对齐表格
-   tab 调到右边一个表格
-   enter 跳到下方的表格
-   M-up/right/left/right 上下左右移动行（列）
-   M-S-up/right/left/right 向上下左右插入行（列）
    如果要插入行和列，也可在表头添加一个标签或者新起一行，输入|再调整格式即可。

| Name        | Phone  | sub1 | sub2 | total |
|-------------|--------|------|------|-------|
| maple       | 134... | 89   | 98   | 187   |
| wizard      | 152... | 78   | 65   | 143   |
| Hello World | 123... | 76   | 87   | 163   |
| hehe        | 157... | 87   | 78   | 165   |


### 表格计算 {#表格计算}

在上表中 total 列中任一行输入 =$3+$4 ，然后按 C-u C-c C-c


### Ref {#ref}

-   [强大的 Org mode(3): 表格的基本操作及公式、绘图](https://www.zmonster.me/2016/06/03/org-mode-table.html)


## 链接 {#链接}

链接的格式是：

```text
[[链接地址][链接内容]]
```

[[grgguid.pdf](http://orgmode.org/orgguide.pdf)]

[a picture](e:/home/maple/图片/test.jpg)

直接显示图片：

```org
[[#+COMMENT: file:/home/maple/图片/test.jpg]]
```


## 待办事项 TODO {#待办事项-todo}

TODO 是一类标题，需要用\*开头

-   C-c C-t 变换 TODO 的状态
-   C-c / t 以树的形式展示所有的 TODO
-   C-c ,   设置优先级（方括号里的 ABC）
-   M-S-RET 插入同级 TODO 标签
-   C-c C-c [ ]中的 x 标识


### <span class="org-todo todo DRAFT">DRAFT</span> 任务 1 {#任务-1}


### <span class="org-todo todo TODO">TODO</span> 任务 2 {#任务-2}


### <span class="org-todo todo TODO">TODO</span> 总任务 <code>[33%]</code> {#总任务}


#### <span class="org-todo todo TODO">TODO</span> 子任务 1 {#子任务-1}


#### <span class="org-todo todo TODO">TODO</span> 子任务 2 <code>[100%]</code> {#子任务-2}

-   [X] subsub1 <code>[2/2]</code>
    -   [X] subsub2
    -   [X] subsub3


#### <span class="org-todo done DONE">DONE</span> 一个已完成的任务 {#一个已完成的任务}


## 标签 Tags {#标签-tags}

子标题的标签会继承父标题标签


### title <span class="tag"><span class="work">work</span><span class="learn">learn</span></span> {#title}

-   C-c C-q 为标题添加标签
-   C-c / m 生成带标签的树


#### stitle <span class="tag"><span class="fly">fly</span><span class="plane">plane</span></span> {#stitle}


#### stitle2 <span class="tag"><span class="car">car</span><span class="run">run</span></span> {#stitle2}


## 时间 {#时间}

-   C-c . 插入时间

<span class="timestamp-wrapper"><span class="timestamp">&lt;2015-02-17 周二&gt;</span></span>
时间前可以加 DEADLINE:和 SCHEDULED:表示时间的类型
DEADLINE:<span class="timestamp-wrapper"><span class="timestamp">&lt;2015-02-12 周四&gt;</span></span>
一个常见的 TODO 标签：


### <span class="org-todo todo TODO">TODO</span>  {#d41d8c}

一些待办事项
SCHEDULED: <span class="timestamp-wrapper"><span class="timestamp">&lt;2015-02-19 周四&gt;</span></span>
DEADLINE: <span class="timestamp-wrapper"><span class="timestamp">&lt;2015-03-01 周日&gt;</span></span>


## 富文本导出 {#富文本导出}


### basic {#basic}

可以加一些说明符：

Everything should be made as simple as possible,
but not any simpler -- Albert Einstein
\#+END_QUOTE

<style>.org-center { margin-left: auto; margin-right: auto; text-align: center; }</style>

<div class="org-center">

Everything should be made as simple as possible, <br />
but not any simpler

</div>

```text
这里面的字符不会被转义
```


### 一些特殊格式： {#一些特殊格式}

**bold**
_italic_
<span class="underline">underlined</span>
`code`
`verbatim`
~~strike-through~~

注释的用法# this is comment

在导出后 LaTeX 能被正确解释

\begin{equation}
\nabla^2 x=\int\Omega \frac{a}{\log{a}h
} \sum^n\_{i=1} a\_i d\Omega
\end{equation}


### 插入源代码 {#插入源代码}

org mode 的源代码可以直接求出运行结果，需要在.emacsu 配置文件中设置加载的运行语言

-   C-c C-c 对当前代码块求值

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (R . t)
   (ruby . t)
   (ditaa . t)
   (dot . t)
   (octave . t)
   (sqlite . t)
   (perl . t)
   (C . t)
   ))

```emacs-lisp
(+ 1 2 3 4)
```

```python
a = 1+1
print a
```

S

```C++
int a=1;
int b=1;
printf("%d\n", a+b);
```


### css 文件 {#css-文件}


### 导出方式 {#导出方式}

-   C-c C-e 选择相应的导出格式


## footnote {#footnote}

在[^fn:1]中提到了脚注的用法，这个标签是可以点击的

[^fn:1]: 本文参考自<http://orgmode.org/orgguide.pdf>
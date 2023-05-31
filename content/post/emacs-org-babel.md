---
title: "Babel"
description: "Active Code in Org"
date: "2023-04-12 11:06:00"
lastmod: "2023-04-12 11:06:54"
categories: ["emacs"]
draft: false
---

## literate programming {#literate-programming}

Babel is Org's ability to execute source code within Org documents.

根据 Donald Knuth 的 定义，文学编程是一种把文档语言和编程语言组合在一起的方法（methodology）。org mode 原来是通过 org-babel 这一插件来实现文学编程的,自 7.0 版本以来， org mode 就已经内嵌了 Babel


##  {#d41d8c}


## example {#example}

<a id="code-snippet--shell"></a>
```bash
echo "daotoyi good."
```

<div class="src-block-caption">
  <span class="src-block-number"><a href="#code-snippet--shell">Code Snippet 1</a></span>:
  +
</div>

---

<a id="code-snippet--print value"></a>
```python
print(1+1)
```

<div class="src-block-caption">
  <span class="src-block-number"><a href="#code-snippet--print value">Code Snippet 2</a></span>:
  print value
</div>

---

<a id="code-snippet--print-value"></a>
```python
print(1+1)
```

<div class="src-block-caption">
  <span class="src-block-number"><a href="#code-snippet--print-value">Code Snippet 3</a></span>:
  print-value
</div>


## ref {#ref}

-   [Babel: Active Code in Org](https://orgmode.org/worg/org-contrib/babel/index.html)
-   [Working with Source Code](https://orgmode.org/manual/Working-with-Source-Code.html)
-   [Exporting Code Blocks](https://orgmode.org/manual/Exporting-Code-Blocks.html)
-   [如何在 Emacs 进行文学编程](https://emacstalk.codeberg.page/post/030/)
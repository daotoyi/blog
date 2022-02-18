+++
title = "Export PDF"
lastmod = 2022-02-15T07:04:36+08:00
categories = ["Org"]
draft = false
+++

## LATEX_HEADER {#latex-header}

```org
#+LATEX_HEADER: documentclass{article}
#+LATEX_CLASS_OPTIONS: [a4paper]
#+LATEX_HEADER: usepackage{xeCJK}
#+LATEX_HEADER: usepackage{minted}
#+LATEX_HEADER: usepackage[margin=2cm]{geometry}
#+LATEX_HEADER: setminted{fontsize=small,baselinestretch=1}
```


## 防止页面溢出 {#防止页面溢出}

```org
  #+ATTR_LATEX: :environment longtable :align l|lp{3cm}r|l
| ..... | ..... |
| ..... | ..... |
```
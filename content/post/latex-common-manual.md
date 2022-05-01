---
title: "Latex Config"
date: "2022-02-19 12:43:00"
lastmod: "2022-04-30 12:45:15"
categories: ["Latex"]
draft: false
---

## latex_introduction {#latex-introduction}

```org
#+begin_src latex
  \documentclass[oneside]{article}%

  \usepackage{ctex}
  \usepackage{geometry}
  \usepackage[dvipsnames, svgnames, x11names]{xcolor}
  \usepackage{graphics}
  \usepackage[
    colorlinks=true,
    linkcolor=Navy,
    urlcolor=Navy,
    citecolor=Navy,
    anchorcolor=Navy
  ]{hyperref}
  \usepackage{enumerate}
  \usepackage{tcolorbox}
  \tcbuselibrary{skins, breakable}
  \usepackage[english]{babel}
  \usepackage[cache=false]{minted}

  \geometry{
    width = 210mm,%
    height = 297mm,
    left = 19.1mm,%
    right = 19.1mm,%
    top = 25.4mm,%
    bottom = 25.4mm%
  }

  \hyphenpenalty = 1000
  \setmainfont{Ubuntu Mono}
  \setlength{\parindent}{2em}
  \setlength{\parskip}{2ex}
  \setcounter{secnumdepth}{3}
```


## template {#template}

```org
#+begin_src latex
  % \usepackage{lipsum} % random section

  \documentclass{article}

  % --- %

  \usepackage[UTF8]{ctex}
  \usepackage[colorlinks,
    linkcolor=black,
    anchorcolor=blue,
    citecolor=green
        urlcolor=bule
        breaklink=true]{hyperref}

  %\author{daoyi}
  \author{\HL[green]{whshi@techyauld.com}}

  %\date{\today}
  \date{\HL[red]{\today}}

  \usepackage{tcolorbox}
  \newtcbox{\HL}[1][red]
    {on line, arc = 0pt, outer arc = 0pt,
      colback = #1!10!white, colframe = #1!50!black,
      boxsep = 0pt, left = 1pt, right = 1pt, top = 2pt, bottom = 2pt,
      boxrule = 0pt}

  \usepackage{xcolor}
  \usepackage{framed}
  \colorlet{shadecolor}{blue!20}

  % \begin{shaded}
  % \lipsum[2-7]
  % \end{shaded}
  % \HL[green]{"contex"}

  \begin{document}

  \maketitle
  \tableofcontents
  \newpage

  % --- %
  ...

  \end{document}
```


## framed {#framed}

```org
#+begin_src latex
  % https://www.latexstudio.net/archives/574.html

  \documentclass{article}
  \usepackage{xcolor}
  \usepackage{framed}
  \usepackage{lipsum}
  \colorlet{shadecolor}{blue!20}

  \begin{document}
  \lipsum[4]
  \begin{shaded}
  \lipsum[2]
  \end{shaded}
  \lipsum[4]
  \end{document}

  \end{document}
```


## tcolorbox {#tcolorbox}

```org
#+begin_src latex
  \documentclass{article}
  \usepackage{tcolorbox 	%
  \begin{document}

  \newtcbox{\mybox}[1][red]
    {on line, arc = 0pt, outer arc = 0pt,
      colback = #1!10!white, colframe = #1!50!black,
      boxsep = 0pt, left = 1pt, right = 1pt, top = 2pt, bottom = 2pt,
      boxrule = 0pt, bottomrule = 1pt, toprule = 1pt}

  The \mybox[green]{quick} brown \mybox{fox}
  \mybox[blue]{jumps} over the \mybox[green]{lazy} \mybox{dog}.

  \end{document}

  %  toprule = 1pt  		%
  %  bottomrule = 1pt		%
```


## listings {#listings}

```org
#+begin_src latex
  \usepackage[colorlinks,linkcolor=black,anchorcolor=blue,citecolor=green]{hyperref}
  \usepackage[UTF8]{ctex}
  \author{daoyi}
  \date{\today}

  % \usepackage{listings}
  % \usepackage{xcolor}
  % \lstset{delim = [s][\ttfamily\color{red}]{$}{$}}

  \begin{document}

  \maketitle
  \tableofcontents

  \newpage

  % \begin{lstlisting}
  % $
  %
  % $
  % \end{lstlisting}

  \end{document}
```


## Link with color {#link-with-color}

```nil
#+begin_src org
%\usepackage[colorlinks,linkcolor=red,anchorcolor=blue,citecolor=green,CJKbookmarks=True]{hyperref}
\usepackage[colorlinks,linkcolor=black,anchorcolor=blue,citecolor=green]{hyperref}
```

-   colorlinks
    “colorlinks”的意思是将超链接以颜色来标识，而并非使用默认的方框来标识。
-   linkcolor, anchorcolor, citecolor
    linkcolor, anchorcolor, citecolor 分别表示用来标识 link, anchor, cite 等各种链接的颜色。
-   CJKbookmarks
    CJKbookmarks 让链接支持中文，不然会出现 Package hyperref Warning: old toc file detected, not used; run LaTeX again.的错误。

若正式的文档中不想使用彩色的标识，但又希望具有超链接的功能，则将上例中的各种颜色换成“black”即可。


## Contents {#contents}

```org
#+begin_src latex
\setcounter{tocdepth}{3}
\setcounter{secnumdepth}{4}
```

count:

-   -1 part
-   0 chapter
-   1 section
-   2 subsection
-   3 subsubsection
-   4 paragraph
-   5 subparagraph


### ChineseShow {#chineseshow}

${ \documentclass[UTF8]{ctexart} } or ${ \usepackage{ctex} }


#### CTEX {#ctex}

```org
#+begin_src latex
\documentclass[UTF8]{article}
\usepackage{CTEX}
  # or # \documentclass[UTF8]{ctexart}

\begin{document}
...
\end{document}
```


#### Org to pdf(Chinese) {#org-to-pdf--chinese}

-   included in org-files

    ```org
    #+LATEX_HEADER: \usepackage[UTF8]{ctex}
    #+LATEX_CMD: xelatex
    (setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f")
    ```


## other {#other}

(Chinese)org file header:

```org
#+LATEX_HEADER: \usepackage[UTF8]{ctex}
#+LATEX_CMD: xelatex
```

(Chinese path&amp;&amp;filename)

```org
#+begin_src latex
\usepackage{tcolorbox}
\newtcbox{\HL}[1][red]
  {on line, arc = 0pt, outer arc = 0pt,
    colback = #1!10!white, colframe = #1!50!black,
    boxsep = 0pt, left = 1pt, right = 1pt, top = 2pt, bottom = 2pt,
    boxrule = 0pt}
```
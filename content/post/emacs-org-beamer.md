---
title: "Beamer"
date: "2022-09-14 16:50:00"
lastmod: "2022-10-07 18:03:44"
categories: ["emacs"]
draft: false
---

## ref {#ref}

-   [Writing Beamer presentations in org-mode](https://orgmode.org/worg/exporters/beamer/tutorial.html)
-   [Beamer Export](https://orgmode.org/manual/Beamer-Export.html)
-   [Frames and Blocks in Beamer](https://orgmode.org/manual/Frames-and-Blocks-in-Beamer.html)
-   [Beamer specific syntax](https://orgmode.org/manual/Beamer-specific-syntax.html)
-   [Org Beamer reference card](https://github.com/fniessen/refcard-org-beamer)


## archive {#archive}

###  LaTeX-beamer 学习教程
  https://www.jianshu.com/p/7eba149baef7

  1.  [Beamer 快速入门 - 中译本 黄旭华老师翻译](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.latexstudio.net%2Farchives%2F51706.html)
  2.  [Beamer 3.0 指南 中译本 - 黄旭华老师翻译](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.latexstudio.net%2Farchives%2F51704.html)
  3.  [Beamer用户手册(V3.24)中译版](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.latexstudio.net%2Farchives%2F9457.html)
  4.  [Beamer用户手册英文版](https://links.jianshu.com/go?to=https%3A%2F%2Fmirror.bjtu.edu.cn%2Fctan%2Fmacros%2Flatex%2Fcontrib%2Fbeamer%2Fdoc%2Fbeameruserguide.pdf)
  5.  [使用 Beamer 制作学术讲稿](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.latexstudio.net%2Farchives%2F2825.html)
  6.  [Beamer v3.0 Guide](https://links.jianshu.com/go?to=http%3A%2F%2Fstatic.latexstudio.net%2Fwp-content%2Fuploads%2F2014%2F12%2Fbeamer_guide.pdf)
  7.  [A Beamer Tutorial in Beamer](https://links.jianshu.com/go?to=http%3A%2F%2Fstatic.latexstudio.net%2Fwp-content%2Fuploads%2F2014%2F12%2FCharles-Batts-Beamer-Tutorial.pdf)
  8.  [beamer 主题和颜色大全](https://links.jianshu.com/go?to=https%3A%2F%2Fmpetroff.net%2Ffiles%2Fbeamer-theme-matrix%2F)，[Beamer theme gallery](https://links.jianshu.com/go?to=http%3A%2F%2Fdeic.uab.es%2F%7Eiblanes%2Fbeamer_gallery%2Findex.html)
  9.  [用Beamer制作幻灯片（卷一 基本架构篇）](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fchichoxian%2Farticle%2Fdetails%2F18922839)
  10.  [用Beamer制作幻灯片（卷二 色彩篇）](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fchichoxian%2Farticle%2Fdetails%2F19113649%3Fdepth_1-utm_source%3Ddistribute.pc_relevant.none-task%26utm_source%3Ddistribute.pc_relevant.none-task)
  11.  [用Beamer制作幻灯片（卷三 动画篇）](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fchichoxian%2Farticle%2Fdetails%2F19134695%3Fdepth_1-utm_source%3Ddistribute.pc_relevant.none-task%26utm_source%3Ddistribute.pc_relevant.none-task)
  12.  [beamer帮助文档](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.overleaf.com%2Flearn%2Flatex%2FBeamer)
  13.  [Beamer学习笔记（1）——Beamer常见设置汇总](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fmagiccaptain%2Farticle%2Fdetails%2F6845749)


## theme {#theme}

default、AnnArbor、Antibes、Bergen、Berkeley、Berlin、Boadilla、CambridgeUS、Copenhagen、Darmstadt、Dresden、Frankfurt、Goettingen、Hannover、Ilmenau、JuanLesPins、Luebeck、Madrid、Malmoe、Marburg、Montpellier、PaloAlto、Pittsburgh、Singapore、Szeged、Warsaw

主题效果：<https://mpetroff.net/files/beamer-theme-matrix/>

beamer 的主题是由不同的内部主题（inner theme）、外部主题（outer theme）、色彩主题（color）、字体主题（font theme）等组合而成。分别使用\useinnertheme、\useoutertheme、\usecolortheme、\usefonttheme 选择。

-   inner theme
    -   内部主题主要控制的是标题页，列表项目、定理环境、图表环境、脚注在一帧内的内容格式。
    -   预定义的内部主题格式有 default、circles、rectangles、rounded、inmargin 等
-   outer theme
    -   外部主题主要控制的是幻灯片顶部尾部的信息栏、边栏、图标、帧标题等一帧之外的格式。
    -   预定义的外部主题有 default、infolines、miniframes、smoothbars、sidebar、split、shadow、tree、smoothtree 等。
-   color
    -   色彩主题控制各个部分的色彩。
    -   预定义的色彩主题包括 default、albatross、beaver、beetle、crane、dolphine、dove、fly、lily、orchid、rose、seagull、seahorse、sidebartab、structure、whale、wolverine 等。
-   font theme
    -   字体主题则控制幻灯片的整体字体风格。
    -   预定义的 beamer 字体主要包括 default、professionalfonts、serif、structurebold、structureitalicserif、structuresmallcapsserif 等。
        -   默认字体主题 default 的效果是整个幻灯片使用无衬线字体，这是多数幻灯片的选择；s
        -   erif 主题则是衬线字体，不过此时最好使用较大的字号和较粗的字体；
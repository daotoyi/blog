---
title: "Emacs 设置选中区域的颜色"
date: "2023-10-06 19:37:00"
lastmod: "2023-10-06 19:38:04"
categories: ["emacs"]
draft: false
---

emacs 行显示和选中区域的颜色均是灰色，比较难区分，如下修改方式可用。

操作步骤

-   M-x customize-face &lt;回车&gt;
-   Customize-face （default ‘all face’） &lt;Tab 补全&gt;
-   region

如下图：

{{< figure src="https://img-blog.csdnimg.cn/img_convert/9e8fb53b70b51fe1378ad6b37dca6f2e.png" >}}

-   \\[ Choose \\]
    &lt;选择中意的颜色&gt;
-   \\[ Apply and Save \\]

参考 [emacs 当前行高亮颜色以及选中区域颜色设置怎么设置](https://emacs-china.org/t/topic/4731/9)
---
title: "ImagesMagick"
date: "2022-03-17 19:30:00"
lastmod: "2022-04-30 12:47:58"
categories: ["Tools"]
draft: false
---

## ImageMagick 轻松转换 PDF 和图片 {#imagemagick-轻松转换-pdf-和图片}

将当前文件夹下所有 JPG 图片合并为一个 PDF 文档：

`convert *.jpg 1.pdf`

将当前文件夹下指定的图片合并为一个 PDF 文档：

`conert 01.jpg 02.png 1.pdf`

PDF 分解为图片:

`convert 1.pdf 11.jpg`

让分解输出的图片质量更好

-   density：设定 DPI
-   trim：修剪边缘
-   quality：设定输出图片质量

`convert -density 300 -trim 1.pdf -quality 95 11.jpg`


## 修改权限 {#修改权限}

`ImageMagick-xxx/policy.xml`

将 PDF 那一行权限中的 none 修改为 read|write，同时在该行下面增加一行：

`<policy domain="coder" rights="read|write" pattern="LABEL" />`
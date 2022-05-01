---
title: "Markdown"
date: "2022-03-19 11:04:00"
lastmod: "2022-04-30 12:48:28"
tags: ["markdown"]
categories: ["Tools"]
draft: false
---

## 图片排列 {#图片排列}


### 普通左右排列 {#普通左右排列}

要一张图片接着一张图片的写，中间不能有换行。如果换行的话则图片也换行 ，例如：

```markdown
![描述](图片链接)![描述](图片链接)![描述](图片链接)
```


### 居中并排 {#居中并排}

注意两个&lt;img&gt;之间不要换行，如果图片太大的的话可以设置图片的宽度或者高度，这样图片就会缩放。注意不要同时设置宽度和高度，这样的话不好把握宽度和高度的比例，可能会是图像变形。

```html
<center class="half">
    <img src="图片链接" width="200"/><img src="图片链接" width="200"/><img src="图片链接" width="200"/>
</center>
```


### 左对齐并排 {#左对齐并排}

注意所有的&lt;img&gt;标签写在一行中不要换行。

```markdown
<figure class="third">
    <img src="link1" width="200"/><img src="link2" width="200"/><img src="link3" width="200"/>
</figure>
```
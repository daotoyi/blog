+++
title = "org-download+screenshot 使用总结"
date = 2022-02-18T11:22:00+08:00
tags = ["screenshot"]
categories = ["emacs"]
draft = false
+++

## org-download {#org-download}

org-download 使用的 ImageMagick 工具无法在 winodw 上截屏（import）。


### 使用 {#使用}

-   org-download-yank 直接粘贴 URL 地址
-   手动拖动本地图片到 emacs 中.
    -   `首次拖入emacs前需要触发org-download,` 否则会直接打开查看图片,而不是嵌入 emacs 中
    -   org-download-yank or org-download-clipboard 触发


### 曲线解决截图插入问题 {#曲线解决截图插入问题}

[emadcs在windows插入截图](https://www.cnblogs.com/yangwen0228/p/6287455.html)


## org-attach-screenshot {#org-attach-screenshot}

配合 ImageMagick 可以方便插入图片,但是在 winodw 上 import 无法截图, 但会生成插入链接,可以手动截图保存在相应位置.


## note {#note}

-   org-download 用来拖入图片
-   org-attach-screenshot 手动配合截图
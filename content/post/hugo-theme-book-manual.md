---
title: "Hugo 主题 book 使用小结"
date: "2022-03-09 00:07:00"
lastmod: "2022-04-30 12:50:09"
tags: ["Hugo"]
categories: ["VPS"]
draft: false
---

## Menu {#menu}

-   Render pages from the content/docs section as a menu in a tree structure.
-   set title and weight in the front matter of pages to adjust the order and titles in the menu.

`/menu` deprated.


## Blog {#blog}

A simple blog is supported in the section `posts`.

保证 content 目录下只有一个 posts 目录。


## Plugins {#plugins}

-   numbered
-   scrollbars
-   `themes/hugo-book/assets/_custom.scss`

<!--listend-->

```scss
/* You can add custom styles here. */

@import "plugins/numbered";
@import "plugins/scrollbars";
```

-   `themes/hugo-book/assets/plugins/_numbered.scss`

<!--listend-->

```scss
$startLevel: 2;
$endLevel: 6;
```

调整文档结构的编码。

`startLevel` default 1, title level in markdown files ox-hugo generaged not math title level in org-mode files.  set `startLevel: 2` make website show friendly.


## config {#config}

```toml
baseURL = 'https://fire.daotoyi.cn/'
```

Add domain in CNAME file, or it will can't open target file on website.
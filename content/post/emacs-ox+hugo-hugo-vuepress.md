---
title: "ox-hugo 生成 hugo/vuepress 通用 md 文件"
date: "2022-04-30 12:23:00"
lastmod: "2022-04-30 12:24:10"
categories: ["emacs"]
draft: false
---

vuepress 使用的是 vdoing 主题：

-   只支持 yaml 格式的 frontmatter
-   时间格式要求 YYYY-mm-dd HH:MM:SS


## yaml {#yaml}

```org
#+HUGO_BASE_DIR : ../Blog/
#+HUGO_FRONT_MATTER_FORMAT: yaml
#+HUGO_AUTO_SET_LASTMOD: t
#+HUGO_SECTION: post
#+SEQ_TODO: TODO DRAFT DONE
#+PROPERTY: header-args :eval no
#+FILETAGS: :@emacs:
```


## date formate {#date-formate}

`C-h v org-hugo-date-format`,
在弹出的 emacs buffer 上点击 **customize**, 直接修改 **Org Hugo Date Format** 为 `%Y-%m-%d %T`, 默认值是 `%Y-%m-%dT%T%z` (2017-07-31T17:05:38-04:00).

光标移到 `Apply and Save` 按钮上回车确认。


## Ref {#ref}

-   [ox-hugo.Dates](https://ox-hugo.scripter.co/doc/dates/)
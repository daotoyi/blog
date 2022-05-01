---
title: "Org ox-hugo"
date: "2022-04-30 09:35:00"
lastmod: "2022-04-30 12:24:10"
tags: ["ox", "hugo", "org"]
categories: ["emacs"]
draft: false
---

## File meta {#file-meta}

```org
#+HUGO_BASE_DIR : ../Blog/
#+HUGO_FRONT_MATTER_FORMAT: yaml
#+HUGO_AUTO_SET_LASTMOD: t
#+HUGO_SECTION: post
#+SEQ_TODO: TODO DRAFT DONE
#+PROPERTY: header-args :eval no
#+FILETAGS: :@emacs:
```


## Subtree/files meta {#subtree-files-meta}

```org
:PROPERTIES:
:EXPORT_FILE_NAME: emacs-org-ox+hugo-meta
:EXPORT_DESCRIPTION:
:EXPORT_HUGO_CUSTOM_FRONT_MATTER: :motto Refine
:END:
```


## preview {#preview}


### hugo server {#hugo-server}

hugo server 是 hugo 常用的命令,只要启动了站点服务,就可以实时预览 md 的变更.


### dir-locals.el {#dir-locals-dot-el}

ox-hugo 是基于 实时预览,为 emacs 用户提供了一个强大的 自动导出 md 的功能.即:当每次编写完成保存 org 文件时,会根据 Export 相关属性,自动导出 md 文件到 hugo 站点,从而实现在 hugo 实时预览 md 效果.


### useage {#useage}


#### current directory {#current-directory}

当仅想在一个文件中自动保存,可以在 org 文件底部添加如下

```org
* Footnotes
* COMMENT Local Variables                                           :ARCHIVE:
# Local Variables:
# eval: (org-hugo-auto-export-mode)
# End:
```


#### all directory {#all-directory}

-   作用所有目录
    在 your/org 目录下新建  `.dir-locals.el`,

<!--listend-->

```org
((org-mode . ((eval . (org-hugo-auto-export-mode)))))
```

-   屏蔽该目录下 org 自动保存

<!--listend-->

```org
​* Footnotes
​* COMMENT Local Variables                          :ARCHIVE:
  # Local Variables:
  # eval: (org-hugo-auto-export-mode -1)
  # End:
```


## Ref {#ref}

-   [Auto-export on Saving](https://ox-hugo.scripter.co/doc/auto-export-on-saving/)
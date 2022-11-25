---
title: "package location"
date: "2022-11-25 22:56:00"
lastmod: "2022-11-25 23:08:02"
categories: ["emacs"]
draft: false
---

## local package {#local-package}

```lisp
;; 自定义 package 安装地址
(defconst zilongshanren-packages
  '(youdao-dictionary							；'
    (occur-mode :location built-in)
    )
  )
;; 初始化 occur mode
(defun zilongshanren/init-occur-mode ()
  (evilified-state-evilify-map occur-mode-map
    :mode occur-mmode)
  )
```


## github {#github}

```lisp
;; 自定义 package 安装地址
(defconst zilongshanren-packages
  '(youdao-dictionary							;'
    (occur-mode :location built-in)
    (gulpjs :location (recipe :fetcher github :repo "zilongshanren/emacs-gulpjs"))
    )
  )

(defun zilongshanren/init-gulpjs ()
  (use-package gulpjs
    :init)
  )
```
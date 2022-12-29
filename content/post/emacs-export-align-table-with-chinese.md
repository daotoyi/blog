---
title: "Org Table 中文表格对齐"
date: "2022-03-11 17:46:00"
lastmod: "2022-12-23 20:38:46"
tags: ["org"]
categories: ["emacs"]
draft: false
---

## 方法 1[中文表格对齐](https://www.dazhuanlan.com/zhanggezhi/topics/1701345) {#方法-1-中文表格对齐}

```emacs-lisp
;; -----------------------------------------------------------------------------
;; setting font for mac system
;; -----------------------------------------------------------------------------
;; Setting English Font
(defun s-font()
  (interactive)
  ;; font config for org table showing.
  (set-face-attribute
   'default nil :font "Monaco 12")
;; Chinese Font 配制中文字体
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font)
           charset
            (font-spec :family "Microsoft YaHei" :size 14))))
;; tune rescale so that Chinese character width = 2 * English character width
;;(setq face-font-rescale-alist '(("Monaco" . 1.0) ("Microsoft YaHei" . 1.23)))
(add-to-list 'after-make-frame-functions
      (lambda (new-frame)
         (select-frame new-frame)
          (if window-system
        (s-font))))
(if window-system
    (s-font))
```
---
title: "use-package"
date: "2022-11-25 22:42:00"
lastmod: "2022-11-25 22:50:35"
categories: ["emacs"]
draft: false
---

```lisp
;; 最简洁的格式
 (use-package restart-emacs)

;; 常用的格式
 (use-package smooth-scrolling
    :ensure t ;是否一定要确保已安装
    :defer nil ;是否要延迟加载
    :init (setq smooth-scrolling-margin 2) 	;初始化参数  ，init 后的代码在包的 require 之前执行
    :config (smooth-scrolling-mode t) 		;基本配置参数，config 后的代码在包的 require 之后执行
    :bind (("M-s O" . moccur)				;快捷键的绑定
         ("M-o" . isearch-moccur))
    :hook) 									;hook 模式的绑定

;; (eval-and-compile
    (setq use-package-always-ensure t) 		;不用每个包都手动添加:ensure t 关键字
    (setq use-package-always-defer t) 		;默认都是延迟加载，不用每个包都手动添加:defer t
    (setq use-package-always-demand nil)
    (setq use-package-expand-minimally t)
    (setq use-package-verbose t)

;; 使用(use-package package-name) 可以避免:当 package-name 不在 load-path 中时,(require 'package-name)会抛出错误
;; init 与 config 之后只能接单个表达式语句, 如果需要执行多个语句, 可以用 progn

;; 使用 autoload 则可以在真正需要这个包时再 require, 提高启动速度, 避免无谓的 require.
(use-package package-name
  :commands
  (global-company-mode)
  :defer t
  )
;; 使用 commands 可以让 package 延迟加载, 如以上代码会首先判断 package 的符号是否 存在,
;; 如果存在则在 package-name 的路径下加载. defer 也可以让 package-name 进行延迟加载.
```
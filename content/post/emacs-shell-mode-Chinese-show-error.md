---
title: "Emacs Shell-mode 中文显示乱码"
date: "2023-10-06 19:23:00"
lastmod: "2023-10-06 19:23:28"
categories: ["emacs"]
draft: false
---

### [Emacs](https://so.csdn.net/so/search?q=Emacs&spm=1001.2101.3001.7020) shell-mode中文显示乱码

> M-x shell
> [ssh](https://so.csdn.net/so/search?q=ssh&spm=1001.2101.3001.7020) root@192.168.220.136
> Pseudo-terminal will not be allocated because [stdin](https://so.csdn.net/so/search?q=stdin&spm=1001.2101.3001.7020) is not a terminal. δ 쳣: System.TypeInitializationException: Microsoft.Alm.Cli.Program ͳ ʼֵ 趨 쳣 —> System.IO.FileNotFoundException: δ ܼ ļ 򼯡 AzureDevOps.Authentication, Version=1.1.0.0, Culture=neutral, PublicKeyToken=null ĳһ ϵͳ Ҳ ָ ļ
> Microsoft.Alm.Cli.Program…cctor()
> — ڲ 쳣 ջ ٵĽ β —

### 定义shell-mode下的函数

``` lisp
;; Shell Mode(Show Chinese)
(setq ansi-color-for-comint-mode t)
(defun change-shell-mode-coding ()
  (progn
    (set-terminal-coding-system 'gbk)
    (set-keyboard-coding-system 'gbk)
    (set-selection-coding-system 'gbk)
    (set-buffer-file-coding-system 'gbk)
    (set-file-name-coding-system 'gbk)
    (modify-coding-system-alist 'process "*" 'gbk)
    (set-buffer-process-coding-system 'gbk 'gbk)
    (set-file-name-coding-system 'gbk)))
```

### 运行函数

把上面函数加入到 shell-mode-hook中后，就可以在每次打开 Shell buffer 的时候自动配置shell-mode 的编码了。

``` lisp
(add-hook 'shell-mode-hook 'change-shell-mode-coding t)
```

### NOTE

**以上内容均写在.emacs中即可。**
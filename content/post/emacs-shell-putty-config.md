---
title: "Emacs Shell(putty) config"
date: "2023-10-06 19:25:00"
lastmod: "2023-10-06 19:25:03"
categories: ["emacs"]
draft: false
---

### [Emacs](https://so.csdn.net/so/search?q=Emacs&spm=1001.2101.3001.7020) Config

> init.el — EmacsEntrance
> ;; (setq explicit-shell-file-name “plink”)
> ;; (setq shell-file-name explicit-shell-file-name)
> (add-to-list 'exec-path “path/to/[PuTTY](https://so.csdn.net/so/search?q=PuTTY&spm=1001.2101.3001.7020)”)
> 或者
> (setenv “PATH” (concat “/mingw64/bin:/usr/local/bin:/usr/bin:/bin:/mingw64/bin:/opt/bin:/:/usr/bin/site\_perl:/usr/bin/vendor\_perl:/usr/bin/core\_perl:path/to/PuTTY”
> (getenv “PATH”)))

在其他的console（如msys或者cmd）中，使用`plink root@192.168.0.1`登陆。

### Emacs exec

> M-x
> shell
> plink root@192.168.0.1
> [buffer](https://so.csdn.net/so/search?q=buffer&spm=1001.2101.3001.7020) : plink.exe Password:xxx

### Save buffer

> C-x C-s
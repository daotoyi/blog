---
title: "Org <TAB>键无法展开视图"
date: "2023-10-06 19:06:00"
lastmod: "2023-10-06 19:06:19"
categories: ["emacs"]
draft: false
---

### 说明

-   Linux系统，Emacs的org-mode使用evil插件时，`<TAB>`键无法展开视图。
-   Windows下正常。

### 解决

在emac加载evil插件时，配置中相应位置前后添加以下内容：
`~/.emacs`:

``` emacs-lisp
(setq evil-want-C-i-jump nil)

(require 'evil)

(when evil-want-C-i-jump
  (define-key evil-motion-state-map (kbd "C-i") 'evil-jump-forward))
```

-   Reference:
    [Emacs, org-mode, evil-mode - TAB key-TAB键不起作用](https://cloud.tencent.com/developer/ask/49797)
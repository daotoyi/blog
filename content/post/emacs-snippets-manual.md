+++
title = "snippets 使用总结"
date = 2022-02-06T08:21:00+08:00
lastmod = 2022-02-12T10:44:37+08:00
categories = ["emacs"]
draft = false
+++

## 常用指令 {#常用指令}

| hotkey        | M-x （function）       | note |
|---------------|----------------------|------|
| C-c &amp; C-n | yas-new-snippet        |      |
| C-c &amp; C-s | yas-insert-snippet     |      |
| C-c &amp; C-v | yas-visit-snippet-file |      |
|               | yas-tryout-snippet     | test |

-   可以保存到两个地方：
    -   ~/.emacs.d/private/snippets/modename-mode/
    -   ~/.spacemacs.d/snippets/modename-mode/


## 模板说明 {#模板说明}

```C
#name : #ifndef XXX; #define XXX; #endif
# key: once
# --
#ifndef ${1:`(upcase (file-name-nondirectory (file-name-sans-extension (or (buffer-file-name) ""))))`_H}
#define $1

$0

#endif /* $1 */
```

-   $0
    代码片段中的 $0 表示代码片段填充之后光标最后停的地方，$1 $2 $3... 表示按 TAB 之后光标停的地方。

-   `M-/` 触发
    spacemacs 的 TAB 按键被自动补全使用了，可以使用了 M-/ 来触发。


## auto-completion 整合 {#auto-completion-整合}

```emacs-lisp
(setq-default dotspacemacs-configuration-layers
              '((auto-completion :variables
                                 auto-completion-enable-snippets-in-popup t)))
```
---
title: "macOS spacemacs 的 evil 模式 fcitx-remote 切换输入法"
author: ["SHI WENHUA"]
lastmod: "2024-04-01 23:10:05"
categories: ["Mac"]
draft: false
---

CLOSED: <span class="timestamp-wrapper"><span class="timestamp">[2024-03-28 Thu 00:41]</span></span>


## fcitx-for-osx {#fcitx-for-osx}

-   step1：

在 dotspacemacs-configuration-layers 中配置并启用 chinese，并启用 fcitx.el

```elisp
(chinese :variables
         chinese-enable-fcitx t)
```

-   setp2

在 dotspacemacs/user-config()

```elisp
;; Make sure the following comes before `(fcitx-aggressive-setup)’
(setq fcitx-active-evil-states '(insert emacs hybrid)) ; For Spacemacs use hybrid mode。 默认方式是 '(insert emacs)
(fcitx-aggressive-setup) ; 如果要在 minibuffer 里输入中文，就改成 （ fcitx-default-setup ）
(fcitx-prefix-keys-add “M-m”) ; M-m is common in Spacemacs
;; (setq fcitx-use-dbus t) ; uncomment if you’re using Linux
```

-   tep3

在 macOS 终端用 brew 安装 fcitx-remote-for-osx

```bash
brew tap xcodebuild/fcitx-remote-for-osx # 取消 tap 用brew untap xcodebuild/fcitx-remote-for-osx
# 显示当前有那些仓库可用
brew tap brew install xcodebuild/fcitx-remote-for-osx/fcitx-remote-for-osx --with-sogou-pinyin
# --with-sogou-pinyin 表示搜狗拼音
brew info xcodebuild/fcitx-remote-for-osx/fcitx-remote-for-osx
# 查看支持其他输入法的选项。
```

-   setp4

参考 GitHub - xcodebuild/fcitx-remote-for-osx: A simulate fcitx-remote to handle osx input method in command line 5 在 macOS 在输入法面板设置“选择下一个输入法的快捷键”为：Ctrl-Shift-z
\*\*


## swim {#swim}

```bash
git clone -b 0.2.0 https://github.com/mitsuse/swim.git && cd swim
swift build -c release
cp .build/release/swim ${YOUR_EXECUTABLE_PATH}

# 用法很简单:
# swim list 列出所有目前可以切换到的输入法。
$ swim list
com.apple.keyboardlayout.all
com.apple.inputmethod.SCIM
# swim list --name 会把显示名称一并显示出来
$ swim list --name
ABC (com.apple.keyboardlayout.all)
Pinyin - Simplified (com.apple.inputmethod.SCIM)
swim use input-method # 切换输入法
swim use com.apple.inputmethod.SCIM
```

只要在 emacs 里自定义一些函数和 hook 就可以自动切换输入法了：

```lisp
;; method0 是英文输入法，method1 是中文输入法
(setq input-switch-method0 "com.apple.keyboardlayout.all")
(setq input-switch-method1 "com.apple.inputmethod.SCIM")
(setq input-switch-is-on nil)

;; 通过运行命令切换输入法
(defun input-switch-use-method (method)
  (when input-switch-is-on
    (shell-command (replace-regexp-in-string "method" method "swim use method"))))

;; 开启或关闭输入法切换
(defun input-switch-enable () (interactive) (setq input-switch-is-on t))
(defun input-switch-disable () (interactive) (setq input-switch-is-on nil))

;; 进入 insert mode 切换第二输入法（中文）
(add-hook 'evil-insert-state-entry-hook
          (lambda () (input-switch-use-method input-switch-method1)))
;; 退出 insert mode 切换第一输入法（英文）
(add-hook 'evil-insert-state-exit-hook
          (lambda () (input-switch-use-method input-switch-method0)))
```

只要执行 M-x `input-switch-enable` 就可以开始愉快码字了。


## **Note** {#note}

-   github
    -   [xcodebuild/fcitx-remote-for-osx](https://github.com/xcodebuild/fcitx-remote-for-osx)
    -   [cute-jumper/fcitx.el](https://github.com/cute-jumper/fcitx.el/tree/master)
    -   [mitsuse/swim](https://github.com/mitsuse/swim)
-   emacs-china
    -   [evil 如何根据模式不同切换不同的输入法?](https://emacs-china.org/t/topic/3152)
    -   [https://emacs-china.org/t/macos-evil/4337](https://emacs-china.org/t/macos-evil/4337)

自 2019 年开始，brew 不再支持 `--with-squirrel-rim` or `--with-input-method=sogou-pinyin` 等方式。采用手动编译的方式可行。

```bash
# github manual
git clone https://github.com/xcodebuild/fcitx-remote-for-osx.git
cd fcitx-remote-for-osx
# use US (美式英语)
./build.py build all us

# or use ABC
#./build.py build all abc

# general method
cp ./fcitx-remote-general /usr/local/bin/fcitx-remote

# squirrel for example
# cp ./fcitx-remote-squirrel-rime-hans /usr/local/bin/fcitx-remote
ln -s /path/to/fcitx-remote-squirrel-rime-hans /usr/local/bin

# 可以在终端输入 =fcitx-remote -t=测试：
#$ fcitx-remote -t
#  2024-03-28 00:19:13.802 fcitx-remote[46214:3821223] Changing to com.apple.keylayout.ABC
```

-   spacemacser

<!--listend-->

```lisp
;; dotspacemacs-configuration-layers
     (chinese :variables
            chinese-enable-fcitx t)

;; (defun dotspacemacs/user-config ()

;; Make sure the following comes before `(fcitx-aggressive-setup)'
(setq fcitx-active-evil-states '(insert emacs hybrid)) ; if you use hybrid mode
(fcitx-aggressive-setup)
(fcitx-prefix-keys-add "M-m") ; M-m is common in Spacemacs
;; (setq fcitx-use-dbus t) ; uncomment if you're using Linux
```

-   输入法只保留 ABC 和 squirrel，从 insert 模式的中文退出时，会切到 ABC 模式，但再进入 Insert 模式时还是 ABC 输入法。

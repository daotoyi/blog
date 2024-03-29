---
title: "SpacemacsOperate"
date: "2022-11-25 23:05:00"
lastmod: "2023-10-14 10:23:23"
tags: ["spacemacs"]
categories: ["emacs"]
draft: false
---

## set-space {#set-space}

```lisp
dotspacemacs-default-font '("Inconsolata_NF"
                            :size 20
                            :weight normal
                            :width normal
                            :powerline-scale 1.1) ;'
```


## file {#file}

```lisp
SPC f f		#从当前目录开始查找文件. 在作者的配置中同时启用了 ivy-layer 和 helm-layer, 默认使用的是 helm 来查找文件.
SPC f L		#使用 helm-locate 来在当前系统中查找文件.
SPC f l		#查找文件并使用 literal 的方式来打开文件, 使用 literal 方式打开的文件不会附加编码信息, 例如 utf-8 编码中可能存在的 BOM 头信息, 使用 literal 模式即可以看到 BOM 头.
SPC f h		#查找文件并使用二进制的方式来打开文件, 可以使用 C-c C-c 回到之前的模式.
SPC f o		#使用外部程序打开文件.
SPC f E		#使用 sudo 来编辑文件, 当某些文件是只读的时候可以采用这种方式来编辑文件.
SPC f D		#删除当前的文件和 buffer.
SPC f j		#以当前文件的目录打开 dired buffer.
SPC f r		#使用 ivy 打开最近文件列表.
SPC f R		#重命名当前文件.
SPC f v		#添加 local variables, 可以通过这个功能给项目做一些特殊的设置. 例如按下 SPC f v, 然后选择 add-dir-local-variable, 选择 org-mode, 再选择 org-highlight-links 变量, 此时 emacs 会在当前文件的目录下生成一个 .dir-locals.el 文件, 内容如下:
;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")
((org-mode
  (org-highlight-links)))
# 这个文件中的代码会在当前目录下的所有文件 buffer 中生效.
SPC f y			#拷贝当前文件的全路径.
SPC f a d		#列出最近访问的目录, 使用命令行工具 fasd 实现.
SPC f C d/u		#将当前文件的编码转换为 DOS/UNIX 编码.
SPC f e d		#打开 .spacemacs 或 .spacemacs.d/init.el 文件.
SPC f e i		#打开 .emacs 或 .emacs.d/init.el 文件.
SPC f e l		#打开系统中已经安装的 el 文件.
SPC f c			#复制文件.
SPC f b			#打开标签.
SPC f s/S		#保存当前 buffer 或 所有 buffer
```


## buffer {#buffer}

```lisp
SPC b .		#打开 Buffer Selection Transient State, 在该模式下可以进行更多的操作, 由 hydra 提供.
SPC b b		#切换到已经打开的 buffer.
SPC b d		#关闭一个 buffer.
SPC b f		#在 finder 中打开当前文件, 只在 Mac 系统下生效.
SPC b B/i	#以类似 Dired Mode 的形式打开 buffer 列表, 在这个列表中可以执行和 Dired Mode 类似的操作.
SPC b h		#进入 \*spacemacs\* buffer.
SPC b k		#使用正则表达式来删除 buffer.
SPC b N		#新建一个 buffer.
SPC b m		#删除除当前 buffer 外的所有 buffer.
SPC b R		#使用 emacs 自动备份的文件恢复文件.
SPC b s		#跳转到 scratch buffer.
SPC b w		#关闭/打开 buffer 的 read-only.
SPC b Y		#复制整个 buffer 的内容.
SPC b P		#将剪切板的内容粘贴到整个 buffer.
SPC <tab>	#在当前 buffer 和上一个打开的 buffer 中进行切换
```


## layout {#layout}

```lisp
SPC l L		#加载 layout 文件
SPC l l		#在 layout 之间切换
SPC l s		#将 layout 保存到文件
SPC l <tab>		#在当前 layout 和上一个 layout 之间切换
SPC l o		#配置 layout
SPC l R		#重命名 layout
SPC l ?		#显示更多的与 layout 相关的命令
```


## window {#window}

```lisp
SPC w -		#上下拆分窗口
SPC w /		#左右拆分窗口
SPC w .		#示更多的与 window micro state 的相关的命令
SPC w 2/3	#左右显示 2/3 个窗口
SPC w =		#将窗口等分
SPC w b		#切换到 minibuffer
SPC w d		#删除当前窗口
SPC w h/j/k/l	#向 左/下/上/右 移动窗口
SPC w m			#最大化显示当前窗口
SPC W H/J/K/L	#将当前窗口向 左/下/上/右 移动
SPC w u/U		#取消/重置上次操作
SPC w o			#切换到其他 frame
SPC w F			#创建一个新的 frame
SPC w 1/2/3/4	#切换到对应的编号的窗口
SPC w w			#依次切换到其他窗口
SPC w W			#使用字母标识需要跳转的窗口, 并按下字母进行跳转
SPC t g			#将当前显示的窗口与其他窗口进行黄金分割显示
SPC t -			#开启/关闭 将光标始终显示在中心行
```


## multiple-cursor {#multiple-cursor}

-   cgn

<https://macplay.github.io/posts/vim-bu-xu-yao-duo-guang-biao-bian-ji-gong-neng/>

-   evil-mc
    g-r-xxx

<https://github.com/gabesoft/evil-mc>
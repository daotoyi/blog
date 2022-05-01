---
title: "Sublime Hotkey"
date: "2022-04-02 12:29:00"
lastmod: "2022-04-30 12:48:34"
tags: ["hotkey"]
categories: ["Tools"]
draft: false
---

## 通用（General） {#通用-general}

-   ↑↓←→：上下左右移动光标，注意不是不是 KJHL！
-   Alt：调出菜单
-   Ctrl + Shift + P：调出命令板（Command Palette）
-   Ctrl + \`：调出控制台


## 编辑（Editing） {#编辑-editing}

-   Ctrl + Enter：在当前行下面新增一行然后跳至该行
-   Ctrl + Shift + Enter：在当前行上面增加一行并跳至该行
-   Ctrl + ←/→：进行逐词移动
-   Ctrl + Shift + ←/→进行逐词选择
-   Ctrl + ↑/↓移动当前显示区域
-   Ctrl + Shift + ↑/↓移动当前行


## 选择（Selecting） {#选择-selecting}

-   Ctrl + D：选择当前光标所在的词并高亮该词所有出现的位置，再次 Ctrl + D 选择该词出现的下一个位置，在多重选词的过程中，使用 Ctrl + K 进行跳过，使用 Ctrl + U 进行回退，使用 Esc 退出多重编辑
-   Ctrl + Shift + L：将当前选中区域打散
-   Ctrl + J：把当前选中区域合并为一行
-   Ctrl + M：在起始括号和结尾括号间切换
-   Ctrl + Shift + M：快速选择括号间的内容
-   Ctrl + Shift + J：快速选择同缩进的内容
-   Ctrl + Shift + Space：快速选择当前作用域（Scope）的内容


## 查找&amp;替换（Finding&amp;Replacing） {#查找-and-替换-finding-and-replacing}

-   F3：跳至当前关键字下一个位置
-   Shift + F3：跳到当前关键字上一个位置
-   Alt + F3：选中当前关键字出现的所有位置 - **多光标编辑**
-   Ctrl + F/H：进行标准查找/替换，之后：
-   Alt + C：切换大小写敏感（Case-sensitive）模式
-   Alt + W：切换整字匹配（Whole matching）模式
-   Alt + R：切换正则匹配（Regex matching）模式
-   Ctrl + Shift + H：替换当前关键字
-   Ctrl + Alt + Enter：替换所有关键字匹配
-   Ctrl + Shift + F：多文件搜索&amp;替换


## **多光标** {#多光标}

-   Alt + F ： 全选当前词并进入多光标选择
-   Ctrl + Alt + 上或下 ： 以当前光标为中心上或下增加多光标点
-   Ctrl + 鼠标左键 ： 自由选择多光标位置
-   Shift + 鼠标右键上下拖动 或 按鼠标右键上下滑 ： 垂直方向的多光标使用


## 跳转（Jumping） {#跳转-jumping}

-   Ctrl + P：跳转到指定文件，输入文件名后可以：
-   @ 符号跳转：输入@symbol 跳转到 symbol 符号所在的位置
-   关键字跳转：输入#keyword 跳转到 keyword 所在的位置
-   : 行号跳转：输入:12 跳转到文件的第 12 行。
-   Ctrl + R：跳转到指定符号
-   Ctrl + G：跳转到指定行号


## 窗口（Window） {#窗口-window}

-   Ctrl + Shift + N：创建一个新窗口
-   Ctrl + N：在当前窗口创建一个新标签
-   Ctrl + W：关闭当前标签，当窗口内没有标签时会关闭该窗口
-   Ctrl + Shift + T：恢复刚刚关闭的标签


## 屏幕（Screen） {#屏幕-screen}

-   F11：切换普通全屏
-   Shift + F11：切换无干扰全屏
-   Alt + Shift + 2：进行左右分屏
-   Alt + Shift + 8：进行上下分屏
-   Alt + Shift + 5：进行上下左右分屏
-   分屏之后，使用 Ctrl + 数字键跳转到指定屏，使用 Ctrl + Shift + 数字键将当前屏移动到指定屏


## 折叠代码 {#折叠代码}

```cfg
Ctrl+Shift+[ 折叠代码
Ctrl+Shift+] 展开代码
Ctrl+KT 折叠属性
Ctrl+K0 展开所有
```


## keymap {#keymap}

Preferences -&gt; Key Bindings

```js
[
  { "keys": ["ctrl+shift+c"], "command": "cancel_build" },
    {
        "keys": ["f5"],
        "caption": "SublimeREPL: Python - RUN current file",
        "command": "run_existing_window_command",
        "args": {
            "id": "repl_python_run",
            "file": "config/Python/Main.sublime-menu"
        }
    }
]
```
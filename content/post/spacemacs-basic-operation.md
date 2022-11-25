---
title: "SpacemacsBasicOperate"
date: "2022-11-25 22:57:00"
lastmod: "2022-11-25 23:07:52"
categories: ["emacs"]
draft: false
---

```bash
# 1)Change the Theme in current buffer
    <leader>Ts

  对齐
SPC j = 自动对齐，相当于 beautify
快速翻页 (在 spacemacs 0.1xx 中没测试过)
SPC n , 或 . 或 < 或 > 进入 scrolling transient state 然后重复按 , 或 . 或 < 或 > 即可，
                        按其他键会退出 scrolling transient state , 向上翻一页 . 向下翻一页 < 向上翻半页 > 向下翻半页}
#  macro
qa 开始记录一个叫 a 的宏
q 停止记录
@a 运行宏，接下来如果要重复运行的话，可以用 . 来运行上一个命令}

# 2)CMD
配置文件管理
SPC f e d 快速打开配置文件 .spacemacs
SPC f e R 同步配置文件
SPC q R 重启 emacs

# 3)帮助文档
SPC h d   查看 describe 相关的文档
SPC h d f 查看指定函数的帮助文档
SPC h d b 查看指定快捷键绑定了什么命令
SPC h d v 查看指定变量的帮助文档

# 4)注释  #命令以 c 开头
SPC c l 注释行
SPC c p 注释一段

# 5)emacs 标准键
C-c C-k 关闭文件
[e 将选中行向上移
]e 将选中行向下移

# 6)文件管理
SPC f f 打开文件（夹），相当于 $ open xxx 或 $ cd /path/to/project
SPC / 用合适的搜索工具搜索内容，相当于 $ grep/ack/ag/pt xxx 或 ST / Atom 中的 Ctrl + Shift + f
SPC s c 清除搜索高亮
SPC f R 重命名当前文件
SPC f y 显示当前文件路径并复制

# 7)Buffer
SPC b d 关闭当前 buffer (spacemacs 0.1xx 以后)
SPC SPC 搜索当前文件

# 8)窗口管理
SPC f t 或 SPC p t 用 NeoTree 打开/关闭侧边栏，相当于 ST / Atom 中的 Ctrl(cmd) + k + b
SPC f t 打开当前文件所在的目录
SPC p t 打开当前文件所在的根目录
SPC N 快速切换窗口。在 Spacemacs 中的每个窗口，都可以在窗口左下角看到窗口的编号，通过 SPC N 可以快速的根据编号切换窗口
    SPC 0 光标跳转到侧边栏（NeoTree）中 SPC n(数字) 光标跳转到第 n 个 buffer 中

SPC w s 或 SPC w h 或 SPC w - 水平分割窗口
SPC w v 或 SPC w / 垂直分割窗口
SPC w d 关闭当前窗口 (spacemacs 0.1xx 以后)
SPC w U/J/H/K 将当前窗口移至最左/上/下/右
SPC w w 切换窗口
SPC w = 让窗口长宽协调

Ctl+w j 移动光标到下边的窗口
Ctl+w k 移动光标到上边的窗口
Ctl+w h 移动光标到左边的窗口
Ctl+w l 移动光标到右边的窗口


# 9)项目管理
SPC p f 打开/查找文件
SPC p ' 打开命令行  #'
SPC p $t 在根目录打开命令行
SPC p h 最近编辑文件
SPC p t 打开文件树
SPC p b 当前 project 中查找打开的 buffer
SPC p l 切换到其他的 project 并创建一个新的 layout
SPC p p/l 切换项目
SPC p D 在 dired 中打开项目根目录
SPC p f 在项目中搜索文件名，相当于 ST / Atom 中的 Ctrl + p
SPC p R 在项目中替换字符串，根据提示输入「匹配」和「替换」的字符串，然后输入替换的方式：
    - E 修改刚才输入的「替换」字符串
    - RET 表示不做处理
    - y 表示只替换一处
    - Y 表示替换全部
    - n 或 delete 表示跳过当前匹配项，匹配下一项
    - ^ 表示跳过当前匹配项，匹配上一项
    - , 表示替换当前项，但不移动光标，可和 n 或 ^ 配合使用


# 10)Shell 集成 (必须先配置 Shell layer)
SPC "'" (单引号) 打开/关闭 Shell
C-k 	前一条 shell 命令，相当于在 shell 中按上箭头
C-j 	后一条 shell 命令，相当于在 shell 中按下箭头

# 11)GIT
    Git	            Magit
git init	        SPC g i
git status	        SPC g s
git add	SPC         g s 弹出层选中文件然后按 s
git add currentFile	SPC g S
git commit	        SPC g c c
git push	        SPC g P 按提示操作
git checkout xxx	SPC g C
git checkout -- xxx	SPC g s 弹出层选中文件然后按 u
git log	SPC g l
在 commit 时，我们输入完 commit message 之后，需要按 C-c C-c 来完成 commit 操作，也可以按 C-c C-k 来取消 commit

# 12)VIM
v50G 从当前开始选择到第 50 行
v6k 从当前开始向下选择 6 行
vat 选择 html tag
v/foo 选择到下一个 foo 之前
v?foo 选择到上一个 foo 之后
viw 选中当前词
~ 转换大小写
A 在行末插入
J 将下一行接到本行末尾
. 重复刚才的命令
ea 在当前单词末尾插入
E 停在下一个空白符前
ctrl-r 重做
mx 设定一个叫 x 的记号
'x 或者 \x` 回到 x 记号位置或者回到 x 记号所在行 #'
:marks 列出所有记号
guu 整行变小写
gUU 整行变大写
'' 跳到前一个位置
>aB 缩进一个块
ds> 删除两端的 <>
```
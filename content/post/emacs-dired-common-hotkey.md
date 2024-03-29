---
title: "Dired 使用"
date: "2022-02-13 06:58:00"
lastmod: "2022-11-23 17:09:10"
tags: ["dired"]
categories: ["emacs"]
draft: false
---

| hotkey    | cmd                  | function                  | notes                                                    |
|-----------|----------------------|---------------------------|----------------------------------------------------------|
| C-x d     | dired                | 进入 Dired 模式           |                                                          |
| **^**     | dired-up-directory   | 返回上一目录              |                                                          |
| p/C-p     | diredp-previous-line | 上一行                    |                                                          |
| n/C-n/SPC | diredp-next-line     | 下一行                    |                                                          |
| &lt;      | dired-prev-dirline   | 上一个目录行              |                                                          |
| &gt;      | dired-next-dirline   | 下一个目录行              |                                                          |
| g         | revert-buffer        | 刷新文件列表              |                                                          |
| +         |                      | 新建目录                  |                                                          |
| C         |                      | 拷贝文件                  | 把 dired-recursive-copies 设为非 nil 的值可以递归拷贝目 录 |
|           |                      |                           | 通常我们设定为 top ，这表示对于顶层目录 dired 会先进行询问是否 要递归拷贝，而其中的子目录则不再询问 |
|           |                      |                           | 如果嫌询问太麻烦，可以直接设 置为 always 。              |
|           |                      |                           | 通常我们设定为 top ，这表示对于顶层目录 dired 会先进行询问是否 要递归拷贝，而其中的子目录则不再询问 |
| D         |                      | 删除文件                  | 类似的有一个 dired-recursive-deletes 变量可以控制递归删 除。 |
| R         |                      | 重命名文件                | 也就是移动文件。                                         |
| H         |                      | 创建硬链接。              |                                                          |
| S         |                      | 创建软链接。              |                                                          |
| M         |                      | 修改权限位                | 即 shell 里面的 chmod 命令。                             |
| G         |                      | 修改文件所属的组          |                                                          |
| O         |                      | 修改文件的所有者          |                                                          |
| T         |                      | 修改文件的修改时间        | 类似于 shell 命令 touch 。                               |
| P         |                      | 打印文件                  |                                                          |
| Z         |                      | 压缩或解压文件            |                                                          |
| L         |                      | 把 Elisp 文件加载进 Emacs |                                                          |
| B         |                      | 对 Elisp 文件进行 Byte compile |                                                          |
| A         |                      | 对文件内容进行正则表达式搜索 | 搜索会在第一个匹配的地方停下，然后 可以使用 M-, 搜索下一个匹配。 |
| Q         |                      | 对文件内容进行交互式的正则表达式替换 |                                                          |
| +         |                      | 创建目录                  |                                                          |
| w         |                      | 复制文件名                | 如果通过 C-u 传递一个前缀参数 0 ，则复制决定路径名       |
|           |                      |                           | 如果只是 C-u 则复制相对于 dired 当前目录的相对路径。     |
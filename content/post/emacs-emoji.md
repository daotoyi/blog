---
title: "emacs emoji"
date: "2022-12-12 13:01:00"
lastmod: "2022-12-12 13:01:16"
categories: ["emacs"]
draft: false
---

Unicode 15.0 和表情符号

Emacs 现在支持 Unicode 15.0，这是目前最新的 Unicode 版本。新前缀 C-x 8 e 现在会导致一些与表情符号相关的新命令：

```cfg
C-x 8 e e 或者 C-x 8 e i

# 插入表情符号 ( emoji-insert)

C-x 8 e s

# 搜索表情符号 ( emoji-search)

C-x 8 e l

# 列出新缓冲区中的所有表情符号 ( emoji-list)

C-x 8 e r

# 插入最近插入的表情符号 ( emoji-recent)

C-x 8 e d

# 描述一个表情符号 ( emoji-describe)

C-x 8 e +和 C-x 8 e -

# 增加和减少任何字符的大小，尤其是表情符号（emoji-zoom-increase 和 emoji-zoom-decrease 分别）

# 还有新的输入法 emoji，
:grin: 允许您输入例如 :grin: 以获得表情符号😁。
```
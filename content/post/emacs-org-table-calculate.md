---
title: "Org Table calculate"
date: "2022-04-05 23:10:00"
lastmod: "2022-11-30 21:27:18"
tags: ["org"]
categories: ["emacs"]
draft: false
---

## Ref {#ref}

<https://orgmode.org/manual/Formula-syntax-for-alc.htmlFormula-syntax-for-alc>

<https://blog.csdn.net/csfreebird/article/details/45459465>


## note {#note}

引用表格中字段: `@row_index$col_index`
优化: @4$5='(/ $4 $3);N, @4 已经指定了当前行数，所以后面$4 和$3 就不需要指定行号，直接用当前行即可

```markdown
`-c }`   ;; 显示或者隐藏 row_index 和 col_index
`-c *`   ;; 对整个表格重新计算（光标必须停留在表格上)
`-c =`   ;; 后在 mini buffer 中输入公式，回车,会在表格下面出现公式
`-c + -y` ;; 对某列求和, insert result into buffer (emacs mode)
`-c + S-Inertchar` ;; 对某列求和, insert result into buffer (evil mode)
`-c '`     ;; 光标停留在某个有公式的字段, -c '就会出现新的 buffe,显示公式
`-u -c -c` ;; 安装公式 ??

`..` ;; 引用范围的 fields 值可以用..表示 from..to 的语义
+TBLFM: $6='(+ $2..$5);N


;;  浮点数指定小数位数:
$4='(format "%0.2f" (* (/ (* (- $2 $3) 1.0) $2) 100));N

;; 两种表达方式:
+TBLFM: @4$6=@4$2+@4$3::@5$6=@5$2+@5$3+@5$4+@5$5
+TBLFM: @2$2='(+ @3$2 @4$2 @5$2);N::@2$3='(+ @3$3 @4$3 @5$3);N
```

| year | zhogyi | fangzheng | hongyuan | huishang | total |
|------|--------|-----------|----------|----------|-------|
| 8082 | 0      | 0         | 0        | 0        | 0     |
| 2019 |        |           |          |          | 0     |
| 2020 |        |           |          |          | 0     |
| 2021 |        |           |          |          | 0     |
| 2022 |        |           |          |          | 0     |

```lisp
+TBLFM: @2='(+ @3..@6);N::$6='(+ $3..$5);N
```
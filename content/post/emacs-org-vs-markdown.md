---
title: "Org VS Markdown"
date: "2022-09-17 09:23:00"
lastmod: "2022-09-17 09:23:31"
categories: ["emacs"]
draft: false
---

## org output {#org-output}

| item | org                    | markdown                       | show                               |
|------|------------------------|--------------------------------|------------------------------------|
|      |                        |                                |                                    |
| 粗体 | \`\*粗体\*\`           | \`\*\*粗体\*\*\` or \`\__粗体\__\` | **粗体**                           |
| 斜体 | \`/斜体/\`             | \`\*斜体\* \` or \`_斜体\_\`   | _斜体_                             |
| 删除线 | \`+删除线+\`           | \`~~删除线~~\`                 | ~~删除线~~                         |
| 下划线 | \`_下划线\_\`          | \`&lt;u&gt;下划线&lt;/u&gt;\`  | <span class="underline">下划线</span> |
| 等宽 | \`=一字不差=\` or \`~代码~\` | \`\` \`一字不差\` \`\`         | `一字不差`                         |


## markdown output {#markdown-output}

```markdown
EDIT|Org|MarkDown|show
-|:-|:-|:-
粗体|`*粗体*` | `**粗体**` or `__粗体__`|**粗体**
斜体 | `/斜体/` | `*斜体* ` or `_斜体_`|*斜体*
 删除线 | `+删除线+` | `~~删除线~~` |~~删除线~~
下划线 | `_下划线_` | `<u>下划线</u>` |<u>下划线</u>
等宽 | `=一字不差=` or `~代码~` | `` `一字不差` `` |`一字不差`
小号字体 |  | `<small>小号字体</small>` |<small>小号字体</small>
大号字体 | | `<big>大号字体</big>` | <big>大号字体</big>
2 号字 |  | `<font size=2>2号字</font>` | <font size=2>2号字</font>
字体 |  | `<font face="隶书">这是隶书</font>` | <font face="隶书">这是隶书</font>
5号红色华文彩云 |  | <`font face="华文彩云" color=#FF0000 size=5>5号红色华文彩云</font>` | <font face="华文彩云" color=#FF0000 size=5>5号红色华文彩云</font>`
颜色字体 | | `$\color{gold}{金色}$` | $\color{gold}{金色}$
```
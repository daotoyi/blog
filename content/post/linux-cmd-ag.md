+++
title = "CMD ag"
lastmod = 2022-04-05T22:38:59+08:00
categories = ["Linux"]
draft = true
+++

## common command parameter {#common-command-parameter}

-   ag -g &lt;File Name&gt; 类似于 find . -name &lt;File Name&gt;
-   ag -i PATTERN： 忽略大小写搜索含 PATTERN 文本
-   ag -A PATTERN：搜索含 PATTERN 文本，并显示匹配内容之后的 n 行文本，例如：ag -A 5  abc 会显示搜索到的包含 abc 的行以及它之后 5 行的文本信息。
-   ag -B PATTERN：搜索含 PATTERN 文本，并显示匹配内容之前的 n 行文本
-   ag -C PATTERN：搜索含 PATTERN 文本，并同时显示匹配内容以及它前后各 n 行文本的内容。
-   ag --ignore-dir &lt;Dir Name&gt;：忽略某些文件目录进行搜索。
-   ag -w PATTERN： 全匹配搜索，只搜索与所搜内容完全匹配的文本。
-   ag --java PATTERN： 在 java 文件中搜索含 PATTERN 的文本。
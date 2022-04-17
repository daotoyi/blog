+++
title = "Josn 格式化输入中文"
date = 2022-04-16T13:40:00+08:00
lastmod = 2022-04-16T13:40:25+08:00
categories = ["Python"]
draft = false
+++

## code {#code}

```python
import json

dic = {'a': 'a', 'b': 2, 'c': "中文"}
js = json.dumps(dic, sort_keys=True, indent=4, separators=(',', ':'), ensure_ascii=False)
print(js)
```

-   sort_keys：是否按照字典排序（a-z）输出
-   indent=4：设置缩进格数，一般由于 Linux 的习惯，这里会设置为 4
-   separators：设置分隔符
    -   separators=(',', ':')
    -   separators=(', ', ': ')
-   **ensure_ascii=False**
    -   json 库默认是以 ASCII 来解析 code，中文不在 ASCII 编码当中，所以无法正常显示


## output {#output}

```js
{
    "a":"a",
    "b":2,
    "c":"中文"
}
```
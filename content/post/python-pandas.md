---
title: "pandas 使用小结"
lastmod: "2022-04-30 12:46:08"
categories: ["Python"]
draft: true
---

## 显示全部内容 {#显示全部内容}

```python
import pandas as pd
#显示所有列
pd.set_option('display.max_columns', None)
#显示所有行
pd.set_option('display.max_rows', None)
#设置value的显示长度为100，默认为50
pd.set_option('max_colwidth',100)
```

-   若设置显示所有行和列, 数据加载速度会严重变慢.


## 保存文件编码 {#保存文件编码}

一般默认设置下的 excel/csv 无法顺利显示由 utf-8 编码的中文（能够显示以 ANSI 或是 gb2312 编码的中文文件），而 dataframe 导入默认编码为 utf-8，故读写文件时需定义 encoding 为相应的编码方法。

```python
import pandas as pd
df = pd.read_csv('...example.csv', encoding='ANSI')
df.to_csv('.../example.csv', index=False, encoding='ANSI')
```
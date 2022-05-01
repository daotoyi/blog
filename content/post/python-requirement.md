---
title: "requirement"
lastmod: "2022-04-30 12:46:11"
categories: ["Python"]
draft: true
---

## freeze {#freeze}

```bash
pip freeze > requirements.txt
```

-   只适用于单虚拟环境,会将环境中的依赖包全都加入
-   如果使用的全局环境，则下载的所有包都会在里面，不管是不时当前项目依赖的


## pipreqs {#pipreqs}

```bash
pip install pipreqs
pipreqs . --encoding=utf8 --force
```

-   在当前目录生成
-   --force 强制执行，当 生成目录下的 requirements.txt 存在时覆盖


## install {#install}

```bash
pip install -r requirements.txt
```
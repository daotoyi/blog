---
title: "Sphinx 使用总结"
date: "2022-12-09 14:43:00"
lastmod: "2022-12-10 10:45:03"
categories: ["VPS"]
draft: false
toc: true
---

## reStructuredText {#restructuredtext}

reStructuredText 是一种轻量级标记语言。它是 Python Doc-SIG（Documentation Special Interest Group）的 Docutils 项目的一部分，旨在为 Python 创建一组类似于 Java 的 Javadoc 或 Perl 的 Plain Old Documentation（pod）的工具。Docutils 可以从 Python 程序中提取注释和信息，并将它们格式化为各种形式的程序文档。

值得注意的是，reStructuredText 是一个单词，不是两个，也不是三个。可以简写为 RST、ReST 或 reST，作为一种用于文本数据的文件格式，通常采用 .rst 作为文件后缀。

Sphinx 使用 reST 作为标记语言。实际上，reST 与 Markdown 非常相似，都是轻量级标记语言。由于设计初衷不同，reST 的语法更为复杂一些。


## Sphinx {#sphinx}

Sphinx 是一种文档工具，它可以令人轻松的撰写出清晰且优美的文档, 由 Georg Brandl 在 BSD 许可证下开发.

它采用 reStructuredText! 特性如下：

-   丰富的输出格式: 支持 HTML (包括 Windows 帮助文档), LaTeX (可以打印 PDF 版本), manual pages（man 文档）, 纯文本
-   完备的交叉引用: 语义化的标签,并可以自动化链接函数,类,引文,术语及相似的片段信息
-   明晰的分层结构: 可以轻松的定义文档树,并自动化链接同级/父级/下级文章
-   美观的自动索引: 可自动生成美观的模块索引
-   精确的语法高亮: 基于 Pygments 自动生成语法高亮
-   开放的扩展: 支持代码块的自动测试,并包含 Python 模块的自述文档(API docs)等


## useage {#useage}

-   install

<!--listend-->

```bash
# Sphinx为Python语言的一个第三方库。

# install
pip install sphinx
pip install sphinx_rtd_theme
pip install sphinx-autobuild
pip install sphinx-markdown-tables
pip install recommonmark

# create project
cd ./doc  # 项目下新建doc目录
sphinx-quickstart
```

-   doc directory structure

<!--listend-->

```bash
├── build         # 用来存放通过make html生成文档网页文件的目录
├── make.bat
├── Makefile
└── source        # 存放用于生成文档的源文件
    ├── conf.py   # Sphinx的配置文件
    ├── index.rst
    ├── _static
    └── _templates
```

-   Makefile：可以看作是一个包含指令的文件，在使用 make 命令时，可以使用这些指令来构建文档输出。
-   build：生成的文件的输出目录。
-   make.bat：Windows 用命令行。
-   \_static：静态文件目录，比如图片等。
-   \_templates：模板目录。
-   conf.py：存放 Sphinx 的配置，包括在 sphinx-quickstart 时选中的那些值，可以自行定义其他的值。
-   index.rst：文档项目起始文件。

在 doc 目录中执行 make html，就会在 build/html 目录生成 html 相关文件. sphinx-autobuild 工具启动 HTTP 服务。

```bash
sphinx-autobuild source build/html
```


## github hosting {#github-hosting}

-   新建 github repository
-   添加 README.md 和 .gitignore
    -   .gitignore 添加 build/目录；
    -   不跟踪 build 目录，使用 Read the Docs 进行文档的构建和托管。
-   推送到 github
-   注册 Read the Docs，绑定 github 账号
    -   “Import a Project”导入项目


## note {#note}


### 支持 markddown {#支持-markddown}

Sphinx 默认不支持 Markdown 语法，但可以通过 recommonmark 插件来支持。如果需要支持 markdown 的表格语法，还需要安装 sphinx-markdown-tables 插件。

如果需要支持 markdown 的表格语法，还需要安装 sphinx-markdown-tables 插件。

```cfg
extensions = [
     'recommonmark',
     'sphinx_markdown_tables'
 ]
```


## Ref {#ref}

-   [Sphinx](https://www.sphinx-doc.org/en/master/)
-   [Read the Docs Sphinx Theme](https://sphinx-rtd-theme.readthedocs.io/en/stable/)
-   [Sphinx 使用手册](https://zh-sphinx-doc.readthedocs.io/en/latest/index.html)
-   [Sphinx 使用手册-RESTRUCTUREDTEXT 简介](https://zh-sphinx-doc.readthedocs.io/en/latest/rest.html)
-   [Read the Docs](https://readthedocs.org/)
-   [sphinx-themes](https://sphinx-themes.org/)
-   [Sphinx + Read the Docs 从懵逼到入门](https://zhuanlan.zhihu.com/p/264647009)
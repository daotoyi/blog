+++
title = "Hugo 使用总结"
date = 2022-03-08T11:31:00+08:00
lastmod = 2022-03-09T09:31:52+08:00
categories = ["Hugo"]
draft = false
+++

## 按不同配置启动 {#按不同配置启动}

在 development 环境下，可指定以不同的模式启动以预览效果。

```shell
hugo --config debugconfig.toml
hugo --config a.toml,b.toml,c.toml
```


## fix content {#fix-content}

`hugo server` to show effect on website will deployed.

example:

```shell
/path/to/where/you/installed/hugo server --source=./docs
> 29 pages created
> 0 tags index created
> in 27 ms
> Web Server is available at http://localhost:1313
> Press ctrl+c to stop
```


## ox-hugo {#ox-hugo}

```org
:PROPERTIES:
:EXPORT_FILE_NAME:
:EXPORT_DESCRIPTION:
:EXPORT_HUGO_BUNDLE:
:EXPORT_HUGO_TAGS:
:EXPORT_HUGO_CATEGORIES:
:END:
```

-   TAGS
    -   会覆盖 orgmode 里的 tags 属性, 留空或不设置则会继承 orgmode tags
    -   @ 开头的 orgmode tags 可表示 CATEGORIES

| 配置                         | 含义                                       |
|----------------------------|------------------------------------------|
|                              |                                            |
| HUGO_BASE_DIR                | 博客目录相对于该文件的位置                 |
| HUGO_SECTION                 | 之前保存 hugo 创建的 org/md 文件的相对位置，ox-hugo 的输出位置 |
| HUGO_WEIGHT                  | hugo 排序权重                              |
| HUGO_AUTO_SET_LASTMOD        | 自动修改编辑时间                           |
| TITLE                        | 文章标题                                   |
| HUGO_TAGS                    | 标签                                       |
| HUGO_DRAFT                   | 草稿标记                                   |
| hugo: more                   | 摘要正文分隔符                             |
| Footnotes                    | 用来保存文档的配置                         |
| org-hugo-auto-export-on-save | 保存时自动导出                             |
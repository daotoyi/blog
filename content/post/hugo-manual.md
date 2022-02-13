+++
title = "Hugo 使用总结"
date = 2022-02-06T08:19:00+08:00
lastmod = 2022-02-12T08:49:59+08:00
draft = false
+++

## 按不同配置启动 {#按不同配置启动}

在 development 环境下，可指定以不同的模式启动以预览效果。

```shell
hugo --config debugconfig.toml
hugo --config a.toml,b.toml,c.toml
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

会覆盖 orgmode 里的 tags 属性, 留空或不设置则会继承 orgmode tags
@ 开头的 orgmode tags 可表示 CATEGORIES
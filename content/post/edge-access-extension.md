---
title: "Edge 无法翻译、无法下载插件"
date: "2022-03-04 14:44:00"
lastmod: "2022-04-30 12:34:29"
tags: ["edge"]
categories: ["Internet"]
draft: false
---

-   State "TODO"       from              <span class="timestamp-wrapper"><span class="timestamp">[2022-03-04 周五 14:44]</span></span>
-   修改 host 文件

修改 `C:\Windows\System32\drivers\etc` 文件，增加以下内容。

```text
# Edge 翻译
117.28.245.88 edge.microsoft.com

# 商店扩展
117.28.245.88 msedgeextensions.sf.tlu.dl.delivery.mp.microsoft.com

# 微软账户
117.28.245.88 logincdn.msauth.net
117.28.245.88 login.live.com
117.28.245.88 account.live.com
117.28.245.88 acctcdn.msauth.net
```

-   注意

hots 文件不能直接编辑，需要拷贝出来编辑后再覆盖。

————————————————

版权声明：本文为 CSDN 博主「殷小毅」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。

原文链接：<https://blog.csdn.net/qq_34658509/article/details/123044148>
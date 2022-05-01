---
title: "WxPusher"
date: "2022-04-20 13:08:00"
lastmod: "2022-04-30 12:48:25"
categories: ["Tools"]
draft: false
---

## POST {#post}

```bash
http://wxpusher.zjiecode.com/api/send/message/?appToken=AT_xxx&content=daotyi-test&uid= UID_xxx&url=https://www.daotoyi.cn
```

j#+begin_src js
{
  "appToken":"AT_xxx ",
"summary":"summary-decsriptions",
  "content":"daotoyi： {{EntryTitle}}",
  "contentType":1,
  "topicIds":[
   ],
"uids":[
      "UID_xxx "
  ],
   "url":"hhtps://www.daotoyi.cn"
    }
\#+end_src


## Ref {#ref}

-   [github](https://github.com/wxpusher/wxpusher-sdk-python)
-   [WxPusher后台](https://wxpusher.zjiecode.com/admin/main)
-   [WxPusher简介](https://wxpusher.zjiecode.com/docs/#/)
-   [on: 利用IFTTT实现学校通知推送到微信、邮箱等](https://www.yikzero.com/archives/356/)
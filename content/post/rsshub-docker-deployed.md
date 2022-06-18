---
title: "RSSHub docker 部署"
date: "2022-05-07 07:09:00"
lastmod: "2022-05-07 07:09:18"
categories: ["VPS"]
draft: false
---

## deploy {#deploy}

```bash
docker pull diygod/rsshub
docker run -d --name rsshub -p 1200:1200 diygod/rsshub
docker run --restart=always -d --name rsshub -p 1200:1200 -e CACHE_EXPIRE=3600 diygod/rsshub
```

-   CACHE_EXPIRE=3600 : 设置缓存时间为 1 小时
-   access: <http://127.0.0.1:1200/>
-   [Docker 部署](https://docs.rsshub.app/install/#docker-bu-shu)


## feed {#feed}


### browser extension {#browser-extension}

-   RSSHub Radar
-   TamperMonkey Script: RSS+ 在 TamperMonkey 的 RSS 脚本扩展的 RSSHub 服务器域名修为：<https://ip:port> (default: <https://rsshub.app>)
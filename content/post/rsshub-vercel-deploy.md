---
title: "RSShub+Vercel 笔记"
date: "2022-03-11 09:25:00"
lastmod: "2022-04-30 12:47:06"
categories: ["RSS"]
draft: false
---

## login {#login}

打开 <https://vercel.com>

打开后，使用 Github 帐号登陆。（Github 在大陆地区可以正常访问）


## deploy {#deploy}

接着打开 <https://vercel.com/import/project?template=https://github.com/DIYgod/RSSHub>

点击右边的“Github”，登陆授权后，输入仓库名称，比如 RSSHub。

{{< figure src="https://daotoyi.cn/img/202203110917465.jpeg" >}}

接着点击“Create”，然后就会自动部署，这里大概会花费 2~3 分钟，耐心等待即可。

完成后就会出现“恭喜”界面。

点击“Go to Dashboard”，获取 Vercel 的服务地址。

{{< figure src="https://daotoyi.cn/img/202203110915305.jpeg" >}}

将 Vercel 的服务地址在浏览器中打开，即可查看 RSSHub 是否完成部署。


## RSSHub 的服务域名。 {#rsshub-的服务域名}

打开 RSS+ 脚本的设置页面，选择“设置 RSSHub 服务的域名”，然后修改为你的 Vercel 服务地址。

{{< figure src="https://daotoyi.cn/img/202203110916194.jpeg" >}}

这样一来，通过 RSS+ 嗅探得到的链接就会走你的 Vercel 服务器。
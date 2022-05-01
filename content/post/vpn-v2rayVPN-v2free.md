---
title: "VPN 推荐"
date: "2022-03-06 16:59:00"
lastmod: "2022-04-30 12:50:51"
tags: ["VPN"]
categories: ["VPS"]
draft: false
---

## v2ray VPN {#v2ray-vpn}

Repo:[v2ray.vpn](https://github.com/bannedbook/v2ray.vpn)

移动端参考 SS 设计，配置方法可参考[手机版Shadowsocks技巧，“分应用VPN”快速应用设置到所有服务器配置文件](https://baiyunju.cc/3959)。


### 路由 {#路由}

-   设置选项
    -   全局
    -   绕过局域网地址
    -   绕过中国大陆地址
    -   绕过局域网及中国大陆地址
    -   GFW 列表
    -   仅代理中国大陆地址
    -   自定义规则

“GFW 列表”，就是 Shadowsocks 电脑端中的 PAC 模式，自动对被墙的网址使用代理，其他网址直接连接。

-   手动设置
    在每个服务器选项中 "+" ,手动设置. 可设置


### 分应用 VPN {#分应用-vpn}

-   默认模式为“关”
-   点击“启用”模式，选择启用 VPN 代理的手机应用
-   点击“绕行”模式，再指定哪些 APP 绕行，不经过 VPN 代理。

在启用或绕行内选择好应用后，点击右上角的三个点菜单按钮，再点击“应用设置到所有配置文件”，这样就将当前的配置数据，应用到所有的服务器。


### Notes {#notes}

“分应用 VPN”与“GFW 列表”代理规则可以叠加生效，例如，虽然将浏览器设置为绕行不使用 VPN，但如果在浏览器中访问被墙的网址，就会自动应用“GFW 列表”代理规则，自动通过 VPN 访问。


## v2free {#v2free}

V2free for android, a V2ray and Shadowsocks client with many builtin free servers.


### 资源 {#资源}

Repo:[fanqiang](https://github.com/bannedbook/fanqiang)

Manual:[安卓手机 V2free 翻墙教程](https://github.com/bannedbook/fanqiang/blob/master/android/v2free.md)


### 机场 {#机场}

-   <https://w1.v2dns.xyz/auth/register>
-   <https://w1.v2free.net/auth/register>

注册后免费获得 1024M 初始流量，每日签到可获得 300-500M 免费流量。 也可获得免费 [v2ray/SS]节点 订阅链接.


### 客户端 {#客户端}

V2free APP 的全局路由默认选项为：代理所有流量。
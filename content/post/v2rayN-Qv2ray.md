---
title: "v2rayN 和 Qv2ray"
date: "2022-05-01 18:42:00"
lastmod: "2022-05-01 18:42:27"
categories: ["VPS"]
draft: false
---

## 域名策略 {#域名策略}


### AsIs {#asis}

只使用域名进行路由选择，默认值


### IPIfNonMatch {#ipifnonmatch}

当域名没有匹配任何规则时，将域名解析成 IP（A 记录或 AAAA 记录）后再次进行匹配

1.  当一个域名有多个 A 记录时，会尝试匹配所有的 A 记录，直到其中一个与某个规则匹配为止；
2.  解析后的 IP 仅在路由选择时起作用，转发的数据包中依然使用原始域名


### IPOnDemand {#ipondemand}

匹配时碰到任何基于 IP 的规则，立即将域名解析为 IP 后进行匹配


### conclusion {#conclusion}

-   AsIs：分流速度快，但分流不够精确;
-   IPIfNonMatch：在牺牲部分速度的同时能带来足够精确的分流;
-   IPOndemand：别用;


## Qv2ray {#qv2ray}


### 路由策略 {#路由策略}

填入规则时请保持 `每行一个，中间没有逗号分隔` 。


### 策略组的优先级 {#策略组的优先级}

-   域名阻断 -&gt; 域名代理 -&gt; 域名直连 -&gt; IP 阻断 -&gt; IP 代理 -&gt; IP 直连。
-   如果最后没有成功匹配，私有地址 和 中国大陆地址 会默认直连，其他地址则会使用代理。


## Ref {#ref}

-   [Qv2ray 高级路由设置](https://qv2ray.net/lang/zh/manual/route.html#%E5%85%A8%E5%B1%80%E8%B7%AF%E7%94%B1%E8%A7%84%E5%88%99)
---
title: "jd_seckill"
lastmod: "2022-05-10 10:34:28"
categories: ["Tools"]
draft: true
---

## steps: {#steps}


### 获取 eid 和 fp(固定值) {#获取-eid-和-fp--固定值}

参考原作者的 issue <https://github.com/zhou-xiaojun/jd_mask/issues/22>

-   方法一

登陆后打开任一商品详情页面:

> F12 打开浏览器的开发者模式，或者右击选择「检查」，切换到「控制台 Console」
> 在 Console 输入\`_JdEid\`对应的就是 eid,
> 在 Console 输入\`_JdJrTdRiskFpInfo\`对应的就是 fp

-   方法二

登陆后打开任一商品订单结算页面：

在 Console 输入\`_JdTdudfp\`。

-   方法三

    在 Console 输入以下 JavaScript 代码

<!--listend-->

```js
var eid = $('#eid').val();
var fp = $('#fp').val();
var trackId = getTakId();
var riskControl = $('#riskControl').val();
console.log(`eid = ${eid}\nfp = ${fp}\ntrack_id = ${trackId}\nrisk_control = ${riskControl}`);,
```

-   方法四

登陆后打开任一商品订单结算页面,打开项目工具\`geteidfp.html\`工具,即可获取.


### 获取 cookies_string(变化值) {#获取-cookies-string--变化值}

商品结算界面（或者购物车页面？）：

> 右击「检查」，「网络」，在「标头」里打\`Cookie\`。
> 注意：每次扫码登陆后都需要重新获取 cookies_string


### 获取 sku_id,DEFAULT_USER_AGENT {#获取-sku-id-default-user-agent}

> sku_id = 100012043978 # 茅台的 sku_id
> DEFAULT_USER_AGENT = '' # 或者指定


### 配置时间 {#配置时间}

config.ini


## Ref {#ref}

-   [京东获取Cookie教程的三种方法 | 浏览器+插件版+Boxjs版](https://www.kistom.com/?p=541)
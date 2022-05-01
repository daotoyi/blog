---
title: "AKShare Futures"
lastmod: "2022-04-30 12:46:32"
categories: ["Quant"]
draft: true
---

## [期货基础信息](https://www.akshare.xyz/data/futures/futures.html#id2) {#期货基础信息}

| 交易所名称 | 交易所代码 | 合约后缀 | 首页地址                   |
|-------|-------|------|------------------------|
| 中国金融期货交易所 | CFFEX | .CFX | <http://www.cffex.com.cn/> |
| 上海期货交易所 | SHFE  | .SHF | <http://www.shfe.com.cn/>  |
| 上海国际能源交易中心 | INE   | .INE | <http://www.ine.cn/>       |
| 郑州商品交易所 | CZCE  | .ZCE | <http://www.czce.com.cn/>  |
| 大连商品交易所 | DCE   | .DCE | <http://www.dce.com.cn/>   |


## [金融期货](https://www.akshare.xyz/data/futures/futures.html#id8) {#金融期货}


### 中国金融期货交易所 {#中国金融期货交易所}

| 代码        | 名称        |
|-----------|-----------|
| IC9999.CCFX | 中证 500 主力合约 |
| IF9999.CCFX | 沪深 300 主力合约 |
| IH9999.CCFX | 上证 50 主力合约 |
| T9999.CCFX  | 10 年期国债主力合约 |
| TF9999.CCFX | 5 年期国债主力合约 |
| TS9999.CCFX | 2 年期国债主力合约 |


## [商品期货](https://www.akshare.xyz/data/futures/futures.html#id10) {#商品期货}

| 名称    | 主力合约代码 | 指数合约代码 |
|-------|--------|--------|
| 原油合约 | SC9999.XINE | SC8888.XINE |
| 20 号胶合约 | NR9999.XINE | NR8888.XINE |


## 期货基础名词 {#期货基础名词}


### 主力连续合约 {#主力连续合约}

-   合约首次上市时, 以当日收盘同品种持仓量最大者作为从第二个交易日开始的主力合约.
-   当同品种其他合约持仓量在收盘后超过当前主力合约 1.1 倍时, 从第二个交易日开始进行主力合约的切换.
-   日内不会进行主力合约的切换.
-   主力连续合约是由 **该品种期货不同时期主力合约接续** 而成, 代码以 88 或 888 结尾结尾, 例如 IF88 或 IF888.


### ”平滑”处理, {#平滑-处理}

处理规则如下: 以主力合约切换前一天(T-1 日)新、旧两个主力合约收盘价做差, 之后将 T-1 日及以前的主力连续合约的所有价格水平整体加上或减去该价差, 以”整体抬升”或”整体下降”主力合约的价格水平, 成交量、持仓量均不作调整, 成交额统一设置为 0.


### 指数连续合约 {#指数连续合约}

指数连续合约: 由 **当前品种全部可交易合约** 以累计持仓量为权重 **加权平均** 得到, 代码以 99 结尾, 例如 IF99.


### 展期收益率 {#展期收益率}

展期收益率是由不同交割月的价差除以相隔月份数计算得来, 它反映了市场对该品种在近期交割和远期交割的价差预期.


## 实时数据| {#实时数据}


### 东财| {#东财}

-   接口: stock_zh_a_spot_em
-   目标地址: <http://quote.eastmoney.com/center/gridlist.html#hs_a_board>


### 新浪| {#新浪}

-   接口: stock_zh_a_spot
-   目标地址: <http://vip.stock.finance.sina.com.cn/mkt/#hs_a>
-   注意: 重复运行本函数会被新浪暂时封 IP, 建议增加时间间隔


### Ref {#ref}

-   [实时行情数据](https://www.akshare.xyz/data/stock/stock.html#id6)
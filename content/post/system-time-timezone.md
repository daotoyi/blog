+++
title = "Time TZ"
lastmod = 2022-03-02T16:02:01+08:00
categories = ["Linux"]
draft = true
+++

## GMT，CST，UTC {#gmt-cst-utc}


### UTC {#utc}

`协调世界时` ，又称 `世界标准时间` 或 `世界协调时间` ， UTC（Coordinated Universal Time），是最主要的世界时间标准，其以原子时秒长为基础，在时刻上尽量接近于格林尼治标准时间。


### GMT {#gmt}

`格林尼治平时=，又称 =格林尼治平均时间` 或 `格林尼治标准时间` ,  GMT (Greenwich Mean Time), 指位于英国伦敦郊区的皇家格林尼治天文台的标准时间，因为本初子午线被定义在通过那里的经线。

地球每天的自转是有些不规则的，而且正在缓慢减速，因此格林尼治时间已经不再被作为标准时间使用。现在的标准时间，是由原子钟报时的协调世界时（UTC）.


### CST {#cst}

`北京时间` ，(China Standard Time)， `中国标准时间` 。在时区划分上，属东八区，比协调世界时早 8 小时，记为 UTC+8。

它可以同时代表四个不同的时间：

-   China Standard Time UT+8:00
-   Cuba Standard Time UT-4:00
-   Central Standard Time (USA) UT-6:00
-   Central Standard Time (Australia) UT+9:30


## 时区 {#时区}


### 命令行设置 {#命令行设置}

```shell
$  timedatectl list-timezones |grep Shanghai    #查找中国时区的完整名称
  Asia/Shanghai
$  timedatectl set-timezone Asia/Shanghai    #其他时区以此类推
```


### 命令配置 {#命令配置}

1.  tzselect
    -   Asia
    -   China
    -   Shanghai
    -   export TZ=’Asia/Shanghai’(.profile)

（退出并重新登录）

1.  dpkg-reconfigure tzdata


### 配置文件 {#配置文件}

`ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime`
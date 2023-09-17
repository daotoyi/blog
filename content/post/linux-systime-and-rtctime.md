---
title: "Linux 系统时间与 RTC 时间设置"
date: "2023-09-08 18:00:00"
lastmod: "2023-09-08 18:01:11"
categories: ["Linux"]
draft: false
---

## sys time &amp; rtc time {#sys-time-and-rtc-time}

|              | 系统时区为 UTC                  | 系统时区不为 UTC                |
|--------------|----------------------------|---------------------------|
| 查看系统时间 | # date                          | # date                          |
| 查看 RTC 时间 | # hwclock                       | # hwclock -u                    |
| 设置系统时间 | # date -s "2020-02-25 16:33:33" | # date -s "2020-02-25 16:33:33" |
| 同步系统时间到 RTC | # hwclock --systohc             | # hwclock --systohc -u          |
| 同步 RTC 时间到系统 | # hwclock --hctosys             | # hwclock --hctosys -u          |


## CST、UTC {#cst-utc}

CST（China Standard Time）。

UTC 是协调世界时，又称世界统一时间、世界标准时间、国际协调时间。也就是东西零区的时间，比我们东八区慢 8 个小时。


## hwclock {#hwclock}

RTC 存储的时间本身不带有时区信息，当使用 hwclock 区读取解析显示时需要根据实际配置的时区信心进行转换。为了保持内核的一致性，我们保持 RTC 存储 UTC 的时间信息。所以无论是读取还是设置 RTC 时间都需要加上 -u 选项。
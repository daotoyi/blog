---
title: "Linux Debian/Ubuntu FAQ"
lastmod: "2023-10-06 18:19:26"
categories: ["Linux"]
draft: true
---

## apt 更新报错 Certificate-verification-failed {#apt-更新报错-certificate-verification-failed}

### 问题

-   apt-get install xxx 一直报证书错误 `Certificate verification failed`。

> Certificate verification failed: The certificate is NOT trusted. The certificate issuer is unknown. The certificate chain uses insecure algorithm. Could not handshake: Error in the certificate verification. \[IP: 10.xxx.xxx.xxx xxx\]

-   apt-get update 一直报证书错误 `Certificate verification failed`。

> Certificate verification failed: The certificate is NOT trusted. The certificate chain uses expired certificate. Could not handshake: Error in the certificate verification. \[IP: 101.6.15.130 443\]

### 解决1

-   在源地址前面加入 \[trusted=yes\]
-   无效

```
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb  [trusted=yes]  https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
deb  [trusted=yes] https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb  [trusted=yes] https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb  [trusted=yes] https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse
```

### 解决2

机器时间设置问题，因为证书校验是 时间敏感的,若机器时间在当前时间之前，则证书校验失败。[Ref](https://juejin.cn/post/6844904106050453511)

### 解决3

-   把软件源里的https改成http

```
deb  [trusted=yes]  http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
deb  [trusted=yes] http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb  [trusted=yes] http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb  [trusted=yes] http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse
```

-   apt安装证书
    [Ref](https://blog.csdn.net/sinat_38800908/article/details/102839087)

```
sudo apt-get install --reinstall ca-certificates
sudo apt-get update
```

-   手动安装证书
    [Ref](https://blog.csdn.net/sc_goddog/article/details/106527014)

> http源被禁，https源无法使用，需要手动安装ca-certificates包。
> 要下载ca-certificates包还有libssl和openssl两个依赖包，按照如下顺序安装3个包后，再次apt update正常。

如：

```
dpkg -i libssl1.1_1.1.1-1ubuntu2.1_18.04.6_amd64.deb
dpkg -i openssl_1.1.1-1ubuntu2.1_18.04.6_amd64.deb
dpkg -i ca-certificates_20190110_18.04.1_all.deb
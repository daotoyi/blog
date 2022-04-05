+++
title = "CA SSL 证书"
lastmod = 2022-04-04T22:33:52+08:00
categories = ["Internet"]
draft = true
+++

## CA {#ca}

CA 是证书的签发机构，它是公钥基础设施（Public Key Infrastructure，PKI）的核心。CA 是负责签发证书、认证证书、管理已颁发证书的机关。

CA 拥有一个证书（内含公钥和私钥）。


## SSL {#ssl}

SSL 证书，也称为服务器 SSL 证书，是遵守 SSL 协议的一种数字证书，由全球信任的证书颁发机构(CA)验证服务器身份后颁发。

将 SSL 证书安装在网站服务器上，可 **实现网站身份验证和数据加密传输双重功能。**


## Nginx {#nginx}

-   ssl_certificate 证书其实是个公钥，它会被发送到连接服务器的每个客户端
-   ssl_certificate_key 私钥是用来解密的，所以它的权限要得到保护但 nginx 的主进程能够读取。

当然私钥和证书可以放在一个证书文件中，这种方式也只有公钥证书才发送到 client。


## Ref {#ref}

1.  [CA和SSL证书介绍](https://www.cnblogs.com/kerwincui/p/14179837.html)
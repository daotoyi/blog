---
title: "Linux Compile Install Openssh/Openssl"
date: "2022-06-25 16:13:00"
lastmod: "2022-06-25 16:13:59"
categories: ["Linux"]
draft: false
---

## download {#download}

-   <https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/>
-   <https://ftp.openssl.org/source/>
-   <https://www.openssl.org/source/>


## steps {#steps}

```bash
mkdir /opt/sshbak &&  mv /etc/ssh/*  /opt/sshbak/
mkdir /usr/local/sshd

tar xf openssh-8.8p1.tar.gz -C /usr/local/src/ && cd /usr/local/src/openssh-8.8p1/
./configure --with-md5-passwords --with-pam --with-selinux --with-privsep-path=/usr/local/sshd/ --sysconfdir=/etc/ssh
make -j4
make install
```


## Ref {#ref}

-   [Linux升级OpenSSH和OpenSSL](https://cloud.tencent.com/developer/article/1819398)
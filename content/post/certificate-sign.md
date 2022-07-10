---
title: "SSL 证书签发"
date: "2022-04-04 18:52:00"
lastmod: "2022-07-06 18:36:31"
tags: ["SSL", "Cert"]
categories: ["Internet"]
draft: false
---

## Certbot {#certbot}

使用自动证书机器人 Certbot,自动签发 Let’s Encrypt 的免费证书,只是需要三个月一续,机器人自动帮忙搞定


### Before {#before}

```bash
# 安装 cerbot
[root@  ~]# yum install certbot
[root@  ~]# yum install python3-certbot-nginx

# 使用certbot --nginx命令获取证书
# certbot会自动获取证书，并修改/etc/nginx/nginx.conf文件的配置
cerbot --nginx

# 新证书测试，这只是个测试，并不保存任何文件
certbot renew --dry-run

# 更新证书
certbot renew
```

使用 Linux 的计划任务自动更新证书(新版本会自动更新）

```conf-unix
[root@ ~]# cat /etc/crontab
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root

# For details see man 4 crontabs

# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name  command to be executed

0 0 */1 * * root /usr/bin/certbot renew
#配置示例，请自行验证
```


### Now {#now}

-   <https://snapcraft.io/install/certbot/rhel>

<!--listend-->

```bash
# 在 CentOS/Redaht7  中添加 EPEL
sudo yum install -y epel-release

# 在 CentOS/Redaht8  中添加 EPEL
# sudo dnf install epel-release
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo dnf upgrade

yum install -y snapd
systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
certbot --nginx # Certbot自动编辑Nginx配置
certbot certonly --nginx # 仅获得证书, 不配置Nginx
# 测试自动续订
certbot renew --dry-run
```

**Certbot 包带有 cron 作业或 systemd 计时器，它将在证书过期之前自动续订证书。除非更改配置，否则不需要再次运行 Certbot。**


## acme.sh {#acme-dot-sh}


### instroduction {#instroduction}

acme.sh 依赖于 cron 执行定时任务，安装完成后，输入 crontab -l 命令，能看到如下输出：

`41 0 * * * "/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" > /dev/null`

由于 ACME 协议和 Let’s Encrypt CA 都在频繁的更新，因此建议开启 acme.sh 的自动升级： `/.acme.sh/acme.sh  --upgrade  --auto-upgrade`


### install {#install}

```bash
curl https://get.acme.sh | sh
```


### useage {#useage}

acme 使用 ZeroSSL，不注册账户会提示错误

> No EAB credentials found for ZeroSSL, let’s get one

注册账号：
`acme.sh --register-account -m 邮箱地址`

```bash
# 已经运行了web软件，指定webroot即可签发证书
~/.acme.sh/acme.sh --issue -d 域名 --webroot web目录

# 已经运行Nginx/Apache，指定对应插件
~/.acme.sh/acme.sh --issue -d 域名 --nginx # 如果是apache，换成 --apache

# 没有运行web软件并且80端口空闲，可以使用acme.sh自己监听80端口进行验证：
~/.acme.sh/acme.sh --issue -d 域名 --standalone

# 重新生成证书,每60天自动重新生成
acme.sh --renew -d www.psvmc.cn --force

# 泛域名, dns方式十分适合用于生成泛解析证书
# 1)
./acme.sh --issue -d *.example.com  --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please
# 2) 在域名解析中添加TXT记录
# https://upload-images.jianshu.io/upload_images/16254840-ed60c32b87967f76.png?imageMogr2/auto-orient/strip|imageView2/2/w/1114/format/webp
# 3)
./acme.sh --renew -d *.example.com  --yes-I-know-dns-manual-mode-enough-go-ahead-please

# 开启自动升级
acme.sh  --upgrade  --auto-upgrade
acme.sh --upgrade  --auto-upgrade  0 # close

# basic manager
acme.sh --list
acme.sh --remove -d example.com
acme.sh --uninstall
```


### generated {#generated}

完成后会给出证书的位置:

```bash
[Thu Sep 10 03:38:21 EDT 2020] Your cert is in  /home/user/.acme.sh/my.domain.com/my.domain.com.cer
[Thu Sep 10 03:38:21 EDT 2020] Your cert key is in  /home/user/.acme.sh/my.domain.com/my.domain.com.key
[Thu Sep 10 03:38:21 EDT 2020] The intermediate CA cert is in  /home/user/.acme.sh/my.domain.com/ca.cer
[Thu Sep 10 03:38:21 EDT 2020] And the full chain certs is there:  /home/user/.acme.sh/my.domain.com/fullchain.cer
```

文件说明：

-   ca.cer：Let’s Encrypt 的中级证书
-   fullchain.cer：包含中级证书的域名证书
-   my.domain.com.cer：无中级证书的域名证书
-   my.domain.com.conf：该域名的配置文件
-   my.domain.com.csr：该域名的 CSR 证书请求文件
-   my.domain.com.csr.conf：该域名的 CSR 请求文件的配置文件
-   my.domain.com.key：该域名证书的私钥

> 在使用 acme.sh  -issue -d domain --webroot xxx [--standalone]时生成证书失败. 通过手动注册 ZeroSSL 并申请 domain 证书后, 再执行 OK.


### certificate install {#certificate-install}

申请好证书的证书位于~/.acme.sh 目录内，不建议直接使用，而是将其安装到指定目录

```bash
# ~/.acme.sh/acme.sh --install-cert -d 域名 --key-file  /xxx --fullchain-file /xxx

~/.acme.sh/acme.sh --install-cert -d 域名 \
                   --key-file       密钥存放目录  \
                   --fullchain-file 证书存放路径 \
                   --reloadcmd     "service nginx force-reload"
# 可选的，用来安装好证书后重启web服务器
```

上面提到的申请和安装命令，执行过一次后，acme.sh 便会记下你的操作，在证书即将到期前自动帮你执行一遍


### other {#other}

签发证书时报错“Can not get EAB credentials from ZeroSSL”

```bash
acme.sh --register-account -m my@example.com
#? acme.sh --set-default-ca --server letsencrypt
```

**Nginx 的配置 ssl_certificate 使用 fullchain.cer ，而非 &lt;domain&gt;.cer ，否则 SSL Labs 的测试会报 Chain issues Incomplete 错误。**


## [SSL证书申请与配置acme.sh和certbot](https://page.syao.fun/2020/09/11/web_caddy.html) {#ssl证书申请与配置acme-dot-sh和certbot}

由于 Let’s Encrypt 对域名申请证书分次数有一定限制，在测试的时候使用--test 参数可以有效避免因短时间内申请次数过多而失败。

**acme.sh 在 V3.00 之后默认服务器更换为 ZeroSSL, 不存在短期内申请次数过多而申请受限的问题.**


## [使用Let's Encrypt的acme.sh申请泛域名证书](https://www.psay.cn/toss/126.html) {#使用let-s-encrypt的acme-dot-sh申请泛域名证书}


## [acme.h 通配符证书](https://xtls.github.io/Xray-docs-next/document/level-1/fallbacks-with-sni.html#%E7%94%B3%E8%AF%B7-tls-%E8%AF%81%E4%B9%A6) {#acme-dot-h-通配符证书}

要对不同前缀的域名进行分流，但一个通配符证书的作用域仅限于两“.”之间（例如：申请 **.example.com，example.com 和 \*.**.example.com 并不能使用该证书），故需申请 SAN 通配符证书。根据 Let's Encrypt 官网信息[1]，申请通配符证书要求 DNS-01 验证方式，此处演示 NS 记录为 Cloudflare 的域名通过 acme.sh 申请 Let's Encrypt 的免费 TLS 证书。使用其他域名托管商的申请方法请阅读 dnsapi · acmesh-official/acme.sh Wiki。

```bash
curl https://get.acme.sh | sh # 安装 acme.sh
export CF_Token="sdfsdfsdfljlbjkljlkjsdfoiwje" # 设定 API Token 变量
acme.sh --issue -d example.com -d *.example.com --dns dns_cf # 使用 DNS-01 验证方式申请证书
mkdir /etc/ssl/xray # 新建证书存放目录
acme.sh --install-cert -d example.com --fullchain-file /etc/ssl/xray/cert.pem --key-file /etc/ssl/xray/privkey.key --reloadcmd "chown nobody:nogroup -R /etc/ssl/xray && systemctl restart xray" # 安装证书到指定目录并设定自动续签生效指令
```

> 以下操作需要在 root 用户下进行，使用 sudo 会出现错误。


## [Github Action 部署 acme.sh 全自动批量签发多域名证书教程](https://www.ioiox.com/archives/104.html) {#github-action-部署-acme-dot-sh-全自动批量签发多域名证书教程}


## Ref {#ref}

-   [Let's Encrypt 官网信息](https://letsencrypt.org/zh-cn/docs/faq/)
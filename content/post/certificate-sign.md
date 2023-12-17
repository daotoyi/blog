---
title: "SSL 证书签发"
date: "2022-04-04 18:52:00"
lastmod: "2023-11-16 20:00:12"
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
                   --key-file       /path/to/keyfile/in/nginx/key.pem  \
                   --fullchain-file /path/to/fullchain/nginx/cert.pem \
                   --reloadcmd     "service nginx force-reload"
# 可选的，用来安装好证书后重启web服务器
```

-   上面提到的申请和安装命令，执行过一次后，acme.sh 便会记下你的操作，在证书即将到期前自动帮你执行一遍
-   这里用的是 service nginx force-reload, 不是 service nginx reload, 据测试, reload 并不会重新加载证书, 所以用的 force-reload
-   Nginx 配置
    -   **ssl_certificate 使用 /etc/nginx/ssl/fullchain.cer**  ，而非 /etc/nginx/ssl/&lt;domain&gt;.cer，否则 SSL Labs 的测试会报 Chain issues Incomplete 错误。


### FAQ {#faq}


#### 签发证书时报错“Can not get EAB credentials from ZeroSSL” {#签发证书时报错-can-not-get-eab-credentials-from-zerossl}

```bash
acme.sh --register-account -m my@example.com
#? acme.sh --set-default-ca --server letsencrypt
```

**Nginx 的配置 ssl_certificate 使用 fullchain.cer ，而非 &lt;domain&gt;.cer ，否则 SSL Labs 的测试会报 Chain issues Incomplete 错误。**


#### 申请 zerossl 证书出现 timeout {#申请-zerossl-证书出现-timeout}

正常的话使用 acme.sh 申请 zerossl 证书：

-   需要一个 zerossl 邮箱地址
-   申请的域名是可访问状态，并且状态码是正常的 200.
    -   如果使用 acme.sh 申请 zerossl 证书时，域名状态码不正常，就会出现了 timeout 的问题
    -   保证域名正常可访问时，一般需要开启 80 端口，如果使用了 nginx 反向代理，就不能使用 standalone 模式，可使用 webroot
        -   acme.sh --issue -d [domain.tk] --webroot  [web 目录]


### [acme.h 通配符证书](https://xtls.github.io/Xray-docs-next/document/level-1/fallbacks-with-sni.html#%E7%94%B3%E8%AF%B7-tls-%E8%AF%81%E4%B9%A6) {#acme-dot-h-通配符证书}

要对不同前缀的域名进行分流，但一个通配符证书的作用域仅限于两“.”之间（例如：申请 **.example.com，example.com 和 \*.**.example.com 并不能使用该证书），故需申请 SAN 通配符证书。根据 Let's Encrypt 官网信息[1]，申请通配符证书要求 DNS-01 验证方式，此处演示 NS 记录为 Cloudflare 的域名通过 acme.sh 申请 Let's Encrypt 的免费 TLS 证书。使用其他域名托管商的申请方法请阅读 dnsapi · acmesh-official/acme.sh Wiki。

```bash
curl https://get.acme.sh | sh # 安装 acme.sh
export CF_Token="sdfsdfsdfljlbjkljlkjsdfoiwje" # 设定 API Token 变量
acme.sh --issue -d example.com -d *.example.com --dns dns_cf # 使用 DNS-01 验证方式申请证书
mkdir /etc/ssl/xray # 新建证书存放目录
acme.sh --install-cert -d example.com --fullchain-file /etc/ssl/xray/cert.pem --key-file /etc/ssl/xray/privkey.key --reloadcmd "chown nobody:nogroup -R /etc/ssl/xray && systemctl restart xray" # 安装证书到指定目录并设定自动续签生效指令
```

> 以下操作需要在 root 用户下进行，使用 sudo 会出现错误。


## acme docker {#acme-docker}


### config {#config}

```bash
acme_DP(){
  # dnspod tencent
  local domian=$1
  export DP_Id="453877"
  export DP_Key="b91549269094"

  docker exec acme.sh \
    --register-account -m xxx@gmail.com \
    --server zerossl \
    --issue --dns dns_dp \
    -d $domain \
    -d *.$domain
}

acme_CF(){
  # cloudflare
  local domian=$1
  docker exec acme.sh \
    --register-account -m xxx@gmail.com \
    --server zerossl \
    --issue --dns dns_cf \
    -d $domain \
    -d *.$domain
}

docker_acme(){
  local domain=${PAR3}

  acme_DP $domain
  # acme_CF $domain

  docker run  -itd  \
    --name=acme.sh \
    --restart=always \
    -e DP_Id="453877" \
    -e DP_Key="b9154926909467" \
    -v ${CURRENT_PATH}/etc/cert/acme:/acme.sh  \
    --net=host \
    neilpang/acme.sh daemon

}
docker_acme mydomain.com
```


### useage {#useage}

-   zerossl 得先注册

执行后会有报错：

```text
[Mon Nov 13 15:06:56 UTC 2023] Using CA: https://acme.zerossl.com/v2/DV90
[Mon Nov 13 15:06:56 UTC 2023] Create account key ok.
[Mon Nov 13 15:06:57 UTC 2023] No EAB credentials found for ZeroSSL, let's get one
[Mon Nov 13 15:06:57 UTC 2023] Registering account: https://acme.zerossl.com/v2/DV90
[Mon Nov 13 15:06:59 UTC 2023] Registered
[Mon Nov 13 15:06:59 UTC 2023] ACCOUNT_THUMBPRINT='lQioZXHy7OqnUjApEz8OXKOyP15qQX9G9R7ezHKbOIc'
[Mon Nov 13 15:06:59 UTC 2023] Creating domain key
[Mon Nov 13 15:06:59 UTC 2023] The domain key is here: /acme.sh/dyinvest.cn_ecc/dyinvest.cn.key
[Mon Nov 13 15:06:59 UTC 2023] Multi domain='DNS:dyinvest.cn,DNS:*.dyinvest.cn'
[Mon Nov 13 15:06:59 UTC 2023] Getting domain auth token for each domain
[Mon Nov 13 15:07:02 UTC 2023] Getting webroot for domain='dyinvest.cn'
[Mon Nov 13 15:07:02 UTC 2023] Getting webroot for domain='*.dyinvest.cn'
[Mon Nov 13 15:07:02 UTC 2023] Adding txt value: 1JluaQ6nfTs4hfv26rqkWvn4_HlfF4KWXuAfqjbt48U for domain:  _acme-challenge.dyinvest.cn
[Mon Nov 13 15:07:02 UTC 2023] You don't specify dnspod api key and key id yet.
[Mon Nov 13 15:07:02 UTC 2023] Please create you key and try again.
[Mon Nov 13 15:07:02 UTC 2023] Error add txt for domain:_acme-challenge.dyinvest.cn
[Mon Nov 13 15:07:02 UTC 2023] Please add '--debug' or '--log' to check more details.
[Mon Nov 13 15:07:02 UTC 2023] See: https://github.com/acmesh-official/acme.sh/wiki/How-to-debug-acme.sh
```

> [Mon Nov 13 15:07:02 UTC 2023] Adding txt value: 1JluaQ6nfTs4hfv26rqkWvn4_HlfF4KWXuAfqjbt48U for domain:  \_acme-challenge.dyinvest.cn
> [Mon Nov 13 15:07:02 UTC 2023] You don't specify dnspod api key and key id yet.

需要手动添加 txt value: **1JluaQ6nfTs4hfv26rqkWvn4_HlfF4KWXuAfqjbt48U** for domain:  **\_acme-challenge.dyinvest.cn** ，之后执行：

```text
[Mon Nov 13 15:12:45 UTC 2023] Using CA: https://acme.zerossl.com/v2/DV90
[Mon Nov 13 15:12:45 UTC 2023] Multi domain='DNS:dyinvest.cn,DNS:*.dyinvest.cn'
[Mon Nov 13 15:12:45 UTC 2023] Getting domain auth token for each domain
[Mon Nov 13 15:12:49 UTC 2023] Getting webroot for domain='dyinvest.cn'
[Mon Nov 13 15:12:49 UTC 2023] Getting webroot for domain='*.dyinvest.cn'
[Mon Nov 13 15:12:49 UTC 2023] Adding txt value: y-QFfkoBO_qYcfLoqpSk5hSLS8AOpm49CkFlA1WfdPY for domain:  _acme-challenge.dyinvest.cn
[Mon Nov 13 15:12:51 UTC 2023] Adding record
[Mon Nov 13 15:12:53 UTC 2023] The txt record is added: Success.
[Mon Nov 13 15:12:53 UTC 2023] Adding txt value: 4OXYUv4e3rOuT5cszW5esdIWzr-KJOZUmLTr3pyD9oI for domain:  _acme-challenge.dyinvest.cn
[Mon Nov 13 15:12:54 UTC 2023] Adding record
[Mon Nov 13 15:12:55 UTC 2023] The txt record is added: Success.
[Mon Nov 13 15:12:55 UTC 2023] Let's check each DNS record now. Sleep 20 seconds first.
[Mon Nov 13 15:13:15 UTC 2023] You can use '--dnssleep' to disable public dns checks.
[Mon Nov 13 15:13:15 UTC 2023] See: https://github.com/acmesh-official/acme.sh/wiki/dnscheck
[Mon Nov 13 15:13:15 UTC 2023] Checking dyinvest.cn for _acme-challenge.dyinvest.cn
[Mon Nov 13 15:13:16 UTC 2023] Domain dyinvest.cn '_acme-challenge.dyinvest.cn' success.
[Mon Nov 13 15:13:16 UTC 2023] Checking dyinvest.cn for _acme-challenge.dyinvest.cn
[Mon Nov 13 15:13:17 UTC 2023] Domain dyinvest.cn '_acme-challenge.dyinvest.cn' success.
[Mon Nov 13 15:13:17 UTC 2023] All success, let's return
[Mon Nov 13 15:13:17 UTC 2023] Verifying: dyinvest.cn
[Mon Nov 13 15:13:18 UTC 2023] Processing, The CA is processing your order, please just wait. (1/30)
[Mon Nov 13 15:13:20 UTC 2023] Success
[Mon Nov 13 15:13:20 UTC 2023] Verifying: *.dyinvest.cn
[Mon Nov 13 15:13:22 UTC 2023] Processing, The CA is processing your order, please just wait. (1/30)
[Mon Nov 13 15:13:24 UTC 2023] Success
[Mon Nov 13 15:13:24 UTC 2023] Removing DNS records.
[Mon Nov 13 15:13:24 UTC 2023] Removing txt: y-QFfkoBO_qYcfLoqpSk5hSLS8AOpm49CkFlA1WfdPY for domain: _acme-challenge.dyinvest.cn
[Mon Nov 13 15:13:27 UTC 2023] Removed: Success
[Mon Nov 13 15:13:27 UTC 2023] Removing txt: 4OXYUv4e3rOuT5cszW5esdIWzr-KJOZUmLTr3pyD9oI for domain: _acme-challenge.dyinvest.cn
[Mon Nov 13 15:13:30 UTC 2023] Removed: Success
[Mon Nov 13 15:13:30 UTC 2023] Verify finished, start to sign.
[Mon Nov 13 15:13:30 UTC 2023] Lets finalize the order.
[Mon Nov 13 15:13:30 UTC 2023] Le_OrderFinalize='https://acme.zerossl.com/v2/DV90/order/zYRBi1EOFx6fMgRxlYGH6Q/finalize'
[Mon Nov 13 15:13:31 UTC 2023] Order status is processing, lets sleep and retry.
[Mon Nov 13 15:13:31 UTC 2023] Retry after: 15
[Mon Nov 13 15:13:46 UTC 2023] Polling order status: https://acme.zerossl.com/v2/DV90/order/zYRBi1EOFx6fMgRxlYGH6Q
[Mon Nov 13 15:13:47 UTC 2023] Downloading cert.
[Mon Nov 13 15:13:47 UTC 2023] Le_LinkCert='https://acme.zerossl.com/v2/DV90/cert/C_6NBtv-STVFbxHQdBj0Nw'
[Mon Nov 13 15:13:48 UTC 2023] Cert success.
-----BEGIN CERTIFICATE-----
MIIECDCCA46gAwIBAgIQFIIVvJfunrrKJZL/CMWeMjAKBggqhkjOPQQDAzBLMQsw
CQYDVQQGEwJBVDEQMA4GA1UEChMHWmVyb1NTTDEqMCgGA1UEAxMhWmVyb1NTTCBF
Q0MgRG9tYWluIFNlY3VyZSBTaXRlIENBMB4XDTIzMTExMzAwMDAwMFoXDTI0MDIx
MTIzNTk1OVowFjEUMBIGA1UEAxMLZHlpbnZlc3QuY24wWTATBgcqhkjOPQIBBggq
hkjOPQMBBwNCAAQgwr2myAjal/QULIiLq64X00wYl4uOSayhzXAyXodFQ0CEhMS8
TM4FH2X4Mps47p6IlFXRN3EtFee0BxyqIuvDo4IChzCCAoMwHwYDVR0jBBgwFoAU
D2vmS845R672fpAeefAwkZLIX6MwHQYDVR0OBBYEFOvy2sk8hGSvYD7fb7P2S9dR
3bn9MA4GA1UdDwEB/wQEAwIHgDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsG
AQUFBwMBBggrBgEFBQcDAjBJBgNVHSAEQjBAMDQGCysGAQQBsjEBAgJOMCUwIwYI
KwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMAgGBmeBDAECATCBiAYI
KwYBBQUHAQEEfDB6MEsGCCsGAQUFBzAChj9odHRwOi8vemVyb3NzbC5jcnQuc2Vj
dGlnby5jb20vWmVyb1NTTEVDQ0RvbWFpblNlY3VyZVNpdGVDQS5jcnQwKwYIKwYB
BQUHMAGGH2h0dHA6Ly96ZXJvc3NsLm9jc3Auc2VjdGlnby5jb20wggEFBgorBgEE
AdZ5AgQCBIH2BIHzAPEAdgB2/4g/Crb7lVHCYcz1h7o0tKTNuyncaEIKn+ZnTFo6
dAAAAYvJPrcfAAAEAwBHMEUCIQCbh0SUSSGJk9bG/1alYcpDK9Kpi/wSfFDYymA6
c1X2dAIgG6XpD5Z5Cv+8bK94pBvJt1WcTZSF7W/IhoruofdbThoAdwA7U3d1Pi25
gE6LMFsG/kA7Z9hPw/THvQANLXJv4frUFwAAAYvJPrdAAAAEAwBIMEYCIQCGMGIZ
h+ga86pfLfarg7VtUJHWT527Qu4pYWPvh6uGLQIhAIZAcz7UWIwDNquqyPp01thH
7q4q04oKaWjgrrSlUg+qMCUGA1UdEQQeMByCC2R5aW52ZXN0LmNugg0qLmR5aW52
ZXN0LmNuMAoGCCqGSM49BAMDA2gAMGUCMD8FsmEqH4la2jA9fA07T7s3z2DuMQY7
TQteQ3KXuc4nyz2nNhnsTqLljpshLK/L7gIxAKxeunGVJcBUqP6rv9k+I7SJlT49
WuDgub0ZFmJIyTUKXzdiathxUgTVQqeXtDWJ0g==
-----END CERTIFICATE-----
```

生成以下文件：

> -rw-r--r-- 1 root root 2668 Nov 13 10:13 ca.cer
> -rw-r--r-- 1 root root 1460 Nov 13 10:13 dyinvest.cn.cer
> -rw-r--r-- 1 root root  566 Nov 13 10:13 dyinvest.cn.conf
> -rw-r--r-- 1 root root  477 Nov 13 10:12 dyinvest.cn.csr
> -rw-r--r-- 1 root root  202 Nov 13 10:12 dyinvest.cn.csr.conf
> -rw------- 1 root root  227 Nov 13 09:38 dyinvest.cn.key
> -rw-r--r-- 1 root root 4128 Nov 13 10:13 fullchain.cer


### reference {#reference}

-   [使用docker部署nginx并配置https](https://www.cnblogs.com/tandk-blog/p/15449873.html)
-   [docker运行acme.sh 安装配置泛域名证书](https://www.cnblogs.com/-mrl/p/13335360.html)
-   [acme从letsencrypt 生成免费通配符/泛域名SSL证书并自动续期](https://cloud.tencent.com/developer/article/1736866)


## Note {#note}

-   由于 Let’s Encrypt 对域名申请证书分次数有一定限制，在测试的时候使用--test 参数可以有效避免因短时间内申请次数过多而失败。
-   **acme.sh 在 V3.00 之后默认服务器更换为 ZeroSSL, 不存在短期内申请次数过多而申请受限的问题.**
-   腾讯云对于免费的证书限制：
    1.  免费证书不能通配。就是上面说的，虽然同属于 tandk.com 这个主域名，但是我每多一个子域名，比如 blog.tandk.com，就需要再去申请一个专属于 blog.tandk.com 的 ssl 证书。
    2.  一个主域名只能申请 20 张 ssl 证书。
    3.  证书吊销后，还会在 15 个月内，占用这 20 个证书的名额。


## Reference {#reference}

-   [使用Let's Encrypt的acme.sh申请泛域名证书](https://www.psay.cn/toss/126.html)
-   [Github Action 部署 acme.sh 全自动批量签发多域名证书教程](https://www.ioiox.com/archives/104.html)
-   [解決使用acme.sh申请zerossl证书出现timeout的解决方法](https://www.vpslala.com/t/746)
-   [Let's Encrypt 官网信息](https://letsencrypt.org/zh-cn/docs/faq/)
-   [SSL证书申请与配置acme.sh和certbot](https://page.syao.fun/2020/09/11/web_caddy.html)
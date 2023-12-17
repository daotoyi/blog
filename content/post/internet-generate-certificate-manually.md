---
title: "Nginx 手动生成证书"
date: "2023-12-17 18:50:00"
lastmod: "2023-12-17 18:50:35"
categories: ["Internet"]
draft: false
---

## CA 生成一对密钥 {#ca-生成一对密钥}

```bash
[root@nginx ~]# mkdir -p /etc/pki/CA
[root@nginx ~]# cd /etc/pki/CA/
[root@nginx CA]# mkdir private
[root@nginx CA]# ls
private
[root@nginx CA]# (umask 077;openssl genrsa -out private/cakey.pem 2048)
Generating RSA private key, 2048 bit long modulus (2 primes)

[root@nginx CA]# ls private/
cakey.pem
[root@nginx CA]# mkdir certs newcerts crl
[root@nginx CA]# touch index.txt && echo 01 > serial
```


## CA 生成自签署证书 {#ca-生成自签署证书}

```bash
[root@nginx CA]# openssl req -new -x509 -key private/cakey.pem -out cacert.pem -days 365
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,

If you enter '.', the field will be left blank.
-----

Country Name (2 letter code) [XX]:CN
State or Province Name (full name) []:HB
Locality Name (eg, city) [Default City]:WH
Organization Name (eg, company) [Default Company Ltd]:www.test.com
Organizational Unit Name (eg, section) []:www.test.com
Common Name (eg, your name or your servers hostname) []:www.test.com
Email Address []:123@123.com
[root@nginx CA]# ls
cacert.pem  private
[root@nginx CA]# mkdir certs newcerts crl
[root@nginx CA]# touch index.txt && echo 01 > serial
```


## 客户端生成密钥 {#客户端生成密钥}

```bash
[root@nginx ~]# cd /usr/local/nginx/
[root@nginx nginx]# mkdir ssl
[root@nginx nginx]# cd ssl
[root@nginx ssl]# (umask 077;openssl genrsa -out nginx.key 2048)
Generating RSA private key, 2048 bit long modulus (2 primes)

[root@nginx ssl]# ls
nginx.key
```


## 客户端生成证书签署请求 {#客户端生成证书签署请求}

```bash
[root@nginx ssl]# openssl req -new -key nginx.key -days 365 -out nginx.csr
Ignoring -days; not generating a certificate
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,

If you enter '.', the field will be left blank.
-----

Country Name (2 letter code) [XX]:CN
State or Province Name (full name) []:HB
Locality Name (eg, city) [Default City]:WH
Organization Name (eg, company) [Default Company Ltd]:www.test.com
Organizational Unit Name (eg, section) []:www.test.com
Common Name (eg, your name or your server's hostname) []:www.test.com
Email Address []:123@123.com

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
[root@nginx ssl]# ls
nginx.csr  nginx.key
```


## CA 签署客户端提交上来的证书 {#ca-签署客户端提交上来的证书}

```bash
[root@nginx ssl]# openssl ca -in nginx.csr -out nginx.crt -days 365
Using configuration from /etc/pki/tls/openssl.cnf
Check that the request matches the signature
Signature ok
Certificate Details:
        Serial Number: 1 (0x1)
        Validity
            Not Before: Oct 13 07:37:16 2022 GMT
            Not After : Oct 13 07:37:16 2023 GMT
        Subject:
            countryName               = CN
            stateOrProvinceName       = HB
            organizationName          = www.test.com
            organizationalUnitName    = www.test.com
            commonName                = www.test.com
            emailAddress              = 1@2.com
        X509v3 extensions:
            X509v3 Basic Constraints:
                CA:FALSE
            Netscape Comment:
                OpenSSL Generated Certificate
            X509v3 Subject Key Identifier:
                23:E2:E9:C3:74:34:F8:2E:10:9E:F2:FF:32:9A:0E:E4:A8:6C:45:02
            X509v3 Authority Key Identifier:
                keyid:A3:97:92:68:D9:9C:70:86:E7:55:F7:E4:2C:68:B9:6A:3B:FA:62:9E

Certificate is to be certified until Oct 13 07:37:16 2023 GMT (365 days)
Sign the certificate? [y/n]:y
1 out of 1 certificate requests certified, commit? [y/n]y
Write out database with 1 new entries
Data Base Updated
[root@nginx ssl]# rm -rf nginx.csr
[root@nginx ssl]# ls
nginx.crt  nginx.key
```


## 配置 nginx.conf {#配置-nginx-dot-conf}

```json
server {
    listen       443 ssl;
    server_name  www.test.com;
    ssl_certificate      /usr/local/nginx/ssl/nginx.crt;
    ssl_certificate_key  /usr/local/nginx/ssl/nginx.key;
    ssl_session_cache    shared:SSL:1m;
    ssl_session_timeout  5m;
    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers  on;
    location / {
        root   html;
        index  index.html index.htm;
    }
}
```
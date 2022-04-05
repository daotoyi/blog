+++
title = "证书签发"
date = 2022-04-04T18:52:00+08:00
lastmod = 2022-04-04T20:16:44+08:00
categories = ["Internet"]
draft = false
+++

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

```bash
# 已经运行了web软件，指定webroot即可签发证书
~/.acme.sh/acme.sh --issue -d 域名 --webroot web目录

# 已经运行Nginx/Apache，指定对应插件
~/.acme.sh/acme.sh --issue -d 域名 --nginx # 如果是apache，换成 --apache

# 没有运行web软件并且80端口空闲，可以使用acme.sh自己监听80端口进行验证：
~/.acme.sh/acme.sh --issue -d 域名 --standalone

# 重新生成证书,每60天自动重新生成
acme.sh --renew -d www.psvmc.cn --force

# 开启自动升级
acme.sh  --upgrade  --auto-upgrade
acme.sh --upgrade  --auto-upgrade  0 # close
```


### certificate install {#certificate-install}

申请好证书的证书位于~/.acme.sh 目录内，不建议直接使用，而是将其安装到指定目录

```bash
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
acme.sh --set-default-ca --server letsencrypt
```
---
title: "Linux Redhat/Centos 更新 yum 源"
date: "2022-08-07 22:38:00"
lastmod: "2022-08-19 10:39:06"
categories: ["Linux"]
draft: false
---

## 更换 yum 源 {#更换-yum-源}


### 法 1:直接修改配置 {#法-1-直接修改配置}

/etc/yum.repos.d/，修改或者新建 `.repo` 格式的文件

```cfg
# CentOS  -Base.repo
#
# The mirror system uses the connecting IP address of the client and the
# update status of each mirror to pick mirrors that are updated to and
# geographically close to the client.  You should use this for CentOS updates
# unless you are manually picking other mirrors.
#
# If the mirrorlist= does not work for you, as a fall back you can try the
# remarked out baseurl= line instead.
#
#

[base]
name=CentOS-$releasever - Base - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/$releasever/os/$basearch/
        http://mirrors.aliyuncs.com/centos/$releasever/os/$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6

#released updates
[updates]
name=CentOS-$releasever - Updates - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/$releasever/updates/$basearch/
        http://mirrors.aliyuncs.com/centos/$releasever/updates/$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/$releasever/updates/$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6

#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/$releasever/extras/$basearch/
        http://mirrors.aliyuncs.com/centos/$releasever/extras/$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/$releasever/extras/$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-$releasever - Plus - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/$releasever/centosplus/$basearch/
        http://mirrors.aliyuncs.com/centos/$releasever/centosplus/$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/$releasever/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6

#contrib - packages by Centos Users
[contrib]
name=CentOS-$releasever - Contrib - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/$releasever/contrib/$basearch/
        http://mirrors.aliyuncs.com/centos/$releasever/contrib/$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/$releasever/contrib/$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6
```

-   会有提示系统未注册但是可以正确安装软件
-   需要手动替换文件中的$releasever 变量（redhat 不会自动匹配）


### 法 2:[卸载原有yum重新安装](https://blog.csdn.net/x781437692/article/details/112768356) {#法-2-卸载原有yum重新安装}

```bash
  rpm -qa | grep yum | xargs rpm -e --nodeps   #不检查依赖关系，直接卸载

  # centos yum packages
  rpm -ivh *              # 安装该目录下所有rpm包
  rpm -qa | grep yum      # 查询是否安装好

  echo >  /etc/yum.repos.d/centos7.yum <<EOL
  [base]
name= yum repo
baseurl=http://mirrors.aliyun.com/centos/7/os/$basearch/
enabled=1
gpgcheck=0
EOL

  yum clean allow
  yum list | wc -l
```


### 法 3:挂载安装 ISO 中的 yum 源 {#法-3-挂载安装-iso-中的-yum-源}

```bash
mkdir /media/cdrom
mount -t iso9660 -o loop /path/to/rhel-server-7.0-x86_64-dvd.iso /media/cdrom
```

```cfg
[rhel-media]
#自定义名称
name=CentOS-$releasever - Base
#本地光盘挂载路径
baseurl=file:///media/cdrom
#启用yum源，0为不启用，1为启用
enabled=1
#检查GPG-KEY，0为不检查，1为检查
gpgcheck=1
#GPG-KEY路径
gpgkey=file:///media/cdrom/RPM-GPG-KEY-CentOS-6
```


## FAQ {#faq}


### [Errno 14] problem making ssl connection {#errno-14-problem-making-ssl-connection}

> On RHEL based systems (6.7 or older) when the above error is seen, it is caused by support for TLS 1.0 and 1.1 being deprecated for SSL。

```bash
yum-config-manager --disable centrify.repo
yum clean all
yum update yum
yum update curl
yum update openssl
yum update nss
yum-config-manager --enable centrify.repo
```


## Centos 源 {#centos-源}

-   北外源 [https://mirrors.bfsu.edu.cn/centos-vault/6.6/os/](https://mirrors.bfsu.edu.cn/centos-vault/6.6/os/)
    -   [Centos-6.6-i386](https://mirrors.bfsu.edu.cn/centos-vault/6.6/isos/i386/CentOS-6.6-i386-bin-DVD1.iso)
-   清华源 [https://mirror.tuna.tsinghua.edu.cn/centos-vault/6.6/](https://mirror.tuna.tsinghua.edu.cn/centos-vault/6.6/)
-   阿里源 <https://mirrors.aliyun.com/centos/>
    -   Centos6 及以前的源均不包含
-   163 源 <http://mirrors.163.com/centos/>
    -   Centos6 及以前的源均不包含
-   centos 源 <https://vault.centos.org/>
    -   这个 vault 地址有所有版本的源。


## Ref {#ref}

-   [三种方法更换YUM源](https://www.jianshu.com/p/25a63cbf1e9d)
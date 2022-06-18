---
title: "Linux yum/dnf 配置"
date: "2022-06-14 16:48:00"
lastmod: "2022-06-14 16:48:58"
categories: ["Linux"]
draft: false
---

## yum {#yum}


### yum 的下载并安装 {#yum-的下载并安装}

```bash
[root@localhost ~]# rpm -qa | grep yum

# 删除yum下的所有组件
[root@localhost ~]# rpm -qa | grep yum | xargs rpm -e --nodeps

# 查询原有yum配置，并删除
[root@localhost ~]# whereis yum
yum: /etc/yum
[root@localhost ~]# rm -fr /etc/yum

# step4：去网站下载yum源
# 网站地址：http://mirrors.163.com/centos/7/os/x86_64/Packages/
wget http://mirrors.163.com/centos/7/os/x86_64/Packages/yum-cron-3.4.3-168.el7.centos.noarch.rpm
wget http://mirrors.163.com/centos/7/os/x86_64/Packages/yum-metadata-parser-1.1.4-10.el7.x86_64.rpm
wget http://mirrors.163.com/centos/7/os/x86_64/Packages/yum-plugin-fastestmirror-1.1.31-54.el7_8.noarch.rpm
wget http://mirrors.163.com/centos/7/os/x86_64/Packages/yum-3.4.3-168.el7.centos.noarch.rpm

rpm -ivh --force --nodeps yum-cron-3.4.3-168.el7.centos.noarch.rpm
rpm -ivh --force --nodeps yum-metadata-parser-1.1.4-10.el7.x86_64.rpm
rpm -ivh --force --nodeps yum-3.4.3-168.el7.centos.noarch.rpm
rpm -ivh --force --nodeps  yum-plugin-fastestmirror-1.1.31-54.el7_8.noarch.rpm

# 查看是否安装yum
[root@localhost ~]# rpm -qa |grep yum
```


### yum 的配置 {#yum-的配置}

```bash
# 进入 /etc/yum.repos.d文件夹下，下载CentOS7-Base-163.repo
[root@localhost ~]# cd /etc/yum.repos.d

mv CentOS-Base.repo CentOS-Base.repo_OLD
wget -nc http://mirrors.aliyun.com/repo/Centos-7.repo

mv Centos-7.repo CentOS-Base.repo
```


### yum 缓存--未测试 {#yum-缓存-未测试}

```bash
#清除
yum clean all
#更新列表
yum list
#缓存yum包信息到本地
yum makecache
```


## Note {#note}

-   centos8 没有合适的源可用,不建议使用
-   yum 是基本于 python2 的, 在升级 python3 之后,yum 执行会报错
    -   `/usr/bin/yum` 和 `/usr/libexec/urlgrabber-ext-down` 的首行 修改为 `!#/usr/bin/python2`
-   建议使用 dnf 包管理工具(yum install dnf)
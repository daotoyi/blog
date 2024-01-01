---
title: "Linux RHEL8.8LTS 安装仓库及 YUM 挂载方式"
date: "2023-12-29 08:35:00"
lastmod: "2023-12-29 11:53:04"
categories: ["Linux"]
draft: false
---

## 挂载本地镜像仓库(rhel8.8 ) {#挂载本地镜像仓库--rhel8-dot-8}

```bash
mkdir /media/cdrom
mount -oloop rhel8.8xxx.iso /media/cdrom
cat >> /etc/tyum.repos.d/iso.repo <EOF
[BaseOS] name=BaseOS
baseurl=file:///media/cdrom/BaseOS
gpgcheck=0
enabled=1
[AppStream] name=AppStream
baseurl=file:///media/cdrom/AppStream
gpgcheck=0
enabled=1
EOF
# 清理缓存
yum clean all
# 建立数据源
yum makecache
# 查看仓库
yum repolist all
仓库 ID    仓库名称   状态
AppStream  AppStream  启用
BaseOS     BaseOS     启用
```


## 使用 ailiyun 官方仓库 {#使用-ailiyun-官方仓库}

```nil
cd /etc/yum.repos.d/
mkdir bak
mv *.repo bak

wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.rep
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo

yum  -y install cowsay # 测试
```


## 局域网内共享 YUM 仓库 {#局域网内共享-yum-仓库}

```bash
yum install -y httpd
systemctl start httpd
systemctl stop firewalld
# 服务端挂载镜像
mount /opt/CentOS-7.5-1804.iso /var/www/html/CentOS7.5/

# 客户端配置
cat > /etc/yum.repos.d/CentOS-Base.repo << EOF
[local]
name=net_bendiyum
baseurl=http://192.168.1.8/CentOS7.5/
enabled=1
gpgcheck=0
EOF

yum clean all  # 清理yum缓存
um makecache   # 下载并生成所有当前启用的yum仓库的元数据(软件包列表、依赖关系和其他信息)
```


## 参考 {#参考}

-   [如何高效的在 Linux 环境下配置 yum 源？](https://mp.weixin.qq.com/s/YGjJ3VOdLXGd44avJPp9FA)
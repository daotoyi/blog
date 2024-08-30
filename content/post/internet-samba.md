---
title: "samba 配置"
author: ["SHI WENHUA"]
date: "2024-08-25 22:46:00"
lastmod: "2024-08-25 22:46:15"
categories: ["Internet"]
draft: false
---

```cfg
#1.全局部分参数设置：
[global]
#与主机名相关的设置
workgroup = zkhouse #工作组名称
netbios name = zkserver           #主机名称，跟hostname不是一个概念，在同一个组中，netbios name必须唯一
serverstring = this is a test samba server #说明性文字，内容无关紧要
#与登录文件有关的设置
log file = /var/log/samba/log.%m  #日志文件的存储文件名，%m代表的是client端Internet主机名，就是hostname
max log size = 50   #日志文件最大的大小为50Kb
#与密码相关的设置
security = share    #表示不需要密码，可设置的值为share、user和server
passdb backend = tdbsam
load printer = no   #不加载打印机

#2.共享资源设置
[ldo] #//共享名，该共享标签，该名字为在电脑上看到的共享名 *注意网络映射的路径是这标签名字不是共享路径的名字*
comment = Shared Folder with username and password #//该共享描述
path = /home/share  #//共享文件夹路径
public = yes        #//表示是否允许匿名访问该共享目录
valid users = lkb   #//配置的Samba访问账号 指明可以访问的用户
browsable = yes     #//表示是否可以在 Window Explorer中显示该目录
create mask = 777   #//指明新建立的文件的属性
directory mask = 777   #//指明新建立的目录的属性
available = yes        #//available用来指定该共享资源是否可用
browseable = yes       #//共享路径读权限 设置共享是否可浏览，如果no则表示隐藏，需要通过"//ip/共享目录"进行访问
writable = yes         #//共享路径写权限
# force user = nobody
# force group = nogroup

# inherit owner = Yes    # 上传的文件继承父目录的所有者, 而不是使用登录的账号名, 这样上传的文件的所有者都是 root 了.
# 去掉 inherit owner = Yes  即可让用户可以删除自己上传的文件, 不能删除其他用户创建的文件
```

-   [samba-4.12.3版本 smb.conf 配置方式](https://www.cnblogs.com/suozhiyuan/p/14288937.html)
-   [Samba 安装、配置——可读 可写禁止删除](https://www.cnblogs.com/walkersss/p/12178019.html)

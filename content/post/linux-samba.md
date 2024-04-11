---
title: "Linux Samba"
date: "2024-01-13 10:13:00"
lastmod: "2024-03-02 23:41:50"
categories: ["Linux"]
draft: false
---

## 服务器 docker 安装 samba {#服务器-docker-安装-samba}

```bash
docker run -it  \
    --name samba \
    --restart=always \
    -p 139:139 \
    -p 445:445 \
    -v /home//download/samba:/mount    \
    -d dperson/samba \
    -u "samba;zkty"              \
    -s "samba;/mount/;yes;no;no;all;none"
```

```cfg
-s "<name;/path>[;browse;readonly;guest;users;admins;writelist;comment]"
               Configure a share
               required arg: "<name>;</path>"
               <name> is how it's called for clients
               <path> path to share
               NOTE: for the default values, just leave blank
               [browsable] default:'yes' or 'no'
               [readonly] default:'yes' or 'no'
               [guest] allowed default:'yes' or 'no'
               [users] allowed default:'all' or list of allowed users
               [admins] allowed default:'none' or list of admin users
               [writelist] list of users that can write to a RO share
               [comment] description of share
```

{{< figure src="https://img-blog.csdnimg.cn/e29caa0ea8be4a5bbe99d3993c249007.png" >}}


## 客户端（linux）挂载 {#客户端-linux-挂载}

```bash
# username=samba， password=zkty
apt install cifs-utils
apt install samba
apt install samba-client

# mount -t cifs //192.168.0.100/samba /mnt/samba -o username=<username>,password=<password>
mount -t cifs //172.16.254.115/samba /mnt/samba -o username=samba,password=zkty

# 连接测试
smbclient -L 172.16.254.115 -U samba
# Enter SAMBA\samba's password:
smbclient //172.16.254.115/samba -U samba

# 自动挂载
# /etc/fstab
//172.16.254.115/samba /mnt/samba cifs defaults,username=samba,password=zkty
```


## 客户端（windos）挂载 {#客户端-windos-挂载}

-   右击网络
    -   映射网络驱动器
        -   选择驱动器名称
        -   选择文件夹（\\\server\share)
            -   \\\\192.168.0.11\samba
        -   点击完成，后输入密码


## 参考 {#参考}

-   [如何在 Linux 中挂载/卸载本地和网络 (Samba _ NFS) 文件系统](https://cn.linux-console.net/?p=22591)
-   [samba实现共享文件（能在Windows和Linux上访问）](https://zhuanlan.zhihu.com/p/547106013)

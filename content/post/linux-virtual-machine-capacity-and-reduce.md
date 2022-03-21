+++
title = "Linux capacity && reduce"
date = 2022-03-14T20:11:00+08:00
lastmod = 2022-03-14T23:37:17+08:00
categories = ["Linux"]
draft = false
+++

## Reduce capacity {#reduce-capacity}


### 方法 1：给项目的 git 仓库瘦身 {#方法-1-给项目的-git-仓库瘦身}

```shell
# 1.删除无用的分支
$ git branch -d <branch_name>
# 2.删除无用的 tag
$ git tag -d <tag_name>
# 3.清理本地版本库
$ git gc --prune=now
```


### 方法 2：删除没有用的 deb 软件安装包 {#方法-2-删除没有用的-deb-软件安装包}

```shell
du -sh /var/cache/apt/archives #查看没有用的软件安装包的大小
sudo apt-get clean
sudo apt-get autoclean
sudo apt-get autoremove # 据说这个会导致系统崩溃，特别是带桌面的系统，所以谨慎使用
```


### 方法 3 删除孤儿软件包 {#方法-3-删除孤儿软件包}

```shell
sudo apt-get autoremove # 删除系统自动安装的没有用的软件包
sudo apt-get install deborphan # 安装工具
deborphan # 列出孤儿软件包
deborphan | xargs sudo apt-get purge -y # 将孤儿依赖删除
```


### 方法 4 删除/var/log/目录下的不必要的日志文件 {#方法-4-删除-var-log-目录下的不必要的日志文件}

```shell
sudo apt-get install ncdu
# 查看日志文件：
sudo ncdu /var/log
# 删除大容量的软件包
sudo apt-get install debian-goodies #安装工具
dpigs -H #列出最大的 10 个软件包
dpigs -H --lines=20 #列出最大的 20 个软件包
```

> 作者：SuperCoderMan
> 链接：<https://www.jianshu.com/p/0cb33d545a03>


## capacity {#capacity}


### 非 LVM 管理的分区 {#非-lvm-管理的分区}

-   虚拟机软件的磁盘中扩展相应虚拟机系统对应的磁盘.
-   操作分区

    ```shell
    [root@localhost ~]# fdisk /dev/sda

    Command (m for help): p  # 这里输入p，列出分区列表，记住下面的start和end，后续操作才能保证数据不会丢失。

    ...

    Command (m for help): d   #这里输入d，表示删除一个分区
    Partition number (1-3, default 3): 3     #这里输入3，是因为之前的分区是/dev/sda3
    Partition 3 is deleted

    Command (m for help): n    #删除完，输入n新建一个分区
    Partition type:
       p   primary (2 primary, 0 extended, 2 free)
       e   extended
    Select (default p): p   #选择主分区
    Partition number (3,4, default 3): 3  #还是/dev/sda3
    First sector (3762176-100663295, default 3762176):      #这里直接回车
    Using default value 3762176
    Last sector, +sectors or +size{K,M,G} (3762176-100663295, default 100663295):    #这里明显可以看到，不仅包含了之前的sda3的start和end，而且远大于了，使用默认的将剩余的空间都给这个新建的分区。
    Using default value 100663295
    Partition 3 of type Linux and of size 46.2 GiB is set

    Command (m for help): w      #最后写入保存
    The partition table has been altered!
    ```
-   刷新文件系统容量

    需要~reboot~之后再执行.

    ```shell
    # 格式是xfs的，要用xfs_growfs命令
    xfs_growfs /dev/sda3
    # 是ext的，使用resize2fs命令
    resize2fs /dev/sda3
    ```
-   Note:
    -   如果是扩展"扩展分区",新建分区时的 First sector 原扩展分区的不一样. 以上方法失败.


#### 参考 {#参考}

-   <https://blog.csdn.net/u014094046/article/details/95951833>


### LVM 管理的分区 {#lvm-管理的分区}

可参考网络资源.
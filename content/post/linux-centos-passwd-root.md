---
title: "Linux Centos 重置 root 密码"
author: ["SHI WENHUA"]
lastmod: "2024-08-12 21:17:41"
categories: ["Linux"]
draft: true
---

-   在 grub 启动界面按 e 键，进入编辑模式。
-   在内核行找到 ro 字段将 ro 删掉，并添加 rd.break 字段
-   按 “ctrl+x”快捷键进入 emergency 模式下。
    ```bash
    # 修改系统语言
    LANG=en

    # 挂载系统根分区
    mount -o remount,rw /sysroot

    # 将当前终端环境变成一个虚拟的根目录环境
    chroot /sysroot

    # 修改密码
    passwd root

    # 重新设置文件的安全标签
    touch /.autorelabel

    # 退出当前虚拟环境
    exit

    # 重启系统
    reboot
    ```

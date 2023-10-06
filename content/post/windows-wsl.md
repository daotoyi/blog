---
title: "Windows WSL"
date: "2023-10-06 19:00:00"
lastmod: "2023-10-06 19:02:34"
categories: ["Windows"]
draft: false
---

## basic {#basic}

```bat
wsl --set-default-version 2
wsl --install -d Ubuntu-22.04
wsl --list --online
```


## config {#config}

### 修改wsl终端字体

#### 窗口属性（临时）

右击，选择"属性"，弹出的窗口中选择字体进行修改。

#### [注册表](https://so.csdn.net/so/search?q=%E6%B3%A8%E5%86%8C%E8%A1%A8&spm=1001.2101.3001.7020)（永久）

1.  `win+r`输入`regedit`打开注册表，找到计算机`\HKEY_CURRENT_USER\Console`
2.  修改或创建`CodePage`和`FaceName`两个键值对，将`CodePage`设置为`437`, `FaceName`设置为`Consolas`（字体名).

![](https://img-blog.csdnimg.cn/img_convert/8db0f5352a383bbb58b4e43c350e6108.png)

### 修改Linux终端配色

修改`vim ~/.bashrc`

```
PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\][\u@\h]\[\033[00m\]:\[\033[01;35m\]\w\[\033[00m\]\$"
```

### 添加WSL到右键菜单

1.  `win+r`输入`regedit`打开注册表，找到计算机`\HKEY_CLASSES_ROOT\Directory\Background\shell`
2.  在shell文件夹张右键新建一个项,名字为`Bash Here`.
3.  点击Bash Here，在右面窗口中右键新建一个字符串值，名称为Icon，双击将值修改为你想要的图标的位置，可以为\*.ico或\*.exe
4.  在Bash Here下新建项，名称为command,将这个项的默认值修改为Ubuntu.exe或bash.exe文件的地址即可。
    ![在这里插入图片描述](https://img-blog.csdnimg.cn/20210604211857700.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlbmh1YV9z,size_16,color_FFFFFF,t_70)

-   Reference:
    [WSL优化 (Windows Subsystem for Linux) Linux子系统优化配置](https://www.cnblogs.com/0x4D75/p/8981984.html)
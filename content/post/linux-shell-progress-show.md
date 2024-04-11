---
title: "Linux shell 进度条"
date: "2024-03-02 13:53:00"
lastmod: "2024-03-02 23:42:23"
tags: ["shell"]
categories: ["Linux"]
draft: false
---

## pv 命令 {#pv-命令}

pv 命令：pv 是 "pipe viewer" 的缩写，可以监视通过管道传输数据的进度。

```bash
pv file.tar | gzip > file.tar.gz
```


## rsync 命令 {#rsync-命令}

rsync 提供了内置的进度展示功能，可以使用 --progress 选项来显示文件的同步进度。

```bash
rsync -h --progress file.tgz root@192.168.0.100:/test/
```


## 自定义进度条 {#自定义进度条}

```bash
#! /bin/bash
total_steps=100

for ((step=1; step<=total_steps; step++)); do
    printf "\rProgress: [%-50s] %d%%" $(printf "#%.0s" $(seq 1 $((step*50/total_steps)))) "$((step*100/total_steps))"
    sleep 0.1 # 模拟操作延迟
done
printf "\n"
```


## cp/mv 命令补丁包 {#cp-mv-命令补丁包}

cp 和 mv 命令都是属于 coreutils 工具包下的，实现原理就是在安装 coreutils 工具包时加入补丁从而实现进度条功能。

```bash
  wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.32.tar.xz
  # 下载版本：advcpmv-0.8-8.32.patch，与coreutils安装的版本要保持一致，否则会无法安装。
  # https://github.com/jarun/advcpmv
  wget https://github.com/jarun/advcpmv/archive/refs/heads/master.zip

  yum install gcc gcc-c++ unzip patch
  tar -Jxf coreutils-8.32.tar.xz
  unzip master.zip
  cp advcpmv-master/advcpmv-0.8-8.32.patch coreutils-8.32/

  # 使用补丁
  cd coreutils-8.32
  patch -p1 -i advcpmv-0.8-8.32.patch
  ./configure FORCE_UNSAFE_CONFIGURE=1

  # 调整命令
  # 备份

cp /usr/bin/cp{,.bak}
cp /usr/bin/mv{,.bak}

# 替换新命令(注意要在coreutils目录下执行，原命令已经不可用)

cd coreutils-8.32
src/cp src/cp /usr/bin/cp
src/cp src/mv /usr/bin/mv

# /etc/profie
alias cp='cp -ig'
alias mv='mv -ig'
```

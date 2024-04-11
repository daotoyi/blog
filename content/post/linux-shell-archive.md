---
title: "Linux Shell Archive"
date: "2023-09-29 09:35:00"
lastmod: "2024-01-07 08:03:57"
tags: ["shell"]
categories: ["Linux"]
draft: false
---

## cat &lt; EOF {#cat-eof}

从标准输入(stdin) 读取一段文本，遇到 "EOF" 就停止读取，然后将文本输出到标准输出(stdout) 中。

EOF：一个标识符，标识文本信息的开始和结束，可以是任意自定义字符，比如 begin，data 等。


### '&lt;&lt; EOF' 和 '&lt;&lt;- EOF' 区别 {#eof-和-eof-区别}

> If the redirection operator is &lt;&lt;-, then all leading tab characters are stripped from input lines and the line containing delimiter.

-   test

    ```bash
    #!/bin/sh

    #line 1、2、3，EOF，data 1、2、3 前面为 tab，不是空格。
    cat <<- EOF
            line 1
            line 2
            line 3
            EOF

    cat << DATA
            data 1
            data 2
            data 3
    DATA
    ```

-   output

    ```nil
    # cat testext1
    line 1
    line 2
    line 3

    # cat testext2
            data 1
            data 2
            data 3
    ```


### write to file {#write-to-file}

```bash
cat > file << EOF
information 1
information 1
information 1
...
EOF
```


## 空语句 : {#空语句}

-   shell
    -   :
-   python
    -   pass


## 去除文件后辍 {#去除文件后辍}

```bash
$ basename /folder/f.zip .zip
f
```


## 变量名中嵌套变量 {#变量名中嵌套变量}

<a id="code-snippet--print-value"></a>
```shell
id=1
string=id
stream_1="111"

line="$(eval echo \${stread_${id}}), 222"
echo "{!string}"
```

<div class="src-block-caption">
  <span class="src-block-number"><a href="#code-snippet--print-value">Code Snippet 1</a></span>:
  calculate
</div>

-   \\\\({stread\_\\){id}}


## 函数循环 {#函数循环}

```shell
# 基本 for 循环
for i in /etc/rc.*; do
    echo $i
done



# 类似 C 的 for 循环
for ((i = 0 ; i < 100 ; i++)); do
    echo $i
done



# 范围
for i in {1..5}; do
    echo "Welcome $i"
done

# 步长

for i in {5..50..5}; do
    echo "Welcome $i"
done

# 自动递增

i=1
while [[ $i -lt 4 ]]; do
    echo "Number: $i"
    ((i++))

# 自动递减
i=3
while [[ $i -gt 0 ]]; do
    echo "Number: $i"
    ((i--))


# unti

count=0
until [ $count -gt 10 ]; do
    echo "$count"
    ((count++))
```


## 替代 Substitution {#替代-substitution}

```bash

echo ${food:-Cake}  #=> $food or "Cake"

STR="/path/to/foo.cpp"
echo ${STR%.cpp}    # /path/to/foo
echo ${STR%.cpp}.o  # /path/to/foo.o
echo ${STR%/*}      # /path/to
echo ${STR##*.}     # cpp (extension)
echo ${STR##*/}     # foo.cpp (basepath)
echo ${STR#*/}      # path/to/foo.cpp
echo ${STR##*/}     # foo.cpp
echo ${STR/foo/bar} # /path/to/bar.cpp
```


## 切片 Slicing {#切片-slicing}

```shell

name="John"
echo ${name}           # => John
echo ${name:0:2}       # => Jo
echo ${name::2}        # => Jo
echo ${name::-1}       # => Joh
echo ${name:(-1)}      # => n
echo ${name:(-2)}      # => hn
echo ${name:(-2):2}    # => hn

length=2
echo ${name:0:length}  # => Jo
```


## lsof 恢复删除的文件 {#lsof-恢复删除的文件}

```bash
touch test
echo my test file > test
tail -f test
rm -f test
lsof | grep test
cat /proc/5433/fd/3
cat /proc/5433/fd/3 > test
```


## cp 和 mv 命令添加进度条 {#cp-和-mv-命令添加进度条}

由于 cp 和 mv 命令都是属于 coreutils 工具包下的，因此我们的主要操作就是在编译 coreutils 的时候加入补丁从而实现进度条功能.


### 过程 {#过程}

```bash
# 注意尽量不要使用 root 用户操作
# 下载coreutils
$ wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.32.tar.xz
$ tar -xJf coreutils-8.32.tar.xz
$ cd coreutils-8.32/

# 下载 github 上的补丁
$ wget https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-0.8-8.32.patch
# 打补丁，实现进度条显示
$ patch -p1 -i advcpmv-0.8-8.32.patch
# patching file src/copy.c
# patching file src/copy.h
# patching file src/cp.c
# patching file src/mv.c

# 编译安装
$ ./configure
$ make
# 将打补丁生成的cp和mv命令的二进制文件复制到bin目录下
$ sudo cp src/cp /usr/local/bin/cp
$ sudo cp src/mv /usr/local/bin/mv
```


### 使用 {#使用}

在使用 cp 和 mv 命令的时候加上 -g 参数就可以显示进度条.

在 .bashrc 文件中设置 alias.

```bash
$ alias cp='cp -ig'
$ alias mv='mv -ig'
```


## 其他 {#其他}


### [保持 SSH 会话不中断](https://mp.weixin.qq.com/s/9YpQNJjATysLnLKXsK9VQQ) {#保持-ssh-会话不中断}


### [shell 格式化输出及颜色](https://mp.weixin.qq.com/s/2tjHTW_ouMkCBedLMMGUpw) {#shell-格式化输出及颜色}


### [shell 脚本的快速参考备忘单(全)!!!](https://mp.weixin.qq.com/s/9Hbr6n3ZiNj6Yk0hJt_Qbg) {#shell-脚本的快速参考备忘单--全}

-   变量，注释，传参。参数扩展
-   函数，条件句，大括号扩展
-   字符串
-   切片
-   基本路径和目录路径
-   数组
-   字典
-   条件句
-   循环
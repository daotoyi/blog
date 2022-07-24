---
title: "Linux Shell getopts/getopt"
date: "2022-07-21 09:04:00"
lastmod: "2022-07-21 09:05:05"
categories: ["Linux"]
draft: false
---

## 解析方式 {#解析方式}

在 Linux bash 中，可以用以下三种方式解析命令行参数

1.  直接处理：使用$1,$2,$3…进行解析
2.  getopts: 单个字符选项的情况，例如：-n 10 -f file.txt 等选项
3.  getopt：处理单个字符或长选项（long-option），例如：–prefix=/home 等

经验：小型脚本可以直接处理，大多数情况使用 getopts，getopt 的功能更加强大。


## $n 直接处理 {#n-直接处理}

```bash
$0   #即命令本身，相当于c/c++中的argv[0]
$1   #第一个参数
$2, $3, $4 ...   #第2、3、4个参数，依次类推
$#   #参数的个数，不包括命令本身
$@   #参数本身的列表，不包括命令本身
$*   #和$@相同，但"$*"和"$@"(加引号)并不同，
     #"$*"将所有的参数解释成一个字符串，而"$@"是一个参数数组
```


## getopts {#getopts}

-   getopts 有两个参数，包括字符和“:”
-   每一个字符都是一个有效选项（option）
    -   如果字符后面带有":"，表示这个选项有自己的 argument，argument 保存在内置变量 OPTARG 中
        -   d:在实际的使用中就会对应-d 30，选项的值就是 30
    -   没有跟随:的是开关型选项，不需要再指定值，相当于 true/false，只要带了这个参数就是 true
    -   如果命令行中包含了没有在 getopts 列表中的选项，会有警告信息，如果在整个 getopts 字符串前面也加上个:，就能消除警告信息了。
-   操作中有两个相对固定的“常量”，
    -   OPTARG，用来取当前选项的值
        -   $OPTARG 总是存储原始$\*中下一个要处理的元素位置
    -   OPTIND，代表当前选项在参数列表中的位移。
    -   getopts 在处理参数的时候，处理一个开关型选项，OPTIND 加 1，处理一个带值的选项参数，OPTIND 则会加 2。
-   选项参数的格式必须是-d val，而不能是中间没有空格的-dval
-   所有选项参数必须写在其它参数的前面
    -   因为 getopts 是从命令行前面开始处理，遇到非-开头的参数，或者选项参数结束标记--就中止了
-   不支持长选项， 也就是--debug 之类的选项

<!--listend-->

```bash
#!/bin/bash

echo original parameters=[$*]
echo original OPTIND=[$OPTIND]

while getopts ":a:bc" opt # 第一个冒号表示忽略错误
do
    case $opt in
        a)
            echo "this is -a option. OPTARG=[$OPTARG] OPTIND=[$OPTIND]"
            ;;
        b)
            echo "this is -b option. OPTARG=[$OPTARG] OPTIND=[$OPTIND]"
            ;;
        c)
            echo "this is -c option. OPTARG=[$OPTARG] OPTIND=[$OPTIND]"
            ;;
        ?)
            echo "there is unrecognized parameter."
            exit 1
            ;;
    esac
done
#通过shift $(($OPTIND - 1))的处理，$*中就只保留了除去选项内容的参数，
#可以在后面的shell程序中进行处理
shift $(($OPTIND - 1))

echo remaining parameters=[$*]
echo \$1=[$1]
echo \$2=[$2]
```


## getopt {#getopt}

-   getopt 支持短选项和长选项(getopts 不支持长选项,如： --date)
-   增强版 getopt 比较好用
    -   执行命令 getopt -T; echo $?,如果输出 4，则代表是增强版
-   如果短选项带 argument 且参数可选时，argument 必须紧贴选项
    -   -carg 而不能是-c arg
-   如果长选项带 argument 且参数可选时，argument 和选项之间用“=”
    -   –clong=arg 而不能是–clong arg

<!--listend-->

```bash
#!/bin/bash

echo original parameters=[$@]

#-o或--options选项后面是可接受的短选项，如ab:c::，表示可接受的短选项为-a -b -c，
#其中-a选项不接参数，-b选项后必须接参数，-c选项的参数为可选的
#-l或--long选项后面是可接受的长选项，用逗号分开，冒号的意义同短选项。
#-n选项后接选项解析错误时提示的脚本名字
ARGS=`getopt -o ab:c:: --long along,blong:,clong:: -n "$0" -- "$@"`
if [ $? != 0 ]; then
    echo "Terminating..."
    exit 1
fi

echo ARGS=[$ARGS]
#将规范化后的命令行参数分配至位置参数（$1,$2,...)
eval set -- "${ARGS}"
echo formatted parameters=[$@]

while true
do
    case "$1" in
        -a|--along)
            echo "Option a";
            shift
            ;;
        -b|--blong)
            echo "Option b, argument $2";
            shift 2
            ;;
        -c|--clong)
            case "$2" in
                "")
                    echo "Option c, no argument";
                    shift 2
                    ;;
                *)
                    echo "Option c, argument $2";
                    shift 2;
                    ;;
            esac
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Internal error!"
            exit 1
            ;;
    esac
done

#处理剩余的参数
echo remaining parameters=[$@]
echo \$1=[$1]
echo \$2=[$2]
```


## getopt/getpots {#getopt-getpots}

1.  getopts 是 bash 内建命令的， 而 getopt 是外部命令
2.  getopts 不支持长选项， 比如： --date
3.  在使用 getopt 的时候， 每处理完一个位置参数后都需要自己 shift 来跳到下一个位置， getopts 只需要在最后使用 shift $(($OPTIND - 1))来跳到 parameter 的位置。
4.  使用 getopt 时， 在命令行输入的位置参数是什么， 在 getopt 中需要保持原样， 比如 -t ， 在 getopt 的 case 语句中也要使用-t，  而 getopts 中不要前面的-。
5.  getopt 往往需要跟 set 配合使用
6.  getopt -o 的选项注意一下
7.  getopts 使用语法简单，getopt 使用语法较复杂
8.  getopts 不会重排所有参数的顺序，getopt 会重排参数顺序
9.  getopts 出现的目的是为了代替 getopt 较快捷的执行参数分析工作


## Ref {#ref}

-   [Shell命令 getopts/getopt用法详解](https://blog.csdn.net/arpospf/article/details/103381621)
-   [bash/shell 解析命令行参数工具：getopts/getopt](https://cloud.tencent.com/developer/article/1043821)
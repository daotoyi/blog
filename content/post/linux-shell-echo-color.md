---
title: "Linux shell echo 输出颜色"
date: "2024-01-01 09:31:00"
lastmod: "2024-01-01 10:54:07"
categories: ["Linux"]
draft: false
---

## ANSI 控制码简述 {#ansi-控制码简述}

ANSI 控制码用于在字符显示系统中控制光标移动和字符色彩等，常用于 BBS 系统中。

ANSI ESCAPE SEQUENCES 又称为 VT100 系列控制码，国内译为 ANSI 控制码。

ANSI 控制码依赖终端，不是依赖语言，所以在 shell,perl,c 里应用均没有问题。

ANSI 控制码开始的标志都为 ESC[，ESC 对应 ASCII 码表的 033(八进制)，linux 命令 echo 用-e 启用转义，\\033 来输入 ESC，\\033[31m 即为 ESC[31m。

-   format

    > echo -e "\\033[字背景颜色;字体颜色;字体属性 m 需要输出的内容 \\033[0m"

-   \\033 转义起始符
    -   定义一个转义序列，可以使用 \e 或 \E 代替。
-   [ 表示开始定义颜色。
-   再次使用 \\033[ ，表示再次开启颜色定义
    -   0 表示颜色定义结束
    -   m 转义终止符，表示颜色定义完毕。
    -   所以 \\033[0m 的作用是恢复之前的配色方案。
-   字背景颜色 范围 40-47 。
-   字体颜色 范围 30-37 。


## ANSI 控制码选项 {#ansi-控制码选项}

| 控制码               | 含义        |
|-------------------|-----------|
| \\33[0m              | 关闭所有属性 |
| \\33[1m              | 设置高亮度  |
| \\33[4m              | 下划线      |
| \\33[5m              | 闪烁        |
| \\33[7m              | 反显        |
| \\33[8m              | 消隐        |
| \\33[30m -- \\33[37m | 设置前景色（字体色） |
| \\33[40m -- \\33[47m | 设置背景色  |
| \\33[nA              | 光标上移 n 行 |
| \\33[nB              | 光标下移 n 行 |
| \\33[nC              | 光标右移 n 行 |
| \\33[nD              | 光标左移 n 行 |
| \\33[y               | ;xH 设置光标位置 |
| \\33[2J              | 清屏        |
| \\33[K               | 清除从光标到行尾的内容 |
| \\33[s               | 保存光标位置 |
| \\33[u               | 恢复光标位置 |
| \\33[?25l            | 隐藏光标    |
| \\33[?25h            | 显示光标    |

| 颜色          | 前景色（字体色） | 背景色 |
|-------------|----------|-----|
| 黑色 (Black)  | 30       | 40  |
| 红色 (Red)    | 31       | 41  |
| 绿色 (Green)  | 32       | 42  |
| 黄色 (Yellow) | 33       | 43  |
| 蓝色 (Blue)   | 34       | 44  |
| 紫红色 (Magenta) | 35       | 45  |
| 青色 (Cyan)   | 36       | 46  |
| 白色 (White)  | 37       | 47  |

-   前景色：30:黑 31:红   32:绿 33:黄   34:蓝色 35:紫色 36:深绿 37:白色
-   背景色：40:黑 41:深红 42:绿 43:黄色 44:蓝色 45:紫色 46:深绿 47:白色


## shell 设置 {#shell-设置}


### 转义符 {#转义符}

```bash
  #!/bin/bash
  # 定义颜色变量
  RED='\e[1;31m' # 红
  GREEN='\e[1;32m' # 绿
  YELLOW='\e[1;33m' # 黄
  BLUE='\e[1;34m' # 蓝
  PINK='\e[1;35m' # 粉红
  RES='\e[0m' # 清除颜色

  echo -e "${RED}Red${RES}"
  echo -e "${GREEN}Green${RES}"
  echo -e "${YELLOW}Yellow${RES}"
  echo -e "${BLUE}Blue${RES}"
  echo -e "${PINK}Pink${RES}"
  echo
  echo -e "\e[30m 黑色 \e[0m"
  echo -e "\e[31m 红色 \e[0m"
  echo -e "\e[32m 绿色 \e[0m"
  echo -e "\e[33m 黄色 \e[0m"
  echo -e "\e[34m 蓝色 \e[0m"
  echo -e "\e[35m 紫色 \e[0m"
  echo -e "\e[36m 青色 \e[0m"
  echo -e "\e[37m 白色 \e[0m"
  echo
  echo -e "\e[40m 黑底 \e[0m"
  echo -e "\e[41m 红底 \e[0m"
  echo -e "\e[42m 绿底 \e[0m"
  echo -e "\e[43m 黄底 \e[0m"
  echo -e "\e[44m 蓝底 \e[0m"
  echo -e "\e[45m 紫底 \e[0m"
  echo -e "\e[46m 青底 \e[0m"
  echo -e "\e[47m 白底 \e[0m"
  echo
  echo -e "\e[90m 黑底黑字 \e[0m"
  echo -e "\e[91m 黑底红字 \e[0m"
  echo -e "\e[92m 黑底绿字 \e[0m"
  echo -e "\e[93m 黑底黄字 \e[0m"
  echo -e "\e[94m 黑底蓝字 \e[0m"
  echo -e "\e[95m 黑底紫字 \e[0m"
  echo -e "\e[96m 黑底青字 \e[0m"
  echo -e "\e[97m 黑底白字 \e[0m"
```


### tput {#tput}

tput 命令会利用 terminfo 数据库中的信息，来控制和更改我们的终端，比如控制光标、更改文本属性、控制屏幕，以及文本涂色。

-   tput setab: 用于设置背景色
-   tput setaf: 用于设置前景色
-   sgr0: 表示颜色重置

<!--listend-->

```bash
  #!/bin/bash
  BLACK=$(tput setaf 0)
  RED=$(tput setaf 1)
  GREEN=$(tput setaf 2)
  YELLOW=$(tput setaf 3)
  BLUE=$(tput setaf 4)
  MAGENTA=$(tput setaf 5)
  CYAN=$(tput setaf 6)
  WHITE=$(tput setaf 7)
  RES=$(tput sgr0) # clear

  echo -e "${RED}Red${RES}"
  echo -e "${GREEN}Green${RES}"
  echo -e "${YELLOW}Yellow${RES}"
  echo -e "${BLUE}Blue${RES}"
  echo -e "${MAGENTA}Magenta${RES}"
  echo -e "${CYAN}Cyan${RES}"
  echo -e "${WHITE}Cyan${RES}"
  echo -e "${WHITE}White${RES}"
```


## 参考 {#参考}

-   [shell echo 显示颜色](https://zhuanlan.zhihu.com/p/181609730)
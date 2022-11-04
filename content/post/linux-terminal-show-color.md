---
title: "Linux 终端输出颜色"
date: "2022-10-08 10:24:00"
lastmod: "2022-10-26 08:22:55"
categories: ["Linux"]
draft: false
---

## ANSI 转义序列 {#ansi-转义序列}

终端不仅能够显示程序的输出。它可以显示移动光标、为文本着色、清除整个屏幕，并且不仅仅是静态输出。比如颜色字体或者闪烁的光标或者是进度条。


## 配色方案 {#配色方案}

有两种配色方案广泛应用于终端中：

-   16 色 （8 背景 + 8 前景）前景即是字体本身的颜色
-   255 色


## 16 色 {#16-色}


### 示例 {#示例}

{{< figure src="https://raw.githubusercontent.com/daotoyi/picsbed/main/img/202210030952682.png" >}}

16 色的配色方案包含两个颜色设置，每个 8 色，一个是背景色一个是字体色（也即前景色）.

-   `\033[1;32;40m`
    -   \\033[ 是转义字符
    -   1 代表高亮
    -   32 代表前景色为绿色
    -   背景色为黑色


### 转义字符 {#转义字符}

可以有三种形式

-   十六进制：\x16[
-   Unicode：\u001b[
-   八进制：\\033[


### 样式 {#样式}

0（默认值）、1（高亮）、22（非粗体）

4（下划线）、24（非下划线）、 5（闪烁）

25（非闪烁）、7（反显）、27（非反显）


### 颜色设置 {#颜色设置}

前景色: 30（黑色）、31（红色）、32（绿色）、 33（黄色）、34（蓝色）、35（洋 红）、36（青色）、37（白色）

背景色: 40（黑色）、41（红色）、42（绿色）、 43（黄色）、44（蓝色）、45（洋 红）、46（青色）、47（白色）


## Colorama {#colorama}

－ 颜色输出的模块

```python
from colorama import init, Fore, Back, Style

# Initializes Colorama
init(autoreset=True)

print(Style.BRIGHT + Back.YELLOW + Fore.RED + "from colorama import init, Fore, Back, Style

# Initializes Colorama
init(autoreset=True)

print(Style.BRIGHT + Back.YELLOW + Fore.RED + "Colorama ")")
```

－ 变色函数

```python
background_color_dict={
    'BLACK':40,
    'RED':41,
    'GREEN':42,
    'YELLOW':43,
    'BLUE':44,
    'MAGENTA':45,
    'CYAN':46,
    'WHITE':47
}

text_color_dict={
    'BLACK':30,
    'RED':31,
    'GREEN':32,
    'YELLOW':33,
    'BLUE':34,
    'MAGENTA':35,
    'CYAN':36,
    'WHITE':37
}

style_dict={
    'normal':0,
    'bold':1,
    'light':2,
    'italicize':3,
    'underline':4,
    'blink':5
}

def set_text_color(str_text, style, text_color, background_color):
    str = str_text
    style_code = style_dict[style]
    text_color_code = text_color_dict[text_color]
    back_color_code = background_color_dict[background_color]
    print_text = f'\033[{style_code};{text_color_code};{back_color_code}m{str}\033[0m'
    return print_text
```


## 256 色 {#256-色}


### 示例 {#示例}

{{< figure src="https://raw.githubusercontent.com/daotoyi/picsbed/main/img/202210030953406.png" >}}

标注显示模式则是 38 或者 48 选择一个表名后面颜色代码是前景色还是背景色。

```python
print("\033[48;5;160m\033[38;5;231m背景前景修改ABCDE \033[38;5;226m前景修改ABCDE\033[0;0m")
```

-   输出一下所有的前景颜色

    ```python
      def print_colors_256(color_code):
        num1 = str(color_code)
        num2 = str(color_code).ljust(3, ' ')
        if color_code % 16 == 0:
            return(f"\033[38;5;{num1}m {num2} \033[0;0m\n")
        else:
            return(f"\033[38;5;{num1}m {num2} \033[0;0m")

    print("256 color scheme:")
    print('',end=' ')
    print(' '.join([print_colors_256(x) for x in range(256)]))
    ```


### 转义字符 {#转义字符}

和 16 色的是一样的：

-   十六进制：\x16[
-   Unicode：\u001b[
-   八进制：\\033[


## Ref {#ref}

-   [一个 print 函数，挺会玩啊？](https://mp.weixin.qq.com/s/B1HHiOAC3SOR83Xyx7uoAA)


## <span class="org-todo todo TODO">TODO</span>  {#d41d8c}
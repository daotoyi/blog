---
title: "Capslock+"
date: "2022-04-27 22:22:00"
lastmod: "2022-04-30 12:48:41"
categories: ["Tools"]
draft: false
---

## basic {#basic}

```cfg
[Keys]
caps_q=keyFunc_qbar

; -------------------------------
caps_a=keyFunc_moveWordLeft
caps_g=keyFunc_moveWordRight

caps_e=keyFunc_moveUp
caps_d=keyFunc_moveDown
caps_s=keyFunc_moveLeft
caps_f=keyFunc_moveRight

; -------------------------------
; select
caps_k=keyFunc_selectUp
caps_j=keyFunc_selectDown
caps_h=keyFunc_selectLeft
caps_l=keyFunc_selectRight

caps_n=keyFunc_selectWordLeft
caps_m=keyFunc_selectWordRight
; caps_dot=keyFunc_selectWordRight

caps_p=keyFunc_home
caps_semicolon=keyFunc_end

caps_c=keyFunc_copy_1
caps_v=keyFunc_paste_1

; -------------------------------
caps_f1=keyFunc_openCpasDocs
caps_f2=keyFunc_mathBoard
caps_f3=keyFunc_translate
caps_f4=keyFunc_winTransparent
caps_f5=keyFunc_reload
caps_f6=keyFunc_winPin
```


## advanced {#advanced}


### WinBind {#winbind}

`Capslock + Win + 0-9` 或 + `Capslock + LAlt + 0-9`
功能:绑定窗口到相应按键：

-   模式 1： 单击，绑定当前激活的窗口到相应按键
-   模式 2： 双击，追加绑定当前激活的窗口到相应按键
-   模式 3： 三击，绑定当前激活的窗口所属程序所拥有的所有窗口到相应按键


### Qbar {#qbar}

`Capslock + Q`

功能：弹出输入框，输入不同命令执行不同操作


### priority {#priority}

-   标签的优先级是：

[TabHotString] &gt; [QRun] &gt; [QWeb]


## Ref {#ref}

-   [Capslock+](https://capslox.com/capslock-plus/)
-   [基础功能](https://capslox.com/capslock-plus/#basicFunctions)
-   [Qbar](https://capslox.com/capslock-plus/#clQbar)
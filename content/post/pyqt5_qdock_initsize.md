---
title: "PyQt5 QDock 初始化"
date: "2023-10-06 18:24:00"
lastmod: "2023-10-06 18:25:57"
categories: ["Code"]
draft: false
---

### 0x00 前言

QDockWidget自带的很多方法无法在保证其可调整大小的情况下，设置其初始大小.

### 0x01 初始化后固定大小

-   exampleCode

``` python
from PySide2.QtWidgets import QDockWidget, QMainWindow
class UIMainWindow(QMainWindow):
    def __init__(self, *args, **kwargs):
        super(UIMainWindow, self).__init__(*args, **kwargs)
        wi = QDockWidget(self)
        wi.setFixedSize(50, 100)#width,heigth
```

### 0x02 初始化后可调大小

-   exampleCode

``` python
from PySide2.QtWidgets import QDockWidget, QTabWidget, QMainWindow
from PySide2.QtCore import QSize

class CTabWidget(QTabWidget):
    """重写其sizeHint函数，从而实现设置DockWidget初始大小"""
    def __init__(self):
        super(CTabWidget, self).__init__()

    def sizeHint(self):
        return QSize(160, 500)  #width, heigth

class UIMainWindow(QMainWindow):
    def __init__(self, *args, **kwargs):
        super(UIMainWindow, self).__init__(*args, **kwargs)
        wi = QDockWidget(self)
        tabWidget = CTabWidget()
        wi.setWidget(tabWidget)

```

reference: [PySide2/PyQt5 实现设置QDockWidget初始大小](https://blog.csdn.net/qq_23926575/article/details/106926495)
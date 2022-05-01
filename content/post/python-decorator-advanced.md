---
title: "Python 装饰器高级版"
description: "Python 类内定义装饰器并传递 self 参数"
date: "2022-04-16 20:56:00"
lastmod: "2022-04-30 12:46:09"
categories: ["Python"]
draft: false
---

## 基本装饰器 {#基本装饰器}


### 装饰不带参数的函数 {#装饰不带参数的函数}

```python
def clothes(func):
    def wear():
        print('Buy clothes!{}'.format(func.__name__))
        return func()
    return wear

@clothes
def body():
    print('The body feels could!')
```


### 装饰带一个参数的函数 {#装饰带一个参数的函数}

```python
def clothes(func):
    def wear(anything):            # 实际是定义一个anything参数，对应body函数参数
        print('Buy clothes!{}'.format(func.__name__))
        return func(anything)      # 执行func函数，并传入调用传入的anything参数
        # wear = func(anything)    # 在这一步，实际上可以看出来，为啥wear必须带参数，因为它就是func(anything)
    return wear
    # 所以clothes的结果是
    # clothes = wear = func(anything)
    # 不用语法糖的情况下就是
    # body = clothes(body)('hands')
    # 进一步证明：print(body.__name__)  显示的是wear函数

@clothes
def body(part):
    print('The body feels could!{}'.format(part))
```


### 装饰带不定长参数的函数 {#装饰带不定长参数的函数}

```python
def clothes(func):
    def wear(*args, **kwargs):
        print('Buy clothes!{}'.format(func.__name__))
        return func(*args, **kwargs)
    return wear

@clothes
def body(part):
    print('The body feels could!{}'.format(part))

@clothes
def head(head_wear, num=2):
    print('The head need buy {} {}!'.format(num, head_wear))
body('hands')
head('headdress')
```


### 装饰器带参数 {#装饰器带参数}

```python
# 把装饰器再包装，实现了seasons传递装饰器参数。

def seasons(season_type):
    def clothes(func):
        def wear(*args, **kwargs):
            if season_type == 1:
                s = 'spring'
            elif season_type == 2:
                s = 'summer'
            elif season_type == 3:
                s = 'autumn'
            elif season_type == 4:
                s = 'winter'
            else:
                print('The args is error!')
                return func(*args, **kwargs)
            print('The season is {}!{}'.format(s, func.__name__))
            return func(*args, **kwargs)
        return wear
    return clothes

@seasons(2)
def children():
    print('i am children')

children()
```


## 在类里定义装饰器，装饰本类内函数 {#在类里定义装饰器-装饰本类内函数}


### 把装饰器写在类里 {#把装饰器写在类里}

在类里面定义个函数，用来装饰其它函数，严格意义上说不属于类装饰器.

```python
class Buy(object):
    def __init__(self, func):
        self.func = func

    # 在类里定义一个函数
    def clothes(func):            # 这里不能用self,因为接收的是body函数
        # 其它都和普通的函数装饰器相同
        def ware(*args, **kwargs):
            print('This is a decrator!')
            return func(*args, **kwargs)
        return ware



@Buy.clothes
def body(hh):
    print('The body feels could!{}'.format(hh))

body('hh')
```


### 装饰器装饰同一个类里的函数 {#装饰器装饰同一个类里的函数}

```python
class Buy(object):
    def __init__(self):
        self.reset = True        # 定义一个类属性，稍后在装饰器里更改
        self.func = True

    # 在类里定义一个装饰器
    def clothes(func):    # func接收body
        def ware(self, *args, **kwargs):    # self,接收body里的self,也就是类实例
            print('This is a decrator!')
            if self.reset == True:        # 判断类属性
                print('Reset is Ture, change Func..')
                self.func = False        # 修改类属性
            else:
                print('reset is False.')

            return func(self, *args, **kwargs)

        return ware

    @clothes
    def body(self):
        print('The body feels could!')

b = Buy()    # 实例化类
b.body()     # 运行body
print(b.func)    # 查看更改后的self.func值，是False，说明修改完成
```


## 类装饰器 {#类装饰器}


### 定义一个类装饰器，装饰函数，默认调用\__call__方法 {#定义一个类装饰器-装饰函数-默认调用-call-方法}

```python
class Decrator(object):
    def __init__(self, func):                        # 传送的是test方法
        self.func = func

    def __call__(self, *args, **kwargs):      # 接受任意参数
            print('函数调用CALL')
            return self.func(*args, **kwargs)    # 适应test的任意参数

@Decrator                        # 如果带参数，init中的func是此参数。
def test(hh):
    print('this is the test of the function !',hh)
test('hh')
```


### 定义一个类装饰器，装饰类中的函数，默认调用\__get__方法 {#定义一个类装饰器-装饰类中的函数-默认调用-get-方法}

`实际上把类方法变成属性了`

```python
class Decrator(object):
    def __init__(self, func):
        self.func = func

    def __get__(self, instance, owner):
        '''
        instance:代表实例，sum中的self
        owner：代表类本身，Test类

        '''
        print('调用的是get函数')
        return self.func(instance)     # instance就是Test类的self


class Test(object):
    def __init__(self):
        self.result = 0

    @Decrator
    def sum(self):
        print('There is the Func in the Class !')

t = Test()
print(t.sum)            # 众所周知，属性是不加括号的,sum真的变成了属性
```


### 做一个求和属性 sum，统计所有输入的数字的和 {#做一个求和属性-sum-统计所有输入的数字的和}

```python
class Decrator(object):
    def __init__(self, func):
        self.func = func

    def __get__(self, instance, owner):
        print('调用的是get函数')
        return self.func(instance)

class Test(object):
    def __init__(self, *args, **kwargs):
        self.value_list = []
        if args:
            for i in args:
                if str(i).isdigit():
                    self.value_list.append(i)
        if kwargs:
            for v in kwargs.values():
                if str(v).isdigit():
                    self.value_list.append(v)
    @Decrator
    def sum(self):
        result = 0
        print(self.value_list)
        for i in self.value_list:
            result += i

        return result
t = Test(1,2,3,4,5,6,7,8,i=9,ss=10,strings = 'lll')

print(t.sum)
```


## 装饰器装饰类 {#装饰器装饰类}


### 装饰类 {#装饰类}

```python
instances = {}

def singleton(cls):
    def get_instance(*args, **kw):
        cls_name = cls.__name__
        print('===== 1 ====')
        if not cls_name in instances:
            print('===== 2 ====')
            instance = cls(*args, **kw)
            instances[cls_name] = instance
        return instances[cls_name]
    return get_instance

@singleton
class User:
#     _instance = None

    def __init__(self, name):
        print('===== 3 ====')
        self.name = name

User("daoyi")
```


### [给类的所有方法加装饰器](https://blog.csdn.net/weixin_36179862/article/details/102829018) {#给类的所有方法加装饰器}

如果要对类的所有方法加上装饰器，只需要重写该类的\__getattribute__方法即可。

-   如果某个类定义了\__getattribute__() 方法，在 每次引用属性或方法名称时 Python 都调用它
-   如果某个类定义了 __getattr__() 方法，Python 将只在正常的位置查询属性时才会调用它
-   如果定义了 __getattr__() 或 __getattribute__() 方法， __dir__() 方法将非常有用。通常，调用 dir(x) 将只显示正常的属性和方法。
-   如果\__getattr()\__方法动态处理 color 属性， dir(x) 将不会将 color 列为可用属性。


### [通过 decorators=[, ]的形式](https://www.cnblogs.com/yuanyongqiang/p/10447447.html) {#通过-decorators-的形式}

-   给类添加装饰器有多种方法:
    -   可以在类中的某个方法上边直接@添加,这个粒度细.无需详细介绍
    -   也可以在类中通过 decorators=[, ]的形式添加,这样的话,类中的所有方法都会被一次性加上装饰器,粒度粗:

-   列表中多个装饰器的话,装饰器的添加顺序:
    -   列表中:　　　　从前 -&gt; 往后,对应:
    -   函数上边:　　　从下 -&gt; 到上


## [wraps 装饰器](https://zhuanlan.zhihu.com/p/269012332) {#wraps-装饰器}

在 functools 标准库中有提供一个 wraps 装饰器


## [内置装饰器：property](https://zhuanlan.zhihu.com/p/269012332) {#内置装饰器-property}


## Ref {#ref}

-   [Python装饰器高级版—Python类内定义装饰器并传递self参数](https://blog.51cto.com/yishi/2354752)
-   [Python 装饰器装饰类中的方法](https://www.cnblogs.com/xieqiankun/p/python_decorate_method.html)
-   [补了 Python 装饰器的八种写法](https://zhuanlan.zhihu.com/p/269012332)
-   [通过decorators = [,] 的形式给类中的所有方法添加装饰器](https://www.cnblogs.com/yuanyongqiang/p/10447447.html)
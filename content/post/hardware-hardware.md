---
title: "Hardware"
date: "2022-09-25 12:05:00"
lastmod: "2022-10-03 15:59:37"
categories: ["Hardware"]
draft: false
---

## 器件温度 {#器件温度}


### Ta {#ta}

Actual ambient temperature 实际环境温度。

Ta 是指驱动器工作的环境温度。


### Tc {#tc}

Surface Temperature of body 物体的表面温度。

Tc 为驱动器的外壳允许的最高温度。


### Tj {#tj}

Operating Junction Temperature Range。

Tj 表示晶体管的结温。


## 哈佛结构 {#哈佛结构}

{{< figure src="https://img-blog.csdnimg.cn/7c9a28083e274fc5b18b08b5c8eeeaad.png?x-oss-process=image" >}}

哈佛结构(Harvard architecture)是一种将程序指令储存和数据储存分开的存储器结构。中央处理器首先到程序指令储存器中读取程序指令内容，解码后得到数据地址，再到相应的数据储存器中读取数据，并进行下一步的操作（通常是执行）。程序指令储存和数据储存分开，数据和指令的储存可以同时进行，可以使指令和数据有不同的数据宽度

哈佛结构的微处理器通常具有较高的执行效率。其程序指令和数据指令分开组织和储存的，执行时可以预先读取下一条指令。目前使用哈佛结构的中央处理器和微控制器有很多


## 冯.诺伊曼结构 {#冯-dot-诺伊曼结构}

{{< figure src="https://img-blog.csdnimg.cn/ee45244c1e164647855aefec965b6434.png?x-oss-process=image" >}}

冯.诺伊曼结构（von Neumann architecture），也称普林斯顿结构，是一种将程序指令存储器和数据存储器合并在一起的电脑设计概念结构。该结构隐约指导了将储存装置与中央处理器分开的概念，因此依该结构设计出的计算机又称储存程式型电脑。


## CPU、MCU、MPU、DSP、FPGA {#cpu-mcu-mpu-dsp-fpga}


### CPU {#cpu}

中央处理器，简称 CPU（Central Processing Unit）.

中央处理器主要包括两个部分:

-   即控制器
-   运算器

其中还包括高速缓冲存储器及实现它们之间联系的数据、控制的总线。

CPU(Central Processing Unit，中央处理器)发展出来三个分枝:

-   DSP(Digital Signal Processing/Processor，数字信号处理)
-   MCU(Micro Control Unit，微控制器单元)
-   MPU(Micro Processor Unit，微处理器单元)


### MCU {#mcu}

MCU(MicroControllerUnit)中文名称为微控制单元，又称单片微型计算机.

将计算机的 CPU、RAM、ROM、定时数器和多种 I/O 接口集成在一片芯片上，形成芯片级的计算机，为不同的应用场合做不同组合控制。


### MPU {#mpu}

微处理器单元(Micro Processor Unit， MPU).

把很多 CPU 集成在一起并行处理数据的芯片。

MCU 集成了 RAM，ROM 等设备;MPU 则不集成这些设备，是高度集成的通用结构的中央处理器矩阵，也可以认为是去除了集成外设的 MCU。


### DSP {#dsp}

DSP(DigitalSignalProcessing)，数字信号处理，简称 DSP。

DSP 是用数值计算的方式对信号进行加工的理论和技术。

另外 DSP 也是 DigitalSignalProcessor 的简称，即数字信号处理器，它是集成专用计算机的一种芯片


### FPGA {#fpga}

FPGA(Field－Programmable Gate Array)，即现场可编程门阵列.

作为专用集成电路(ASIC)领域中的一种半定制电路而出现的，既解决了定制电路的不足，又克服了原有可编程器件门电路数有限的缺点。


### Ref {#ref}

-   [DSP、MCU、MPU、SOC、FPGA、ARM等概念](https://blog.csdn.net/weixin_43354298/article/details/121074421)


## ECC {#ecc}

ECC 是“Error Checking and Correcting”的简写，中文名称是“错误检查和纠正”。

ECC 是在奇偶校验的基础上发展而来。


## 运放（OP AMP） {#运放-op-amp}

运算放大器（简称运放），它的英文全称是 Operation Amplifier,简写为 OP AMP。

运算放大器的初衷是用于执行数学计算，比如加、减、乘、除、函数运算等。在当前的技术条件下，运算放大器的数学运算功能已不再突出，现在主要应用于 **信号放大** 及 **有源滤波器** 设计。


## 纹波 {#纹波}

纹波是由于直流稳定电源的电压波动而造成的一种现象，因为直流稳定电源一般是由交流电源经整流稳压等环节而形成的，这就不可避免地在直流稳定量中多少带有一些交流成份，这种叠加在直流稳定量上的交流分量就称之为纹波。

纹波的表示方法可以用有效值或峰值来表示，可以用绝对量，也可以用相对对量来表示。例如一个电源工作在稳压状态，其输出为 100V/5A，测得纹波的有效值为 10mV，这 10mV 就是 **纹波的绝对量** ，而 **相对量即纹波系数** =纹波电压/输出电压=10mv/100V=0.01%，即等于万分之一。


## 光耦 {#光耦}


### 作用 {#作用}

光耦一般用于信号的隔离。当两个电路的电源参考点不相关时，使用光耦可以保证在两边不共地的情况下，完成信号的传输。

光耦属于流控型元件，以光为媒介传输信号：电光电，输入端是发光二极管，输出端是光敏半导体。

光耦的核心应用是隔离作用，常用于输入与输出之间无共地的系统。所以输入与输出之间的耐压可达上千伏特。


### 原理 {#原理}

光耦可以看做是用输入端的发光管的光强度在控制输出端的电流；而输入端的发光管是个二极管，也就是用输入端的电流去控制输出端的电流，功能上和三级管是等效的，而由于中间的控制是靠光传输，所以输入端和输出端可以没有固定的电压差，也即相互隔离。

和三极管的特性一样，光耦可以传输模拟信号也可以传输数字信号；也有饱和区、放大区、截止区。


### 保护 {#保护}

实际使用时，一般光耦的输入端需要加一些保护电路，以免输入信号异常导致光耦损坏.


### 分类 {#分类}

光耦分为线性光耦和非线性光耦。实际常规应用中线性光耦较多，因为线性光耦可以替代非线性光耦。

-   线性光耦主要用于模拟信号的传递，输出相当于一个可变电阻。
-   非线性光耦主要用于开关信号（或数字信号）的传递。
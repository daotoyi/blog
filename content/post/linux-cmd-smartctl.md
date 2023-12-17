---
title: "Linux cmd smartctl"
date: "2023-12-17 12:27:00"
lastmod: "2023-12-17 12:30:41"
categories: ["Linux"]
draft: false
---

## 常用命令 {#常用命令}

```bash
smartctl -i <device>  #显示设备的身份信息，检查硬盘是否打开了SMART支持。
# SMART support is: Enabled，说明硬盘支持SMART。
# Disabled，使用以下启用SMART。
smartctl --smart=on --offlineauto=on --saveauto=on <device>

smartctl -s on <device>   # 如果没有打开SMART技术，使用该命令打开SMART技术。

smartctl -a <device>          # 显示硬盘SMART的全部信息。检查该设备是否已经打开SMART技术。
smartctl -H <device>          #查看硬盘的健康状况。一般看不出来问题，没啥用。
smartctl -l selftest <device> #显示硬盘测试信息。
smartctl -l error <device>    #显示硬盘历史错误信息。
smartctl -A <device>           #显示设备SMART厂商属性和值。

# 对硬盘进行检测 手工对硬盘进行测试的方法有以下四种：
smartctl -t short <device>     #后台检测硬盘，消耗时间短
smartctl -t long <device>      # 后台检测硬盘，消耗时间长
smartctl -C -t short <device>  #前台检测硬盘，消耗时间短
smartctl -C -t long <device>   #前台检测硬盘，消耗时间长
```


## 处理流程 {#处理流程}

-   首先通过 smartctl -H /dev/sda 检查磁盘健康状态
-   然后 smartctl -a /dev/sda 查看磁盘详细情况
-   再对磁盘进行短期测试 smartctl -t short /dev/sda
-   最后查看磁盘测试结果 smartctl -l selftest /dev/sda
-   基本磁盘健康状态就可以定位出来


## SMART 信息解读 {#smart-信息解读}

硬盘 SMART 检测的 ID 代码以两位十六进制数表示（括号里对应的是十进制数）硬盘的各项检测参数。目

| ID      | ATTRIBUTES_NAME         | NOTE                             |
|---------|-------------------------|----------------------------------|
| 01（001） | Raw_Read_Error_Rate     | 底层数据读取错误率               |
| 04（004） | Start_Stop_Count        | 启动/停止计数                    |
| 05（005） | Reallocated_Sector_Ct   | 重映射扇区数                     |
| 09（009） | Power_On_Hours          | 通电时间累计，出厂后通电的总时间，一般磁盘寿命三万小时 |
| 0A（010） | Spin_Retry_Count        | 主轴起旋重试次数（即硬盘主轴电机启动重试次数） |
| 0B（011） | Calibration_Retry_Count | 磁盘校准重试次数                 |
| 0C（012） | Power_Cycle_Count       | 磁盘通电次数                     |
| C2（194） | Temperature_Celsius     | 温度                             |
| C7（199） | UDMA_CRC_Error_Count    | 奇偶校验错误率                   |
| C8（200） | Write_Error_Rate:       | 写错误率                         |
| F1（241） | Total_LBAs_Written      | 表示磁盘自出厂总共写入的的数据，单位是 LBAS=512Byte |
| F2（242） | Total_LBAs_Read         | 表示磁盘自出厂总共读取的数据，单位是 LBAS=512Byte |


## 主要检测项目 {#主要检测项目}


### Media_Wearout_Indicator {#media-wearout-indicator}

使用耗费。100 为没有任何耗费; 表示 SSD 上 NAND 的擦写次数的程度，初始值为 100，随着擦写次数的增加，开始线性递减，递减速度按照擦写次数从 0 到最大的比例。一旦这个值降低到 1，就不再降了，同时表示 SSD 上面已经有 NAND 的擦写次数到达了最大次数。这个时候建议需要备份数据，以及更换 SSD。


### Reallocated_Sector_Ct {#reallocated-sector-ct}

重映射扇区计数. 出厂后产生的坏块个数, 初始值为 100，如果有坏块，从 1 开始增加，每 4 个坏块增加 1

这项参数的数据值直接表示已经被重映射扇区的数量，当前值则随着数据值的增加而持续下降。

当硬盘的某扇区持续出现读/写/校验错误时，硬盘固件程序会将这个扇区的物理地址加入缺陷表(G-list)，将该地址重新定向到预先保留的备用扇区并将其中的数据一并转移，这就称为重映射。执行重映射操作后的硬盘在 Windows 常规检测中是无法发现不良扇区的，因其地址已被指向备用扇区，这等于屏蔽了不良扇区。


### Host_Writes_32MiB {#host-writes-32mib}

已写 32MiB, 每写入 65536 个扇区 raw value 增加 1。这个扇区还是个数量单位，512 字节


### Available_Reservd_Space {#available-reservd-space}

SSD 上剩余的保留空间, 初始值为 100，表示 100%，阀值为 10，递减到 10 表示保留空间已经不能再减少
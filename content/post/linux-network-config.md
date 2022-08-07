---
title: "Linux network"
lastmod: "2022-08-01 22:00:27"
categories: ["Linux"]
draft: true
---

## networking {#networking}

/etc/network

```cfg
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
  address 193.100.100.250
  netmask 255.255.255.0

auto eth1
iface eth1 inet static
  address 192.168.1.248
  netmask 255.255.255.0
```


## systemd-networkd {#systemd-networkd}

/etc/systemd/network

10-wired-dhcp.network

```cfg
[Match]
Name=eth0

[Network]
DHCP=yes

[DHCP]
RouteMetric=0
```

20-wired-static.network

```cfg
[Match]
Name=eth0

[Network]
Address=192.168.1.100/24
DNS=192.168.1.1
DNS=114.114.114.114

[Route]
Gateway=192.168.1.1
Metric=100
```

文件名前面的数字表示优先级，数字越小优先级越高，因此上述两个配置文件会优先使用 dhcp 网络配置。
---
title: "Linux NetworkManager"
date: "2023-08-02 11:21:00"
lastmod: "2023-08-02 11:21:46"
categories: ["Linux"]
draft: false
---

## 基本配置 {#基本配置}

```bash
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet static
  address 192.168.0.42
  network 192.168.0.0
  netmask 255.255.255.0
  broadcast 192.168.0.255
  gateway 192.168.0.1

auto eth5
iface eth5 inet dhcp
```


## 增加路由 {#增加路由}

```bash
auto eth0
iface eth0 inet static
    address 192.168.1.42
    network 192.168.1.0
    netmask 255.255.255.128
    broadcast 192.168.1.0
    up route add -net 192.168.1.128 netmask 255.255.255.128 gw 192.168.1.2
    up route add default gw 192.168.1.200
    down route del default gw 192.168.1.200
    down route del -net 192.168.1.128 netmask 255.255.255.128 gw 192.168.1.2
```


## 多个 IP {#多个-ip}

```bash
auto eth0 eth0:1
iface eth0 inet static
    address 192.168.0.100
    network 192.168.0.0
    netmask 255.255.255.0
    broadcast 192.168.0.255
    gateway 192.168.0.1
iface eth0:1 inet static    #多配置的网口
    address 192.168.0.200
    network 192.168.0.0
    netmask 255.255.255.0
```
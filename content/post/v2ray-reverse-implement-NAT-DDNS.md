---
title: "v2ray 反向代理/内网穿透"
date: "2022-04-01 21:50:00"
lastmod: "2022-04-30 12:50:45"
tags: ["v2ray"]
categories: ["VPS"]
draft: false
---

## 说明示例 {#说明示例}


### 约定 {#约定}

约定有 3 种设备，名为 A, B, C。（这 3 种的每一种设备都可以是一台或多台）

-   A 为不具备公网 IP 的内网服务器，运行了 NAS 或个人网盘等；
-   B 为具有公网 IP 的服务器，如平常我们购买的 VPS；
-   C 为想要访问 NAS 或私有网盘的设备


### 过程 {#过程}

-   A 会主动向 B 发起请求，建立起一个连接；通过 A 向 B 建立的连接转发给 A(即 B 反向连接了 A)；
    -   A 需要一个 outbound ( **vmess** )
        -   （A 的 outbound 是连接到 B 的 inbound，具备 inbound 和 outbound 的协议有 3 种：VMess, Shadowsocks 和 Socks。）
    -   A 来访问最终的服务器(私有网盘)，所以 A 还需有一个 outbound( **freedom** )。
    -   B 需要一个 inbound
-   C 向 B 发起请求
    -   B 还需要一个 inbound，( **dokodemo-door** )
        -   （ B 的 inbound 要接受不是来自 V2 的流量，只能是任意门 dokodemo-door）
    -   C 不运行 V2


### 总结 {#总结}

-   A 需要两个 outbound（VMess 和 freedom）
-   B 需要两个 inbound(VMess 和 dokodemo-door)。
-   然后为了让 A 能够主动连接 B，A 需要配置反向代理(reverse)；
-   同样的，为了能够让 B 反向连接 A，B 也需要配置反向代理(reverse)。

    <https://www.bookset.io/uploads/projects/v2ray-guide/1e9b7ada5a0a68d3938e9d5a7d2c658e.bmp>


## 配置 {#配置}


### A {#a}

```cfg
{
  "reverse":{
    // 这是 A 的反向代理设置，必须有下面的 bridges 对象
    "bridges":[
      {
        "tag":"bridge", // 关于 A 的反向代理标签，在路由中会用到
        "domain":"private.cloud.com" // A 和 B 反向代理通信的域名，可以自己取一个，可以不是自己购买的域名，但必须跟下面 B 中的 reverse 配置的域名一致
      }
    ]
  },
  "outbounds": [
    {
      //A连接B的outbound
      "tag":"tunnel", // A 连接 B 的 outbound 的标签，在路由中会用到
      "protocol":"vmess",
      "settings":{
        "vnext":[
          {
            "address":"serveraddr.com", // B 地址，IP 或 实际的域名
            "port":16823,
            "users":[
              {
                "id":"b831381d-6324-4d53-ad4f-8cda48b30811",
                "alterId":64
              }
            ]
          }
        ]
      }
    },
    // 另一个 outbound，最终连接私有网盘
    {
      "protocol":"freedom",
      "settings":{
      },
      "tag":"out"
    }
  ],
  "routing":{
    "rules":[
      {
        // 配置 A 主动连接 B 的路由规则
        "type":"field",
        "inboundTag":[
          "bridge"
        ],
        "domain":[
          "full:private.cloud.com"
        ],
        "outboundTag":"tunnel"
      },
      {
        // 反向连接访问私有网盘的规则
        "type":"field",
        "inboundTag":[
          "bridge"
        ],
        "outboundTag":"out"
      }
    ]
  }
}
```


### B {#b}

```cfg
{
  "reverse":{  //这是 B 的反向代理设置，必须有下面的 portals 对象
    "portals":[
      {
        "tag":"portal",
        "domain":"private.cloud.com"        // 必须和上面 A 设定的域名一样
      }
    ]
  },
  "inbounds": [
    {
      // 接受 C 的inbound
      "tag":"external", // 标签，路由中用到
      "port":80,
      // 开放 80 端口，用于接收外部的 HTTP 访问
      "protocol":"dokodemo-door",
        "settings":{
          "address":"127.0.0.1",
          "port":80, //假设 NAS 监听的端口为 80
          "network":"tcp"
        }
    },
    // 另一个 inbound，接受 A 主动发起的请求
    {
      "tag": "tunnel",// 标签，路由中用到
      "port":16823,
      "protocol":"vmess",
      "settings":{
        "clients":[
          {
            "id":"b831381d-6324-4d53-ad4f-8cda48b30811",
            "alterId":64
          }
        ]
      }
    }
  ],
  "routing":{
    "rules":[
      {  //路由规则，接收 C 请求后发给 A
        "type":"field",
        "inboundTag":[
          "external"
        ],
        "outboundTag":"portal"
      },
      {  //路由规则，让 B 能够识别这是 A 主动发起的反向代理连接
        "type":"field",
        "inboundTag":[
          "tunnel"
        ],
        "domain":[
          "full:private.cloud.com"
        ],
        "outboundTag":"portal"
      }
    ]
  }
}
```


### Ref {#ref}

-   [反向代理/内网穿透](https://www.bookset.io/read/v2ray-guide/94bb3d54ac5738ed.md)
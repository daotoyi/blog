---
title: "v2ray 混合代理和反代流量"
date: "2022-05-03 11:14:00"
lastmod: "2022-05-07 06:59:14"
tags: ["NAT-DDNS"]
categories: ["VPS"]
draft: false
---

## 入门：微软远程桌面反代 {#入门-微软远程桌面反代}


### 需要反代的 A {#需要反代的-a}

```cfg
{
    "reverse": {
        "bridges": [
            {
                "tag": "remote_desktop_bridge_01",
                "domain": "rd-bridge-01.zhouxuebin.club"
            }
        ]
    },
    "outbounds": [
        {
            "tag": "tunnel",
            "protocol": "vmess",
            "settings": {
                "domainStrategy": "UseIPv4",
                "vnext": [
                    {
                        "address": "ali01.ccp.zhouxuebin.club",
                        "port": 2021,
                        "users": [
                            {
                                "id": "00112233-4455-6677-8899-aabbccddeeff",
                                "alterId": 1,
                                "security": "auto"
                            }
                        ]
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp",
                "tcpSettings": {}
            }
        },
        {
            "tag": "bridge_out",
            "protocol": "freedom",
            "settings": {}
        }
    ],
    "routing": {
        "rules": [
            {
                "type": "field",
                "inboundTag": ["remote_desktop_bridge_01"],
                "domain": ["full:rd-bridge-01.zhouxuebin.club"],
                "outboundTag": "tunnel"
            },
            {
                "type": "field",
                "inboundTag": ["remote_desktop_bridge_01"],
                "outboundTag": "bridge_out"
            }
        ]
    }
}
```

bridges 的 domain 是随便取的，只要运行反代的服务器能够区分开就好，不需要真实存在。而 outbounds 有两个，一个走的是本地协议的，也就是 bridge_out

这台机子承载了两个方向的流量，一个是正向流量，另一个是反向流量，v2ray 靠的是 domain 字段队两个方向的流量进行区分的。

正向流量是指：VPS 主机（ali01.ccp.zhouxuebin.club:2021） -&gt; 反代机子（inbound tag：remote_desktop_bridge_01）-&gt; v2ray 路由（outbound tag：bridge_out） -&gt; 本地协议（127.127.1.1:3389）
反向流量是指：本地协议的响应数据 -&gt; 反代机子（inbound tag：remote_desktop_bridge_01，domain：rd-bridge-01.zhouxuebin.club） -&gt; v2ray 路由（outbound tag：tunnel） -&gt; VPS 主机


### VPS {#vps}

PS 负责接受两个方向的连接，以及中转两个方向的流量，对应的 config.json：

```cfg
{
    "reverse": {
        "portals": [
            {
                "tag": "remote_desktop_portal_01",
                "domain": "rd-bridge-01.zhouxuebin.club"
            }
        ]
    },
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": 2021,
            "listen": "0.0.0.0",
            "tag": "bridge_in",
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "00112233-4455-6677-8899-aabbccddeeff",
                        "level": 0,
                        "alterId": 1,
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "settings": {},
            "tag": "direct"
        },
        {
            "protocol": "blackhole",
            "settings": {},
            "tag": "blocked"
        }
    ],
    "routing": {
        "domainStrategy": "IPOnDemand",
        "rules": [
            {
                "type": "field",
                "inboundTag": ["bridge_in"],
                "outboundTag": "remote_desktop_portal_01"
            }
        ]
    }
}
```

VPS 的工作其实也挺简单的，就一个 inbound 负责监听和建立反代机子和访问反代的机子两者的连接，实现流量交换，甚至不需要 outbound。routing 就只要把 inbound 流量转发到 portal 就好了。这里重点放在 reverse 设置上，portals 里面的 domain 必须与反代主机上填的 domain 一致，无论这个 domain 是否实际存在。如果需要区分反代机子和访问反代机子的访问，可以在 inbound 和 routing 里面调整。

直接通过 VPS 的 IP 访问反代机子的远程桌面，在 inbound 增加个任意门协议负责监听 3389 端口，把流量转发到 portal 就行了。这样访问反代（远程桌面）的机子可以直接通过 VPS 的 IP 或者域名进行连接，就不需要本地再跑 v2ray 了。例子见入门 2，这个例子就直接在 VPS 监听。


### 访问反代的 C {#访问反代的-c}

```cfg
{
    "inbounds": [
        {
            "protocol": "dokodemo-door",
            "listen": "127.127.1.1",
            "port": 3389,
            "settings": {
                "address": "127.127.1.1",
                "port": 3389,
                "protocol": "tcp"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "vmess",
            "settings": {
                "domainStrategy": "UseIPv4",
                "vnext": [
                    {
                        "address": "ali01.ccp.zhouxuebin.club",
                        "port": 2021,
                        "users": [
                            {
                                "id": "00112233-4455-6677-8899-aabbccddeeff",
                                "alterId": 1,
                                "security": "auto"
                            }
                        ]
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp"
            }
        }
    ]
}
```

具体来说，就是负责把访问本地 127.127.1.1:3389（这里是 listen 的 IP）的流量封装到反代的机子上，按照反代机子的本地协议转发到 127.127.1.1:3389（这里是 settings 里面的 address）。


## 入门：ssh 反代 {#入门-ssh-反代}

用任意门协议直接在 VPS 上监听反代连接，这样就不需要在访问反代的电脑上运行 v2ray 了。

注意：实际上这么做是非常危险的，直接把 ssh 访问暴露在公网非常容易收到攻击。假如该机子的 root 密码是简单的 123456，那么其他人就可以轻易地登上服务器并运行 rm -rf /。如果确定要这么做，建议把密码登录关了，只留密钥登录。


### 需要反代的 A {#需要反代的-a}

```cfg
{
  "reverse": {
    "bridges": [
      {
        "tag": "ssh_rev_br_01",
        "domain": "ssh-rev-01.zhouxuebin.club"
      }
    ]
  },
  "log": {
    "access": "",
    "error": "",
    "loglevel": "warning"
  },
  "inbounds": [
  ],
  "outbounds": [
    {
      "tag": "tunnel",
      "protocol": "vmess",
      "settings": {
        "domainStrategy": "UseIPv4",
        "vnext": [
          {
            "address": "ali01.ccp.zhouxuebin.club",
            "port": 2021,
            "users": [
              {
                "id": "00112233-4455-6677-8899-aabbccddeeff",
                "alterId": 1,
                "security": "auto"
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "tcp"
      }
    },
    {
      "tag": "direct",
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag": "block",
      "protocol": "blackhole",
      "settings": {}
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "inboundTag": ["ssh_rev_br_01"],
        "domain": ["ssh-rev-01.zhouxuebin.club"],
        "outboundTag": "tunnel"
      },
      {
        "type": "field",
        "inboundTag": ["ssh_rev_br_01"],
        "outboundTag": "direct"
      }
    ]
  }
}
```

一个 bridge，两个 outbound（direct 和 tunnel），两条 routing 规则。bridges 的 domain 依然是不必存在的，outbound 的 address 填的是自己 VPS 的 IP 或域名。


### VPS {#vps}

```cfg
{
    "reverse": {
        "portals": [
            {
                "tag": "ssh_rev_portal01",
                "domain": "ssh-rev-01.zhouxuebin.club"
            }
        ]
    },
    "log": {
        "access": "",
        "error": "",
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": 2021,
            "listen": "0.0.0.0",
            "tag": "bridge_in",
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "00112233-4455-6677-8899-aabbccddeeff",
                        "alterId": 1,
                        "level": 0,
                        "email": "ssh01@user.com"
                    }
                ]
            },
            "streamSettings": {
                "network": "tcp"
            }
        },
        {
            "protocol": "dokodemo-door",
            "tag": "ssh_in",
            "listen": "0.0.0.0",
            "port": 4001,
            "settings": {
                "address": "127.0.0.1",
                "port": 22,
                "protocol": "tcp"
            }
        }
    ],
    "outbounds": [],
    "routing": {
        "rules": [
            {
                "type": "field",
                "inboundTag": ["bridge_in"],
                "outboundTag": "ssh_rev_portal01"
            },
            {
                "type": "field",
                "inboundTag": ["ssh_in"],
                "outboundTag": "ssh_rev_portal01"
            }
        ]
    }
}
```

使用方式：ssh username@vps.domain -p 4001，这样就相当于在反代的机子上运行 ssh username@127.0.0.1 -p 22。


## 进阶：代理与反代流量的混合 {#进阶-代理与反代流量的混合}


### inbounds {#inbounds}

inbounds：这里的 client_traffic_mix 同时承载了反向代理和普通代理的流量。

```cfg
{
    "inbounds": [
        {
            "tag": "client_traffic_mix",
            "listen": "127.0.0.1",
            "port": 2019,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "00112233-4455-6677-8899-aabbccddeeff",
                        "alterId": 1,
                        "level": 0,
                        "email": "whatever@it.is"
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                    "path": "/ray"
                }
            },
            "sniffing": {
                "enabled": "true",
                "destOverride": [
                    "http",
                    "tls"
                ]
            }
        }
    ]
}
```


### routing {#routing}

负责区分两个代理的流量


#### 采用的是分 IP 的方案 {#采用的是分-ip-的方案}

这里根据访问的 IP 进行流量区分，也就是说访问 127.127.1.1 的流量转发到反代的 tag，从反代的机子出，其他流量都直接从 VPS 出。

```cfg
{
    "routing": {
        "domainStrategy": "IPOnDemand",
        "rules": [
            {
                "type": "field",
                "inboundTag": ["client_traffic_mix"],
                "ip": [
                    "127.127.1.1"
                ],
                "outboundTag": "remote_desktop_portal_01"
            },
            {
                "type": "field",
                "inboundTag": ["client_traffic_mix"],
                "outboundTag": "direct"
            }
        ]
    }
}
```


#### 分用户的方案 {#分用户的方案}

直接把 email 为 whatever@it.is 用户的所有流量转发到反代的 portal 了，其他的就直接走 outbound tag 为 direct 的代理流量

```cfg
{
    "routing": {
        "domainStrategy": "IPOnDemand",
        "rules": [
            {
                "type": "field",
                "user": ["whatever@it.is"],
                "outboundTag": "remote_desktop_portal_01"
            },
            {
                "type": "field",
                "inboundTag": ["client_traffic_mix"],
                "outboundTag": "direct"
            }
        ]
    }
}
```


## ssh 远程登陆内网 {#ssh-远程登陆内网}

反向代理建立成功后：

1.  设置系统代理后可以直接访问内网。
2.  通过命令行设置访问代理

    ```bash
    ssh root@172.16.254.xxx -o ProxyCommand='nc -x 127.0.0.1:10808 %h %p'
    # -o 参数是配置的系统代理
    ```


## Ref {#ref}

-   [v2ray反向代理实战-混合代理和反代流量！！！](https://www.zhouxuebin.club/blog/2021/07/15/v2ray-reverse/)
-   [使用v2ray进行反向代理-内网穿透](http://www.hellosong.top/2021/07/11/%E4%BD%BF%E7%94%A8v2ray%E8%BF%9B%E8%A1%8C%E5%8F%8D%E5%90%91%E4%BB%A3%E7%90%86-%E5%86%85%E7%BD%91%E7%A9%BF%E9%80%8Fv/)
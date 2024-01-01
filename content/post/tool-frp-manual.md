---
title: "FRP"
date: "2024-01-01 16:46:00"
lastmod: "2024-01-01 16:46:55"
categories: ["Tools"]
draft: false
---

## Fast Reverse Proxy {#fast-reverse-proxy}

（Fast Reverse Proxy）


## frps {#frps}


### 常用配置 {#常用配置}

```cfg
[common]
# Frp 服务器监听的端口，默认为 7000，这里改成 7001
bind_port = 7001
# 授权码，请使用更复杂和安全的令牌
token = 123456

# Frp 管理后台端口，按需更改，默认为 7500
dashboard_port = 7500
# Frp 管理后台的用户名
dashboard_user = admin
# Frp 管理后台的密码，请设置为强密码
dashboard_pwd = admin
# 启用 Prometheus 监控
enable_prometheus = true

# Frp 日志配置
log_file = /var/log/frps.log
# 日志级别，可以设置为 debug、info、warn、error，默认为 info
log_level = info
# 日志最大保存天数
log_max_days = 3
```


### 完整配置 {#完整配置}

```cfg
# A literal address or host name for IPv6 must be enclosed
# in square brackets, as in "[::1]:80", "[ipv6-host]:http" or "[ipv6-host%zone]:80"
# For single "bind_addr" field, no need square brackets, like "bind_addr = ::".
bindAddr = "0.0.0.0"
bindPort = 7000

# udp port used for kcp protocol, it can be same with 'bind_port'.
# if not set, kcp is disabled in frps.
kcpBindPort = 7000

# udp port used for quic protocol.
# if not set, quic is disabled in frps.
# quicBindPort = 7002

# Specify which address proxy will listen for, default value is same with bind_addr
# proxy_bind_addr = "127.0.0.1"

# quic protocol options
# transport.quic.keepalivePeriod = 10
# transport.quic.maxIdleTimeout = 30
# transport.quic.maxIncomingStreams = 100000

# Heartbeat configure, it's not recommended to modify the default value
# The default value of heartbeat_timeout is 90. Set negative value to disable it.
# transport.heartbeatTimeout = 90

# Pool count in each proxy will keep no more than maxPoolCount.
transport.maxPoolCount = 5

# If tcp stream multiplexing is used, default is true
# transport.tcpMux = true

# Specify keep alive interval for tcp mux.
# only valid if tcpMux is true.
# transport.tcpMuxKeepaliveInterval = 60

# tcpKeepalive specifies the interval between keep-alive probes for an active network connection between frpc and frps.
# If negative, keep-alive probes are disabled.
# transport.tcpKeepalive = 7200

# transport.tls.force specifies whether to only accept TLS-encrypted connections. By default, the value is false.
tls.force = false

# transport.tls.certFile = "server.crt"
# transport.tls.keyFile = "server.key"
# transport.tls.trustedCaFile = "ca.crt"

# If you want to support virtual host, you must set the http port for listening (optional)
# Note: http port and https port can be same with bind_port
vhostHTTPPort = 80
vhostHTTPSPort = 443

# Response header timeout(seconds) for vhost http server, default is 60s
# vhostHTTPTimeout = 60

# tcpmuxHTTPConnectPort specifies the port that the server listens for TCP
# HTTP CONNECT requests. If the value is 0, the server will not multiplex TCP
# requests on one single port. If it's not - it will listen on this value for
# HTTP CONNECT requests. By default, this value is 0.
# tcpmuxHTTPConnectPort = 1337

# If tcpmux_passthrough is true, frps won't do any update on traffic.
# tcpmuxPassthrough = false

# Configure the web server to enable the dashboard for frps.
# dashboard is available only if webServer.port is set.
webServer.addr = "127.0.0.1"
webServer.port = 7500
webServer.user = "admin"
webServer.password = "admin"
# webServer.tls.certFile = "server.crt"
# webServer.tls.keyFile = "server.key"
# dashboard assets directory(only for debug mode)
# webServer.assetsDir = "./static"

# Enable golang pprof handlers in dashboard listener.
# Dashboard port must be set first
webServer.pprofEnable = false

# enablePrometheus will export prometheus metrics on webServer in /metrics api.
enablePrometheus = true

# console or real logFile path like ./frps.log
log.to = "./frps.log"
# trace, debug, info, warn, error
log.level = "info"
log.maxDays = 3
# disable log colors when log.to is console, default is false
log.disablePrintColor = false

# DetailedErrorsToClient defines whether to send the specific error (with debug info) to frpc. By default, this value is true.
detailedErrorsToClient = true

# auth.method specifies what authentication method to use authenticate frpc with frps.
# If "token" is specified - token will be read into login message.
# If "oidc" is specified - OIDC (Open ID Connect) token will be issued using OIDC settings. By default, this value is "token".
auth.method = "token"

# auth.additionalScopes specifies additional scopes to include authentication information.
# Optional values are HeartBeats, NewWorkConns.
# auth.additionalScopes = ["HeartBeats", "NewWorkConns"]

# auth token
auth.token = "12345678"

# oidc issuer specifies the issuer to verify OIDC tokens with.
auth.oidc.issuer = ""
# oidc audience specifies the audience OIDC tokens should contain when validated.
auth.oidc.audience = ""
# oidc skipExpiryCheck specifies whether to skip checking if the OIDC token is expired.
auth.oidc.skipExpiryCheck = false
# oidc skipIssuerCheck specifies whether to skip checking if the OIDC token's issuer claim matches the issuer specified in OidcIssuer.
auth.oidc.skipIssuerCheck = false

# userConnTimeout specifies the maximum time to wait for a work connection.
# userConnTimeout = 10

# Only allow frpc to bind ports you list. By default, there won't be any limit.
allowPorts = [
  { start = 2000, end = 3000 },
  { single = 3001 },
  { single = 3003 },
  { start = 4000, end = 50000 }
]

# Max ports can be used for each client, default value is 0 means no limit
maxPortsPerClient = 0

# If subDomainHost is not empty, you can set subdomain when type is http or https in frpc's configure file
# When subdomain is est, the host used by routing is test.frps.com
subDomainHost = "frps.com"

# custom 404 page for HTTP requests
# custom404Page = "/path/to/404.html"

# specify udp packet size, unit is byte. If not set, the default value is 1500.
# This parameter should be same between client and server.
# It affects the udp and sudp proxy.
udpPacketSize = 1500

# Retention time for NAT hole punching strategy data.
natholeAnalysisDataReserveHours = 168

[[httpPlugins]]
name = "user-manager"
addr = "127.0.0.1:9000"
path = "/handler"
ops = ["Login"]

[[httpPlugins]]
name = "port-manager"
addr = "127.0.0.1:9001"
path = "/handler"
ops = ["NewProxy"]
```


## frpc {#frpc}


### 常用配置 {#常用配置}

```cfg
[common]
# 启用 TLS 加密
tls_enable = true
# Frp 服务器地址
server_addr = 47.104.77.123
# Frp 服务器监听的端口，与 frps.ini 的 bind_port 一致
server_port = 7001
# Frp 服务器配置的 token，与 frps.ini 的 token 一致
token = 123456

# 配置 SSH 服务
[ssh]
type = tcp
# 本地 SSH 服务地址
local_ip = 127.0.0.1
# 本地 SSH 服务端口
local_port = 22
# 自定义的远程端口，用于连接 SSH
remote_port = 6000

# 配置 HTTP 服务
[web]
type = http
# 本地 HTTP 服务地址
local_ip = 127.0.0.1
# 本地 HTTP 服务端口
local_port = 8080
# 自定义的子域名，用于访问 Web 服务
subdomain = test.hijk.pw
# 自定义的远程端口，例如 8080
remote_port = 8080
```

./frpc -c /etc/frp/frpc.ini


### 完整配置 {#完整配置}

```cfg
# A literal address or host name for IPv6 must be enclosed
# in square brackets, as in "[::1]:80", "[ipv6-host]:http" or "[ipv6-host%zone]:80"
# For single "bind_addr" field, no need square brackets, like "bind_addr = ::".
bindAddr = "0.0.0.0"
bindPort = 7000

# udp port used for kcp protocol, it can be same with 'bind_port'.
# if not set, kcp is disabled in frps.
kcpBindPort = 7000

# udp port used for quic protocol.
# if not set, quic is disabled in frps.
# quicBindPort = 7002

# Specify which address proxy will listen for, default value is same with bind_addr
# proxy_bind_addr = "127.0.0.1"

# quic protocol options
# transport.quic.keepalivePeriod = 10
# transport.quic.maxIdleTimeout = 30
# transport.quic.maxIncomingStreams = 100000

# Heartbeat configure, it's not recommended to modify the default value
# The default value of heartbeat_timeout is 90. Set negative value to disable it.
# transport.heartbeatTimeout = 90

# Pool count in each proxy will keep no more than maxPoolCount.
transport.maxPoolCount = 5

# If tcp stream multiplexing is used, default is true
# transport.tcpMux = true

# Specify keep alive interval for tcp mux.
# only valid if tcpMux is true.
# transport.tcpMuxKeepaliveInterval = 60

# tcpKeepalive specifies the interval between keep-alive probes for an active network connection between frpc and frps.
# If negative, keep-alive probes are disabled.
# transport.tcpKeepalive = 7200

# transport.tls.force specifies whether to only accept TLS-encrypted connections. By default, the value is false.
tls.force = false

# transport.tls.certFile = "server.crt"
# transport.tls.keyFile = "server.key"
# transport.tls.trustedCaFile = "ca.crt"

# If you want to support virtual host, you must set the http port for listening (optional)
# Note: http port and https port can be same with bind_port
vhostHTTPPort = 80
vhostHTTPSPort = 443

# Response header timeout(seconds) for vhost http server, default is 60s
# vhostHTTPTimeout = 60

# tcpmuxHTTPConnectPort specifies the port that the server listens for TCP
# HTTP CONNECT requests. If the value is 0, the server will not multiplex TCP
# requests on one single port. If it's not - it will listen on this value for
# HTTP CONNECT requests. By default, this value is 0.
# tcpmuxHTTPConnectPort = 1337

# If tcpmux_passthrough is true, frps won't do any update on traffic.
# tcpmuxPassthrough = false

# Configure the web server to enable the dashboard for frps.
# dashboard is available only if webServer.port is set.
webServer.addr = "127.0.0.1"
webServer.port = 7500
webServer.user = "admin"
webServer.password = "admin"
# webServer.tls.certFile = "server.crt"
# webServer.tls.keyFile = "server.key"
# dashboard assets directory(only for debug mode)
# webServer.assetsDir = "./static"

# Enable golang pprof handlers in dashboard listener.
# Dashboard port must be set first
webServer.pprofEnable = false

# enablePrometheus will export prometheus metrics on webServer in /metrics api.
enablePrometheus = true

# console or real logFile path like ./frps.log
log.to = "./frps.log"
# trace, debug, info, warn, error
log.level = "info"
log.maxDays = 3
# disable log colors when log.to is console, default is false
log.disablePrintColor = false

# DetailedErrorsToClient defines whether to send the specific error (with debug info) to frpc. By default, this value is true.
detailedErrorsToClient = true

# auth.method specifies what authentication method to use authenticate frpc with frps.
# If "token" is specified - token will be read into login message.
# If "oidc" is specified - OIDC (Open ID Connect) token will be issued using OIDC settings. By default, this value is "token".
auth.method = "token"

# auth.additionalScopes specifies additional scopes to include authentication information.
# Optional values are HeartBeats, NewWorkConns.
# auth.additionalScopes = ["HeartBeats", "NewWorkConns"]

# auth token
auth.token = "12345678"

# oidc issuer specifies the issuer to verify OIDC tokens with.
auth.oidc.issuer = ""
# oidc audience specifies the audience OIDC tokens should contain when validated.
auth.oidc.audience = ""
# oidc skipExpiryCheck specifies whether to skip checking if the OIDC token is expired.
auth.oidc.skipExpiryCheck = false
# oidc skipIssuerCheck specifies whether to skip checking if the OIDC token's issuer claim matches the issuer specified in OidcIssuer.
auth.oidc.skipIssuerCheck = false

# userConnTimeout specifies the maximum time to wait for a work connection.
# userConnTimeout = 10

# Only allow frpc to bind ports you list. By default, there won't be any limit.
allowPorts = [
  { start = 2000, end = 3000 },
  { single = 3001 },
  { single = 3003 },
  { start = 4000, end = 50000 }
]

# Max ports can be used for each client, default value is 0 means no limit
maxPortsPerClient = 0

# If subDomainHost is not empty, you can set subdomain when type is http or https in frpc's configure file
# When subdomain is est, the host used by routing is test.frps.com
subDomainHost = "frps.com"

# custom 404 page for HTTP requests
# custom404Page = "/path/to/404.html"

# specify udp packet size, unit is byte. If not set, the default value is 1500.
# This parameter should be same between client and server.
# It affects the udp and sudp proxy.
udpPacketSize = 1500

# Retention time for NAT hole punching strategy data.
natholeAnalysisDataReserveHours = 168

[[httpPlugins]]
name = "user-manager"
addr = "127.0.0.1:9000"
path = "/handler"
ops = ["Login"]

[[httpPlugins]]
name = "port-manager"
addr = "127.0.0.1:9001"
path = "/handler"
ops = ["NewProxy"]
```


## ssh login {#ssh-login}

```bash
ssh 123456@47.104.77.123 -p 6000
```
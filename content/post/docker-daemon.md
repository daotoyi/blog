---
title: "Docker daemon"
date: "2022-03-03 09:56:00"
lastmod: "2022-04-30 12:24:33"
categories: ["Docker"]
draft: false
---

## startup error {#startup-error}

```shell
# systemctl status docker
● docker.service - Docker Application Container Engine
   Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
   Active: failed (Result: exit-code) since Wed 2022-03-02 13:52:17 UTC; 2min 57s ago
     Docs: https://docs.docker.com
  Process: 8646 ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock (code=exited, status=1/FAILURE)
 Main PID: 8646 (code=exited, status=1/FAILURE)

Mar 02 13:52:17 instance-1 systemd[1]: docker.service: Service hold-off time over, scheduling restart.
Mar 02 13:52:17 instance-1 systemd[1]: docker.service: Scheduled restart job, restart counter is at 3.
Mar 02 13:52:17 instance-1 systemd[1]: Stopped Docker Application Container Engine.
Mar 02 13:52:17 instance-1 systemd[1]: docker.service: Start request repeated too quickly.
Mar 02 13:52:17 instance-1 systemd[1]: docker.service: Failed with result 'exit-code'.
Mar 02 13:52:17 instance-1 systemd[1]: Failed to start Docker Application Container Engine.
```


### resolve: {#resolve}

/etc/docker/daemon.json

```js
{
 "registry-mirrors": ["https://registry.docker-cn.com"]
}
```


## stop error {#stop-error}

```shell
systemctl stop docker

[....] Stopping docker (via systemctl): docker.serviceWarning: Stopping docker.service, but it can still be activated by: docker.socket .
```

除了 docker.service 单元文件，还有一个 docker.socket 单元文件…docker.socket 这是用于套接字激活。


### resolve {#resolve}

-   解决方案一

可以删除 /lib/systemd/system/docker.socket

从 docker 中 docker.service 文件 删除 fd://，即 remove -H fd://

-   解决方案二

如果不想被访问时自动启动服务,输入命令：

sudo systemctl stop docker.socket
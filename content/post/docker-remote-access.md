---
title: "Docker 远程访问"
date: "2022-03-03 09:54:00"
lastmod: "2022-04-30 12:24:34"
categories: ["Docker"]
draft: false
---

默认情况下，Docker 守护进程会生成一个 socket 文件来进行本地进程通信，而不会监听任何端口，因此只能在本地使用 docker 客户端或者使用 Docker API 进行操作。

如果想在其他主机上操作 Docker 主机，就需要让 Docker 守护进程监听一个端口，这样才能实现远程通信。


## 守护进程 dockerd {#守护进程-dockerd}

/etc/docker/daemon.json 会被 docker.service 的配置文件覆盖，直接添加 daemon.json 不起作用。


### 配置远程端口 {#配置远程端口}

可以有如下几种设置：

-   /lib/systemd/system/docker.service

    ExecStart，在最后面添加 `-H tcp://0.0.0.0:2375`

    `ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock -H tcp://0.0.0.0:2375`

-   [docker.service &amp; docker](https://github.com/moby/moby/issues/9889#issuecomment-109766580)
    -   /lib/systemd/system/docker.service

        **EnvironmentFile=-/etc/default/docker**

        ```toml
        [Unit]
        Description=Docker Application Container Engine
        Documentation=http://docs.docker.com
        After=network.target docker.socket
        Requires=docker.socket

        [Service]
        EnvironmentFile=-/etc/default/docker
        ExecStart=/usr/bin/docker -d $DOCKER_OPTS -H fd://
        MountFlags=slave
        LimitNOFILE=1048576
        LimitNPROC=1048576
        LimitCORE=infinity

        [Install]
        WantedBy=multi-user.target
        ```

    -   /etc/default/docker

        ```shell
        # Use DOCKER_OPTS to modify the daemon startup options.
        #DOCKER_OPTS="-H tcp://0.0.0.2375"
        ```


### systemctl 管理 {#systemctl-管理}

然后重新加载 docker 配置文件和重启 docker

```shell
systemctl daemon-reload
systemctl start docker
# iptables -F # 添加防火墙策略或者关闭防火墙
netstat -ntpl # 查看端口
```

-   此方法 OK


### 手动测试 {#手动测试}

-   以默认配置启动
    -   添加 `/etc/docker/daemon.json` (**启动不成功**)

        ```js
        {
            "debug": true,
            // "tls": true,
            //"tlscert": "/var/docker/server.pem",
            //"tlskey": "/var/docker/serverkey.pem",
            "hosts": ["tcp://192.168.59.3:2376"]
        }
        ```

        -   dockerd  执行启动

-   临时测试方式启动

    ```shell
    # 假设 1.2.3.4 是运行要连接的守护程序的主机的 IP
    dockerd -H tcp://1.2.3.4:2375
    # 或者将其绑定(bind)到所有网络接口(interface):
    dockerd -H tcp://0.0.0.0:2375
    ```

    -   此方式 **启动不成功** ，即使加了 `--tls=false` or `--tlsverify=false`

        ```shell
        dockerd -H tcp://1.2.3.4:2375 --tls=false
        ```


## 远程访问 daemon {#远程访问-daemon}


### 手动添加远程主机 host {#手动添加远程主机-host}

docker -H tcp://xxx.xxx.xxx.xxx:xxx images


### 配置文件添加主机 host {#配置文件添加主机-host}

在/etc/default/docker 中配置 `DOCKER_HOST=tcp://xxx.xxx.xxx.xxx:2375`,可以通过以下方式远程访问

```shell
# 访问远程主机上的docker daemomn,列出images
docker -H tcp://127.0.0.1:2375 images
```


## 检查访问 {#检查访问}


### 本地访问 {#本地访问}

在远程 vps 上执行 `curl http://localhost:port/version` , 出现类似以下内容,则本地访问成功.

```js
{"Platform":{"Name":"Docker Engine - Community"},"Components":[{"Name":"Engine","Version":"20.10.12","Details":{"ApiVersion":"1.41","Arch":"amd64","BuildTime":"2021-12-13T11:43:42.000000000+00:00","Experimental":"false","GitCommit":"459d0df","GoVersion":"go1.16.12","KernelVersion":"5.4.0-1065-gcp","MinAPIVersion":"1.12","Os":"linux"}},{"Name":"containerd","Version":"1.4.12","Details":{"GitCommit":"7b11cfaabd73bb80907dd23182b9347b4245eb5d"}},{"Name":"runc","Version":"1.0.2","Details":{"GitCommit":"v1.0.2-0-g52b36a2"}},{"Name":"docker-init","Version":"0.19.0","Details":{"GitCommit":"de40ad0"}}],"Version":"20.10.12","ApiVersion":"1.41","MinAPIVersion":"1.12","GitCommit":"459d0df","GoVersion":"go1.16.12","Os":"linux","Arch":"amd64","KernelVersion":"5.4.0-1065-gcp","BuildTime":"2021-12-13T11:43:42.000000000+00:00"}
```


### 远程访问 {#远程访问}

在远方浏览器地址栏输入 `http://xxx.xxx.xxx.xxx:xxx/version`, 也会出现以上内容,即是访问成功.
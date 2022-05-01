---
title: "Nginx"
date: "2022-04-04 23:44:00"
lastmod: "2022-04-30 12:35:31"
categories: ["Internet"]
draft: false
---

## instoducton {#instoducton}

```cfg
worker_processes  1;
events {
    worker_connections  1024;
}
http {
    include       mime.types;
    default_type  application/octet-stream;
    keepalive_timeout  65;
    server {
        listen       80;
        server_name  localhost;
        location / {
            root   html;
            index  index.html index.htm;
        }
    }
}
```

{{< figure src="https://raw.githubusercontent.com/daotoyi/picsbed/main//img/202204051045737.png" >}}

根据上述文件，我们可以很明显的将 nginx.conf 配置文件分为三部分


### global {#global}

从配置文件开始到 events 块之间的内容，主要会设置一些影响 nginx 服务器整体运行的配置指令，主要包括配置运行 Nginx 服务器的用户（组）、允许生成的 worker process 数，进程 PID 存放路径、日志存放路径和类型以及配置文件的引入等。


### events {#events}

events 块涉及的指令主要影响 Nginx 服务器与用户的网络连接，常用的设置包括是否开启对多 work process 下的网络连接进行序列化，是否允许同时接收多个网络连接，选取哪种事件驱动模型来处理连接请求，每个 word process 可以同时支持的最大连接数等。


### http {#http}

是 Nginx 服务器配置中最频繁的部分，代理、缓存和日志定义等绝大多数功能和第三方模块的配置都在这里。

需要注意的是：http 块也可以包括 http 全局块、server 块。是 Nginx 服务器配置中最频繁的部分，代理、缓存和日志定义等绝大多数功能和第三方模块的配置都在这里。

需要注意的是：http 块也可以包括 http 全局块、server 块。


#### http global {#http-global}

http 全局块配置的指令包括文件引入、MIME-TYPE 定义、日志自定义、连接超时时间、单链接请求数上限等。


#### server {#server}

这块和虚拟主机有密切关系，虚拟主机从用户角度看，和一台独立的硬件主机是完全一样的，该技术的产生是为了节省互联网服务器硬件成本。

每个 http 块可以包括多个 server 块，而每个 server 块就相当于一个虚拟主机。

而每个 server 块也分为全局 server 块，以及可以同时包含多个 locaton 块。

<!--list-separator-->

-  serval global

    最常见的配置是本虚拟机主机的监听配置和本虚拟主机的名称或 IP 配置。

<!--list-separator-->

-  location

    一个 server 块可以配置多个 location 块。

    这块的主要作用是基于 Nginx 服务器接收到的请求字符串（例如 server_name/uri-string），对虚拟主机名称（也可以是 IP 别名）之外的字符串（例如 前面的 /uri-string）进行匹配，对特定的请求进行处理。地址定向、数据缓存和应答控制等功能，还有许多第三方模块的配置也在这里进行。


## default config note {#default-config-note}

```cfg
#指定用什么用户去跑work process，默认用linux下的nobody 用户
user  nobody;
#工作进程数,可以设置为auto,nginx会探测cpu核心数，启动相同数量的work process
worker_processes  1;
#错误日志存放位置.既然叫错误日志，通常应设置级别为warn|error
error_log  logs/error.log;
error_log  logs/error.log  notice;
error_log  logs/error.log  info;
#主进程pid文件存放的地点
pid        logs/nginx.pid;

#events模块只能在main上下文中，并且只能配置一个，
#其中可以包含7种简单指令
events {
    worker_connections  1024;
    #每个worker process可以支持的最大连接数，生成环境根据需要可以设置更大一些（9000）
    #值得注意的是，此数字是包括了反向代理等等所需要的连接数在内，并不仅仅是指web端发起的连接数
    multi_accept on #是否work进程一次只接收一个连接。并发较大时应打开
    use epoll #选择底层处理连接的模型，Linux下默认epoll，无需自己设置
    accept_mutex
    accept_mutex_delay
    #上面2参数是表示是否让worker进程使用one by one的工作模式，默认是关闭的。
    #开启的时候，在低并发的时候非工作状态下的worker process将休眠，避免浪费资源。
}

#nginx配置的“核心”
http {
    #include指令用于加载单独的配置文件模块，避免过于臃肿
    #而这里的 mime.types表示此文件应该在nginx.conf的同级目录下。
    #其中的types模块用于表示nginx响应的文件后缀名和content-type直接的映射
    #比如你想要让浏览器识别你返回的mytxt.data文件为文本内容在浏览器中显示为文本,添加 text/plain   data;
    include       mime.types;
    #上面的匹配失败后，默认给的响应内容类型
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  logs/access.log  main;
    #io时不阻塞处理connection，在传输大文件时使用，加快文件读写效率
    sendfile        on;
    tcp_nopush     on;#貌似意思是只有在sendfile启用时使用，让nginx发包的时候满包发送（不明白）通常不使用
    #连接idle的最大时间，现代浏览器往往在一个页面同时打开多个connection传输js,css,html等。
    #设置最大idle时间避免过长等待浪费connection
    #keepalive_timeout  0;
    keepalive_timeout  65;
    #开启response响应压缩，可以节省带宽，默认关闭。超过1024Kb才压缩
    gzip  on;
    #server 上下文代表一个虚拟主机，可以有多个，内嵌在比如http,mail模块中
    server {
            listen 80;
            server_name myapp.info; #如果是在本地试验，要修改/etc/hosts的域名映射到本机
            location / { #location的匹配规则too tricky，单开一篇blog 注意匹配的文件夹的访问权限
                    root /usr/local/nginx;
            }
     };
     include /etc/nginx/conf/conf.d/*/*.conf;
}
```


## proxy {#proxy}


### single server {#single-server}

```cfg
#配置监听的目录为：/
location /{
    root html;
    index index.html index.htm;
    proxy_pass http/127.0.0.1:8080;  #反向代理了本机的8080端口
    #proxy_pass http/127.0.0.1:8081; #反向代理了本机的8081端口

    # 可以同时配置多条proxy_pass
```


### multi server {#multi-server}

```cfg
#配置服务器组，取名为hello
upstream hello{
#一个server对应一个服务器，当然也可以是不同端口的web程序
server 127.0.0.1:8080:
server 127.0.0.1:8081;

#在location块中修改反向代理为服务器组
location/{
  root html ;
  index index.html index.htm;
  proxy_pass http/hello; #反向代理了hello服务器组中的所有服务
}
```


## conf.d/ {#conf-dot-d}


### subConfig {#subconfig}

```cfg
server {
        listen 8000;
        server_name test1.com;
        location / {
            proxy_set_header Host $host:$server_port;
            proxy_set_header X-Real-Ip $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            echo "test.com";    # 输出测试
        }
}
```


### upstream {#upstream}

```cfg
  ## 下游代理服务器，这里test-backend是自定义后台的名字。
  # 这里的【127.0.0.1:9002】是后台接口地址
  upstream test-backend {
      server 127.0.0.1:9002;
  }
  ## test-peoject虚拟服务器配置
  server {
      ## 监听端口
      listen 99;
      ## 服务名称
      server_name localhost;
      ## 字符集编码
      charset utf-8;
      ## 访问日志
      access_log logs/test-peoject.access.log main;
      ## 错误日志
      #error_log logs/test-peoject.error.log main;
      # 客户端请求体最大值
      client_max_body_size 500m;
      # 黑名单配置
      deny 192.53.163.212;

      #【html/test-project】是前端项目打包好的文件的位置
      index index.html;
      root html/test-project;

      ## 默认首页
      location / {
          try_files $uri $uri/ @router;
          index  index.html index.htm;
      }
      ## VUE路由重写
      location @router {
          rewrite ^.*$ /index.html last;
      }
      ## 显示前端静态资源
      location ~ ^(/static/) {
          access_log off;
          root html/test-project;
          expires 7d;
      }
      ## 代理前端图片，缓存时间长一点
      location ~ ^(/static/).+\.(jpg|jpeg|gif|png)$ {
          access_log off;
          root html/test-project;
          expires 15d;
      }
      ## 通过客户端请求头信息
      proxy_pass_request_headers on;
      ## 保留客户端的真实信息
      proxy_set_header Host $host;
      proxy_set_header X-Real_IP $remote_addr;
      proxy_set_header X-Forward-For $proxy_add_x_forwarded_for;
      ## 转发后台请求，这个用到了test-backend（前面已定义的）
      location /test-pro {
          proxy_pass http://test-backend;
      }
}
```


## location {#location}

```cfg
~  #波浪线表示执行一个正则匹配，区分大小写
~* #表示执行一个正则匹配，不区分大小写
^~ #^~表示普通字符匹配，如果该选项匹配，只匹配该选项，不匹配别的选项，一般用来匹配目录
=  #进行普通字符精确匹配,用于不含正则表达式的 uri 前，要求请求字符串与 uri 严格匹配，如果匹配成功，就停止继续向下搜索并立即处理该请求。
@  #"@" 定义一个命名的 location，使用在内部定向时
```

```cfg
location  = / {
  # 只匹配"/".
}
location  / {
  # 匹配任何请求，因为所有请求都是以"/"开始
  # 但是更长字符匹配或者正则表达式匹配会优先匹配
}
location ^~ /images/ {
  # 匹配任何以 /images/ 开始的请求，并停止匹配 其它location
}
location ~* .(gif|jpg|jpeg)$ {
  # 匹配以 gif, jpg, or jpeg结尾的请求.
}
```


## load balancing {#load-balancing}


### roll polling 默认） {#roll-polling-默认}

每个请求按时间顺序逐一分配到不同的后端服务器，如果后端服务器 down 掉，能自动剔除。


### weight {#weight}

Nginx 的负载均衡方式可以有很多种，如加权轮询(默认)、IP 哈希、url 哈希等等.

加权轮询，也就是通过给服务器添加各自的权重值，Nginx 通过权重来进行请求的分配，权重越高接收到的请求数量越多，反之越少：

{{< figure src="https://pic3.zhimg.com/80/v2-fbfbfae025d0fbbebbfb7a67c5a206be_1440w.jpg" >}}

```cfg
upstream hello{
    server服务器1:8080 weight=3:#配置服务器1的权重为3
    server服务器2:8080 weight=1;#配置服务器2的权重为1
}
```


### ip_hash {#ip-hash}

每个请求按访问 ip 的 hash 结果分配，这样每个访客固定访问一个后端服务器，可以解决 session 的问题。


### fair {#fair}

（第三方）
按后端服务器的响应时间来分配请求，响应时间短的优先分配。


## operate {#operate}

```bash
nginx -t
nginx -s reload
nginx -s stop
nginx -s quit
```


## Ref {#ref}

-   [Nginx配置文件详解](https://www.cnblogs.com/54chensongxia/p/12938929.html)
-   [nginx.conf的结构和基础配置解析](https://www.jianshu.com/p/1037e6929f54)
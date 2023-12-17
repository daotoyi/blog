---
title: "Nginx"
date: "2022-04-04 23:44:00"
lastmod: "2023-12-17 18:39:38"
categories: ["Internet"]
draft: false
---

## instoducton {#instoducton}


### template {#template}

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

[nginx pics](https://raw.githubusercontent.com/daotoyi/picsbed/main/img/202204051045737.png)

![](https://raw.githubusercontent.com/daotoyi/picsbed/main//img/202204051045737.png)

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
    multi_accept on # 是否work进程一次只接收一个连接。并发较大时应打开
    use epoll # 选择底层处理连接的模型，Linux下默认epoll，无需自己设置
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
    tcp_nopush     on; #貌似意思是只有在sendfile启用时使用，让nginx发包的时候满包发送（不明白）通常不使用
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


## [general parameter](https://www.runoob.com/w3cnote/nginx-setup-intro.html) {#general-parameter}

1.  $remote_addr 与 $http_x_forwarded_for 用以记录客户端的 ip 地址；
2.  $remote_user ：用来记录客户端用户名称；
3.  $time_local ： 用来记录访问时间与时区；
4.  $request ： 用来记录请求的 url 与 http 协议；
5.  $status ： 用来记录请求状态；成功是 200；
6.  $body_bytes_s ent ：记录发送给客户端文件主体内容大小；
7.  $http_referer ：用来记录从那个页面链接访问过来的；
8.  $http_user_agent ：记录客户端浏览器的相关信息；


## variable {#variable}

ginx 中的变量分为两种，自定义变量与内置预定义变量.


### 自定义变量 {#自定义变量}

可以在 http,sever,location 等标签中使用 set 命令（非唯一）声明变量，语法如下：

```json
set $变量名 变量值
```

-   变量必须都以$开头
-   变量都必须是声明过的，否则 nginx 会无法启动并打印相关异常日志

nginx 变量的一个有趣的特性就是 nginx 中每一个变量都是全局可见的，而他们又不是全局变量。如：

```bash
location a/ {
  return 200 $a
}

location b/ {
 set $a hello nginx
 return 200 $a
}
```

变量是全局可见的所以 nginx 启动不会报错，而第一个 location 中并不知道$a 的具体值因此返回的响应结果为一个空字符串。

不同层级的标签中声明的变量性的可见性规则如下:

1.  location 标签中声明的变量中对这个 location 块可见
2.  server 标签中声明的变量对 server 块以及 server 块中的所有子块可见
3.  http 标签中声明的变量对 http 块以及 http 块中的所有子块可见


### [内置变量](https://mp.weixin.qq.com/s/wjpFFPzvMuZI5lXKLB8lLQ) {#内置变量}


### 参考 {#参考}

-   [nginx 变量使用](https://blog.csdn.net/u014296316/article/details/80973530)


## http and stream module {#http-and-stream-module}

工作原理

-   HTTP 模块
    -   HTTP 模块主要用于处理 HTTP 和 HTTPS 流量。
    -   它可以接收 HTTP 请求、代理 HTTP 请求到后端服务器、负载均衡、缓存和处理 HTTPS 加密等。
    -   HTTP 模块是 Nginx 最常用的模块之一，通常用于构建 Web 服务器或反向代理服务器。
-   Stream 模块
    -   Stream 模块用于处理通用 TCP 和 UDP 流量。
    -   它允许 Nginx 在传输层（TCP/UDP）上进行代理、负载均衡和流量控制。Stream 模块通常用于构建 TCP 代理、数据库负载均衡、消息队列代理等应用。


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
  proxy_pass http/hello; # 反向代理了hello服务器组中的所有服务
}
```


## proxy_set_header {#proxy-set-header}

```cfg
location /wss
    {
        proxy_pass http://127.0.0.1:8888;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header X-Real-IP $remote_addr;

        proxy_set_header Host $host:$server_port;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        echo "test.com";    # 输出测试
    }
```

[Nginx proxy_set_header Host $host 和 proxy_set_header Host $http_host](https://www.jianshu.com/p/7a8a7eb3707a)

-   /wss 这个是随便起的,告诉 Nginx 要代理的 url
-   proxy_pass 要代理到的 url, 代理到本机的 8888 端口。
    -   当我访问的我的服务器 `https://xxx.com/wss` 时,Nginx 会把请求映射到本机的 8888 端口。
-   proxy_http_version 代理时使用的 http 版本
-   proxy_set_header Upgrade 把代理时 http 请求头的 Upgrade 设置为原来 http 请求的请求头
    -   wss 协议的请求头为 websocket
-   proxy_set_header Connection 因为代理的 wss 协议,所以 http 请求头的 Connection 设置为 Upgrade
-   proxy_set_header X-Real-IP 给代理设置原 http 请求的 ip(客户端真实 ip)
-   proxy_set_header X-Forwarded-For 客户端真实 ip
-   proxy_set_header Host (host-&gt; 访问 nginx 时返回:
    -   $http_host          -&gt; $host:$server_port
    -   $host               -&gt; 只返回 host
    -   $host:$server_port  -&gt; listen port
    -   $host:$proxy_port   -&gt; proxy_pass port


## proxy multiport {#proxy-multiport}

-   [Nginx单服务器部署多个网站，域名](https://blog.csdn.net/yaologos/article/details/113356620)(server)
-   [Nginx配置——单域名反向代理多个端口](https://www.jianshu.com/p/5bc9cd2271b1)(location)
-   [nginx代理 1个端口+路径匹配 代理多个web](https://blog.csdn.net/weixin_48215755/article/details/122713914)(location)


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
      ## 保留客户端的真实(ip etc.)信息
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


### instruction {#instruction}

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


### path {#path}

**location 匹配路径末尾没有 /此时 proxy_pass 后面的路径必须和 location 设置的路径一致**

```cfg
location /index
{
  proxy_redirect off;
  proxy_set_header       Host $host;
  proxy_set_header       X-Real-IP $remote_addr;
  proxy_set_header       X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_pass http://localhost:8080/index;
  }
```

外面访问：<http://romotehost/index/index.html>

相当于访问：<http://localhost:8080/index/index.html>

**location 匹配路径末尾有 /此时 proxy_pass 后面的路径需要分为以下四种情况讨论**

1.  proxy_pass 后面的路径只有域名且最后没有 /：

外面访问：<http://romotehost/index/index.html>

相当于访问：<http://localhost:8080/index/index.html>

```cfg
location /index/
{
  proxy_redirect off;
  proxy_set_header       Host $host;
  proxy_set_header       X-Real-IP $remote_addr;
  proxy_set_header       X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_pass http://localhost:8080;
}
```

外面访问：<http://romotehost/index/index.html>

相当于访问：<http://localhost:8080/index/index.html>

1.  proxy_pass 后面的路径只有域名同时最后有 /：

外面访问：<http://romotehost/index/index.html>

相当于访问：<http://localhost:8080/index.html>

```cfg
location /index/
{
  proxy_redirect off;
  proxy_set_header       Host $host;
  proxy_set_header       X-Real-IP $remote_addr;
  proxy_set_header       X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_pass http://localhost:8080/;
}
```

外面访问：<http://romotehost/index/index.html>

相当于访问：<http://localhost:8080/index.html>

1.  proxy_pass 后面的路径还有其他路径但是最后没有 /：

外面访问：<http://romotehost/index/index.html>

相当于访问：<http://localhost:8080/testindex.html>

```cfg
location /index/
{
  proxy_redirect off;
  proxy_set_header       Host $host;
  proxy_set_header       X-Real-IP $remote_addr;
  proxy_set_header       X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_pass http://localhost:8080/test;
}
```

外面访问：<http://romotehost/index/index.html>

相当于访问：<http://localhost:8080/testindex.html>

1.  proxy_pass 后面的路径还有其他路径同时最后有 /：

外面访问：<http://romotehost/index/index.html>

相当于访问：<http://localhost:8080/index/index.html>

```json
location /index/
{
  proxy_redirect off;
  proxy_set_header       Host $host;
  proxy_set_header       X-Real-IP $remote_addr;
  proxy_set_header       X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_pass http://localhost:8080/test/;
}
```

外面访问：<http://romotehost/index/index.html>

相当于访问：<http://localhost:8080/index/index.html>


## load balancing {#load-balancing}


### roll polling 默认） {#roll-polling-默认}

每个请求按时间顺序逐一分配到不同的后端服务器，如果后端服务器 down 掉，能自动剔除。


### weight {#weight}

Nginx 的负载均衡方式可以有很多种，如加权轮询(默认)、IP 哈希、url 哈希等等.

加权轮询，也就是通过给服务器添加各自的权重值，Nginx 通过权重来进行请求的分配，权重越高接收到的请求数量越多，反之越少：

![](https://pic3.zhimg.com/80/v2-fbfbfae025d0fbbebbfb7a67c5a206be_1440w.jpg)

```json
upstream hello{
    server服务器1:8080 weight=3; #配置服务器1的权重为3
    server服务器2:8080 weight=1; #配置服务器2的权重为1
}
```


### ip_hash {#ip-hash}

每个请求按访问 ip 的 hash 结果分配，这样每个访客固定访问一个后端服务器，可以解决 session 的问题。


### fair {#fair}

（第三方）
按后端服务器的响应时间来分配请求，响应时间短的优先分配。


## hide nginx version {#hide-nginx-version}

/etc/nginx/conf.d/security.conf

```cfg
server_tokens off;  ##隐藏nginx版本信息
```


## Access-Control-Allow {#access-control-allow}

跨域，配置文件 nginx/conf/nginx.conf，找到 server 块， 在 location 块添加如下配置：

```cfg
location / {
  # 设置允许跨域的域名和端口 * 表示所有
  add_header Access-Control-Allow-Origin *;

  # 也可以设置只允许某个域名访问
  # add_header Access-Control-Allow-Origin 'http://allowdomain.com:8080';

  # 允许跨域的方法
  add_header Access-Control-Allow-Methods 'GET, POST, OPTIONS';

  # 允许跨域的请求头
  add_header Access-Control-Allow-Headers 'DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization';

  # 是否跨域携带cookie
  add_header Access-Control-Allow-Credentials 'true';
}
```


## Index of download {#index-of-download}

-   conf.d/downloads.conf

    ```cfg
    server {
        listen       80;
        server_name  downloads.domain.com;

     location / {
         alias /downloads/;

            if ($request_filename ~* ^.*?\.(html|doc|pdf|zip|docx|txt)$) {
                add_header Content-Disposition attachment;
                add_header Content-Type application/octet-stream;
            }
                sendfile on;
                autoindex on;
                autoindex_format html;
                autoindex_exact_size off;
                autoindex_localtime on;
                charset utf-8,gbk;
     }
    }
    ```

    重启：docker exec nginx nginx -s reload

    将文件从本地上传到 downloads 目录中，即可通过链接发送给他人供其下载。


## login authorization {#login-authorization}

nginx 提供了 ngx_http_auth_basic_module 模块实现让用户只有输入正确的用户名密码才允许访问 web 内容。默认情况下，nginx 已经安装了该模块。

先用第三方工具设置用户名、密码（其中密码已经加过密）,，然后保存到文件中，接着在 nginx 配置文件中根据之前事先保存的文件开启访问验证。

生成密码可以使用 htpasswd，或者使用 openssl


### tools {#tools}

```bash
yum  -y install httpd-tools
htpasswd -c /etc/nginx/auth username

openssl passwd <your_password>
```


### nginx.conf {#nginx-dot-conf}

```js
server {
    listen 80;
    server_name  localhost;

    // 位于server 下
    auth_basic "Please input password";
    auth_basic_user_file /usr/local/nginx/passwd;
    .......

    location /lvshuocoding {
        autoindex on;
        // 位于location下
        auth_basic "Please input password";
        auth_basic_user_file /usr/local/nginx/passwd;
    }

    // 在已经要求身份认证的父目录下，可以对特定的子目录取消身份验证要求
    loaction <subroute_match_rules> {
        auth_basic off;
    }
    .......
```

在多数情况下，auth_basic 不生效的原因就是由于路径匹配有误。


### htpasswd {#htpasswd}

```bash
# change passwd  username:lvshuo
htpasswd -D passwd lvshuo
htpasswd -b passwd lvshuo 123456

# 在原有密码文件中增加
htpasswd -b ./.passwd onlyzq pass
```

htpasswd 命令选项参数说明

-   -c 创建一个加密文件
-   -n 不更新加密文件，只将 htpasswd 命令加密后的用户名密码显示在屏幕上
-   -m 默认 htpassswd 命令采用 MD5 算法对密码进行加密
-   -d htpassswd 命令采用 CRYPT 算法对密码进行加密
-   -p htpassswd 命令不对密码进行进行加密，即明文密码
-   -s htpassswd 命令采用 SHA 算法对密码进行加密
-   -b htpassswd 命令行中一并输入用户名和密码而不是根据提示输入密码
-   -D 删除指定的用户


### reference {#reference}

-   [nginx配置目录访问密码](https://blog.csdn.net/lvshuocool/article/details/102783544)
-   [配置 Nginx auth_basic 身份验证](https://blog.csdn.net/qq_44633541/article/details/124370705)


## operate {#operate}

```bash
nginx -t
nginx -s reload
nginx -s stop
nginx -s quit
```


## note {#note}

-   分离式配置中
    -   **listen 同一个 port 和 server_name 的 sever 模块的内容要写在一起。**
        -   **若分开多个文件，在 nginx.conf 中 include，后面的 sever 模块中的 location 无法生效。**
    -   listen 同一 port 但不同 server_name 的 server 模块可以分不同的配置文件加载。


## Ref {#ref}

-   [Nginx 配置详解](https://www.runoob.com/w3cnote/nginx-setup-intro.html)
-   [Nginx配置文件详解](https://www.cnblogs.com/54chensongxia/p/12938929.html)
-   [nginx 一把梭！（超详细讲解+实操）](https://mp.weixin.qq.com/s/D-YnmePJsjmwcLA-0Mk3fw)
-   [全网最详细nginx配置详解](https://mp.weixin.qq.com/s/y0KtFDsCOwfbbFVhjvVy1Q?poc_token=HDyyfmWjoKd4Ak2IyBAYr3_RPszIi7TaFOglCoCE)
-   [nginx.conf的结构和基础配置解析](https://www.jianshu.com/p/1037e6929f54)
-   [nginx 配置项说明](https://mp.weixin.qq.com/s/jroF7nIqhU4aAXdxO6jATw)
-   [nginx常用超时时间设置](https://mp.weixin.qq.com/s/LSmD0cfBGADEg8cToS_s0A)
-   [深入理解Nginx工作原理及优化技巧](https://mp.weixin.qq.com/s/clvboOhcnGf8sWz8IC0gIg) - refine
-   [Nginx: 最常见的 2 中 http to https 跳转场景](https://mp.weixin.qq.com/s/hr2V9Npv8RKm4ExEtF-aXA)
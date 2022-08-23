---
title: "Apache2"
date: "2022-08-21 15:40:00"
lastmod: "2022-08-21 15:40:53"
categories: ["Internet"]
draft: false
---

## Basic {#basic}

配置文件是 /etc/apache2/apache2.conf,Apache 在启动时会自动读取这个文件的配置信息。而其他的一些配置文件，如 httpd.conf 等，则是通过 Include 指令包含进来。

```cfg
# Include module configuration:
Include /etc/apache2/mods-enabled/*.load
Include /etc/apache2/mods-enabled/*.conf

# Include all the user configurations:
Include /etc/apache2/httpd.conf

# Include ports listing
Include /etc/apache2/ports.conf
……
# Include generic snippets of statements
Include /etc/apache2/conf.d/

# Include the virtual host configurations:
Include /etc/apache2/sites-enabled/
```


## Web site {#web-site}

文档根目录一般是是/var/www, 配置文件 `/etc/apache2/sites-enabled/000-default`

```cfg
<VirtualHost *自定义端口>
# 在ServerName后加上你的网站名称
ServerName www.linyupark.com
# 如果你想多个网站名称都取得相同的网站，可以加在ServerAlias后加上其他网站别名。
# 别名间以空格隔开。
ServerAlias ftp.linyupark.com mail.linyupark.com
# 在ServerAdmin后加上网站管理员的电邮地址，方便别人有问题是可以联络网站管理员。
ServerAdmin webmaster@linyupark.com
# 在DocumentRoot后加上存放网站内容的目录路径(用户的个人目录)
DocumentRoot /home/linyupark/public_html
<Directory /home/linyupark/public_html>

Options Indexes FollowSymLinks MultiViews
AllowOverride None
Order allow,deny
allow from all

</Directory>
ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
<Directory "/usr/lib/cgi-bin">
AllowOverride None
Options ExecCGI -MultiViews +SymLinksIfOwnerMatch
Allow from all

</Directory>
ErrorLog/home/linyupark/public_html/error.log
# Possible values include: debug, info, notice, warn, error, crit,alert, emerg.
LogLevel warn
CustomLog /home/linyupark/public_html/access.log combined
ServerSignature On
</VirtualHost>

# 如果你的服务器有多个IP，而不同的IP又有着不一样的虚拟用户的话，可以修改成:
<VirtualHost IP地址[:端口]>
...
</VirtualHost>
```

-   sites-enabled 目录存放的只是一些指向 site-available(真正的配置文件)的符号链接.
-   **available 目录是存放有效的内容，但不起作用，只有用 ln 连到 enabled 过去才可以起作用。**
-   sudo apache2ctl configtest
-   restart
    -   /etc/init.d/apache2  restart
    -   service apache2 restart
-   a2ensite example1.conf
    -   自动在/ etc / apache2 / sites-enabled /中创建 example.com 文件


## Parameter {#parameter}

```cfg
<directory "="" mnt="" web="" clusting"="">
Options FollowSymLinks
AllowOverride None
Order allow,deny
Allow from all
```

-   Options：配置在特定目录使用哪些特性
    -   ExecCGI: 在该目录下允许执行 CGI 脚本
    -   FollowSymLinks: 在该目录下允许文件系统使用符号连接。
    -   Indexes: 当用户访问该目录时，如果用户找不到 DirectoryIndex 指定的主页文件(例如 index.html),则返回该目录下的文件列表给用户
    -   SymLinksIfOwnerMatch: 当使用符号连接时，只有当符号连接的文件拥有者与实际文件的拥有者相同时才可以访问。
-   AllowOverride：允许存在于.htaccess 文件中的指令类型(.htaccess 文件名是可以改变的，其文件名由 AccessFileName 指令决定)：
    -   None: 当 AllowOverride 被设置为 None 时。不搜索该目录下的.htaccess 文件（可以减小服务器开销）
    -   All: 在.htaccess 文件中可以使用所有的指令。
-   Order：控制在访问时 Allow 和 Deny 两个访问规则哪个优先
-   Allow：允许访问的主机列表(可用域名或子网，例如：Allow from 192.168.0.0/16)


## Alias {#alias}

Alias _download_ "_var/www/download_" #访问时可以输入:<http://www.custing.com/download/>


## Redirext &amp; Rewrite {#redirext-and-rewrite}


### Redirect {#redirect}

```donf
Redirect / http://www.domain2.com
RedirectMatch ^/(.*)$ http://www.domain2.com/$1

Redirect permanent / http://www.domain2.com
RedirectMatch permanent ^/(.*)$ http://www.domain2.com/$1
```


### Rewrite [example:通过重定向把子目录设置为网站根目录](https://www.xinyueseo.com/jianzhan/531.html) {#rewrite-example-通过重定向把子目录设置为网站根目录}

**apache 的虚拟服务器的重定向都是通过 .htaccess 文件来实现的**

```cfg
RewriteEngine On
RewriteBase /
RewriteCond %{HTTP_HOST} ^bj.test.com$ [NC]
RewriteCond %{REQUEST_URI} !^/bj/
RewriteRule ^(.*)$ bj/$1 [QSA,L]

RewriteRule ^(.*)$ http://bj.test.com/$1 [QSA,R=301]
```

-   RewriteEngine On ： 开启 url 重写
-   RewriteBase ：基准路径，默认 “/” 即可，表示当前目录下；
-   RewriteCond ：重写条件；
-   %{HTTP_HOST} ^bj.test.com$ [NC] ：重写条件内容，%{HTTP_HOST} 这个是系统默认变量，表示当前访问的域名，[NC] 表示忽略大小写，^bj.test.com$ 正则匹配条件
    -   如果当前访问的域名是 bj.test.com 就继续进行下一句匹配；
-   RewriteCond %{REQUEST_URI} !^/bj/ 这句的意思是当前访问的路径不是以 _bj_ 开头
-   RewriteRule ^(.\*)$ bj/$1 [QSA,L]： url 重写规则，这里用的是内部重定向 ；
    -   QSA:保证 url 中的参数不分布被截断，如果不加这个，在 url 重写时，url 中的特殊符号后的参数部分会被截断
-   [R=301] 表示 301 重定向，如果不加 [R=301]，因为 url 规则总用了完整的 url 所以会默认 302 外部重定向，而 302 重定向对 seo 是不友好的，所以设置成 301 重定向。
-   regx
    -   (.\*): 任意匹配
    -   ^/$ : 域名根目录  <https://domain.com/>
    -   ^/(.\*)$ : URL 中/之后的所有内容


## Ref {#ref}

-   [Apache的配置文件http.conf参数详解](https://www.jianshu.com/p/ce2b7ac40454)
-   [Apache配置详解](https://blog.csdn.net/sunny_ran/article/details/78052742)
-   [Apache Module mod_rewrite](https://httpd.apache.org/docs/current/mod/mod_rewrite.html)
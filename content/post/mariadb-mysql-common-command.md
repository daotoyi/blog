+++
title = "Mariadb/Mysql common command"
date = 2022-04-04T06:47:00+08:00
lastmod = 2022-04-04T06:47:31+08:00
categories = ["Tools"]
draft = false
+++

```bash
# 登陆数据库方法
mysql -u 用户名 -p 用户密码

# 修改root及用户密码
use mysql;
update user set password=password('11111111') where user='root' and host='localhost';
privileges;

# 创建用户
insert into mysql.user(host,user,password)values("localhost","test",password("password"));
flush privileges;

# 删除用户
DELETE FROM user WHERE User="test" and Host="localhost";
flush privileges;　　

# 删除用户的数据库　　　　
drop database test1;

show databases  # 查看所有的数据库
create database # zxg：创建名尾zxg的数据库
show databases  # 查看所有的数据库
use zxg         # 进入zxg的数据库
show tables     # 查看数据库里有多少张表
```
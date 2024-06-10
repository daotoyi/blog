---
title: "邮箱协议"
author: ["SHI WENHUA"]
date: "2024-06-07 19:34:00"
lastmod: "2024-06-07 19:34:28"
categories: ["Internet"]
draft: false
---

## SMTP {#smtp}

SMTP（simple mail transfer protocol）简单邮件传输协议。

-   SMTP 协议属于 TCP/IP 协议簇，它是一组用于从源地址到目的地址传输邮件的规范，通过它来控制邮件的中转方式，帮助每台计算机在发送或中转信件时找到下一个目的地。
-   SMTP 是一个“推”的协议，它不允许根据需要从远程服务器上“拉”来消息。
-   SMTP 服务器就是遵循 SMTP 协议的发送邮件服务器。

SMTP 认证，简单地说就是要求必须在提供了账户名和密码之后才可以登录 SMTP 服务器，避免受到垃圾邮件的侵扰。


## POP {#pop}

POP（Post Office Protocol）邮局通讯协定 POP 是互联网上的一种通讯协定。

-   主要功能是用在传送电子邮件。
-   当我们寄信给另外一个人时，对方当时多半不会在线上，所以邮件服务器必须为收信者保存这封信，直到收信者来检查这封信件。
-   当收信人收信的时候，必须通过 POP 通讯协定，才能取得邮件。
-   简单来说，POP 服务器是用来收信的，而且每个 E_mail 地址一般只有一个。


## POP3 {#pop3}

POP3 是 Post Office Protocol 3 的简称

-   即邮局协议的第 3 个版本,是 TCP/IP 协议族中的一员（默认端口是 110）。
-   本协议主要用于支持使用客户端远程管理在服务器上的电子邮件。
-   它规定怎样将个人计算机连接到 Internet 的邮件服务器和下载电子邮件的电子协议。
-   它是因特网电子邮件的第一个离线协议标准,POP3 允许用户从服务器上把邮件存储到本地主机（即自己的计算机）上,同时删除保存在邮件服务器上的邮件
-   POP3 服务器则是遵循 POP3 协议的接收邮件服务器，用来接收电子邮件的。


## IMAP {#imap}

IMAP 全称是 Internet Mail Access Protocol，即交互式邮件存取协议，是一个应用层协议（端口是 143）。

-   用来从本地邮件客户端（Outlook Express、Foxmail、Mozilla Thunderbird 等）访问远程服务器上的邮件。
-   它是跟 POP3 类似邮件访问标准协议之一。
    -   不同的是，开启了 IMAP 后，您在电子邮件客户端收取的邮件仍然保留在服务器上，同时在客户端上的操作都会反馈到服务器上，如：删除邮件，标记已读等，服务器上的邮件也会做相应的动作。
-   所以无论从浏览器登录邮箱或者客户端软件登录邮箱，看到的邮件以及状态都是一致的。


## IMAP 与 POP3 的区别 {#imap-与-pop3-的区别}

-   POP3 协议允许电子邮件客户端下载服务器上的邮件，但是在客户端的操作（如移动邮件、标记已读等），不会反馈到服务器上。
-   IMAP 提供 webmail 与电子邮件客户端之间的双向通信，客户端的操作都会反馈到服务器上，对邮件进行的操作，服务器上的邮件也会做相应的动作。
-   同时，IMAP 像 POP3 那样提供了方便的邮件下载服务，让用户能进行离线阅读。
-   IMAP 提供的摘要浏览功能可以让你在阅读完所有的邮件到达时间、主题、发件人、大小等信息后才作出是否下载的决定。
-   此外，IMAP 更好地支持了从多个不同设备中随时访问新邮件。

IMAP 整体上为用户带来更为便捷和可靠的体验。POP3 更易丢失邮件或多次下载相同的邮件，但 IMAP 通过邮件客户端与 webmail 之间的双向同步功能很好地避免了这些问题
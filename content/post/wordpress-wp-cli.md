---
title: "Wordpress WP-CLI"
lastmod: "2022-05-28 19:21:48"
categories: ["VPS"]
draft: true
---

## Basic {#basic}

**需要在 wordpress 根目录/var/www/html 下执行命令**


## Common use {#common-use}

```bash
# install
docker exec -it wordpress  sh

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# set home sieturl
wp option update home 'https://metacover.tk' --allow-root
wp option update siteurl 'https://metacover.tk' --allow-root

# set email
wp option list --allow-root |grep "daotoyi"

wp user update daotoyi --user_email="wenhuas.shi@gmail.com" --allow-root
wp option  update admin_email wenhuas.shi@gmail.com --allow-root
wp option  update new_admin_email wenhuas.shi@gmail.com --allow-root
```


## Ref {#ref}

-   [wp user update](https://developer.wordpress.org/cli/commands/user/update/)
-   [wordpress 使用wpcli修改邮箱地址](https://www.wpcode.cn/442.html)
---
title: "SpaceVim"
date: "2022-04-28 20:59:00"
lastmod: "2022-05-15 23:07:48"
categories: ["VIm"]
draft: false
---

## install {#install}

```bash
curl -sLf https://spacevim.org/cn/install.sh | bash

git clone https://github.com/daotoyi/SpaceVim.d ~/.SpaceVim.d
ln -s  ~/.SpceVim.d/autoload/dylayer.vim  ~/.SpaceVim/autoload/SpaceVim/layers/dylayer.vim
```


## root {#root}

```bash
su root
ln -s /home/daoyi/.SpaceVim /root/.SpaceVim
ln -s /home/daoyi/.SpaceVim.d /root/.SpaceVim.d
ln -s /home/daoyi/.cache/vimfiles /root/.cache/vimfiles
```


## Ref {#ref}

-   [SpaceVim](https://spacevim.org/cn/quick-start-guide/)
-   [daotoyi/SpaceVim.d](https://github.com/daotoyi/SpaceVim.d)
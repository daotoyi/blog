---
title: "Linux oh-my-zsh"
date: "2022-04-15 07:11:00"
lastmod: "2024-01-03 11:09:20"
categories: ["Linux"]
draft: false
---

## zsh {#zsh}

```bash
apt install zsh
yum/dnf install zsh
pacman -S zsh

# change default terminal
chsh -s /usr/bin/zsh
```


## oh-my-zsh {#oh-my-zsh}

```bash
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
source ~/.zshrc

# plugins
$ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
$ mv zsh-syntax-highlighting ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
# $ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/

$ echo "plugins=(zsh-syntax-highlighting)" >>　~/.zshrc
$ source ~/.zshrc
```


## root user {#root-user}

```bash
sudo ln -s $HOME/.oh-my-zsh           /root/.oh-my-zsh
sudo ln -s $HOME/.zshrc               /root/.zshrc
```


## theme config {#theme-config}

```cfg
# ~/.zshrc
ZSH_THEME="random"

ZSH_THEME_RANDOM_CANDIDATES=(  "robbyrussell"  "agnoster")
```


## theme recommend {#theme-recommend}

-   powerlevel10k
-   agnoster
-   [astro](https://github.com/iplaces/astro-zsh-theme)
-   bira
-   fino
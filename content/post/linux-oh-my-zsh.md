+++
title = "Linux oh-my-zsh"
lastmod = 2022-04-11T07:46:25+08:00
categories = ["Linux"]
draft = true
+++

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

$ echo "plugins=(zsh-syntax-highlighting)" >>　~/.zshrc
$ source ~/.zshrc
```
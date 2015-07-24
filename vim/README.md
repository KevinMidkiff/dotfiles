# Vim Configuration
This repository contains my personal vim configuration file.  

# Setting Up
Before doing any of the following install Pip and Git on your system.  

## Powerline Fonts Installation
*Installation: (http://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin)*  
*Fonts: (https://github.com/powerline/fonts)*  
These instructions are for Ubuntu  

```sh
$ sudo pip install powerline-status
$ wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
$ wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
$ sudo mv PowerlineSymbols.otf /usr/share/fonts/ 
$ sudo fc-cache -vf
$ sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
$ git clone https://github.com/powerline/fonts.git
$ cd fonts
$ ./install.sh
```

## Vundle Installation
*Link: (https://github.com/VundleVim/Vundle.vim)*  
Execute the following command to install Vundle:  

```sh
$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
$ vim +PluginInstall +qall
```

## Command-T Setup
*Source: (https://github.com/wincent/Command-T)*  
*The vim version must have Ruby support built in for Command-T to work. For ubuntu install vim-nox and the support will be added*  
Execute the following commands to setup the Command-T plugin.  

```sh
$ cd ~/.vim/bundle/command-t/
$ ruby extconf.rb
$ make
```

# Helpful Links
Below are sources that I used in creating this vim configuration.  
    1. Installing Powerline: (http://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin)  
    2. Powerline Documentation: (https://powerline.readthedocs.org/en/latest/installation/linux.html)  
    3. Powerline Fonts: (https://github.com/powerline/fonts)  
    4. Vundle Repo: (https://github.com/VundleVim/Vundle.vim)  

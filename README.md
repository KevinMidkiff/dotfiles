Dotfiles
========

This repository contains various configuration files.

## Installation

To install the various configurations, use the "install.sh" script. To install
all of the configurations, simply execute:

```sh
$ ./install.sh
```

The script has the following command line options:

```
usage: ./install.sh [-h|--help] [--install-deps] [--no-vim] [--no-zsh] [--no-tmux] [--setup-ycm]
	-h|--help      : Show this help
	--install-deps : Install linux dependencies
	--no-vim       : Do not install vim configuration
	--no-zsh       : Do not install zsh configuration
	--no-tmux      : Do not install tmuxzsh configuration
	--setup-ycm    : Setup the YCM plugin
```

> **NOTE:** If `--install-deps` is specified, then you may be prompted for your
> password by `apt-get`.

## A Note on Vim

The Vim configuration in this repo depends on Vim 8+. Ubuntu does not have
the ability to install this version by default. To install Vim 8, execute the
following commands:

```sh
$ sudo add-apt-repository ppa:jonathonf/vim
$ sudo apt update
$ sudo apt install vim
```
> Source: https://itsfoss.com/vim-8-release-install/

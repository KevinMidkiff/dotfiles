# Vim Configuration
This repository contains my personal vim configuration file and instructions on how to set it up.  

> **IMPORTANT NOTE:**  
To correctly use this vim configuration you must set your TERM must have 256 colors enabled correctly. Add the following to your
`~/.bashrc` or `~/.zshrc`:
```sh
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color
```

> **Source:** [http://www.economyofeffort.com/2014/07/04/zsh/](http://www.economyofeffort.com/2014/07/04/zsh/)

# Installation
Before doing any of the following install Pip and Git on your system.    
**Please note that you need Vim with Ruby compiled into it, on Ubuntu this can be done with the following command. This is automatically install in the automated installation**  

## Automated Installation
The repository includes a bash script (install.sh) to do all of the needed install steps for vim. To use the automated install simply clone or download the repository and run the following command:

```sh
$ ./install.sh
```

> **NOTE:** This script should not be ran as sudo (it does it automatically in the script). The script will error out if you run it as sudo. Also, the script does contain error handling for checking that each individual command has run correctly.

## Manual Installation
The sections below describe all of the needed steps if you wish to install the configuration manually.

### Theme
Run the following commands to install the badwolf theme:  
```sh
$ git clone https://github.com/sjl/badwolf.git
$ mkdir -p ~/.vim/colors/
$ cp badwolf-master/colors/badwolf ~/.vim/colors/
```

### Powerline Fonts Installation
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

#### (MAC OSX) Special Step for Mac
In order to install the powerline fonts on a Mac using Iterm2 you must install a special version of MacVim.  Run the command below:  

```sh
$ brew install macvim --env-std --override-system-vim
```  

To apply the changes to Iterm2 go to: ***Preferences->Profiles->Text***, change the following two settings.  

***Regular Font:*** Inconsolata for Powerline  
***Non-ASCII Font:*** Inconsolata for Powerline  

I chose to use a 14pt font.

### (Ubuntu) Special Setup  
Install the following packages on Ubuntu:  
```sh
$ sudo apt-get install ruby
$ sudo apt-get install ruby-dev
$ sudo apt-get install vim-nox
```  

### Vundle Installation
*Link: (https://github.com/VundleVim/Vundle.vim)*  
Execute the following command to install Vundle:  

```sh
$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
$ vim +PluginInstall +qall
```

### Command-T Setup
*Source: (https://github.com/wincent/Command-T)*  
*The vim version must have Ruby support built in for Command-T to work. For ubuntu install vim-nox and the support will be added*  
Execute the following commands to setup the Command-T plugin.  

```sh
$ cd ~/.vim/bundle/command-t/ruby/command-t/
$ ruby extconf.rb
$ make
```

# Other Themes  
Below are a list of other themes I like:  
- Antares: https://github.com/Haron-Prime/Antares  

# Helpful Links
Below are sources that I used in creating this vim configuration.

* [Installing Powerline](http://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin)  
* [Powerline Documentation](https://powerline.readthedocs.org/en/latest/installation/linux.html)  
* [Powerline Fonts](https://github.com/powerline/fonts)  
* [Vundle Repo](https://github.com/VundleVim/Vundle.vim)  
* [Badwolf Vim Theme Repo](https://github.com/sjl/badwolf)
* [Installing Powerline fonts on Windows](https://medium.com/@slmeng/how-to-install-powerline-fonts-in-windows-b2eedecace58)

#!/bin/bash

# Add other settings installation
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
sudo mv PowerlineSymbols.otf /usr/share/fonts/ 
sudo fc-cache -vf
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd ..
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
cd ~/.vim/bundle/command-t/ruby/command-t/
ruby extconf.rb
make

# Add echo to make sure to set TERM=screen-256color

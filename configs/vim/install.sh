#!/bin/bash

# == IMPORTANT ==
#  ONLY USE THIS SCRIPT THROUGH THE TOP LEVEL INSTALL SCRIPT
# ===============

source ${PWD}/../../scripts/utils.sh

if [ ! -d "${HOME}/.vim/" ] ; then
    mkdir ${HOME}/.vim/
    check_error "Failed to create ~/.vim"
fi

if [ ! -d "${HOME}/.vim/bundle" ] ; then
    mkdir ~/.vim/bundle/
    check_error "Failed to create ~/.vim/bundle"
fi

# Deleting old vundle installation
if [ -d ~/.vim/bundle/Vundle.vim ] ; then
    sudo rm -r ~/.vim/bundle/Vundle.vim
    check_error "Failed to delete old Vundle installation"
fi

if [ ! -d ~/.vim/colors/ ] ; then
    mkdir -p ~/.vim/colors/
    check_error "Failed to create ~/.vim/colors/ folder"
fi

# Install themes

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
check_error "Failed to clone Vundle"

if [ ! -d ./gruvbox/ ] ; then
    git clone https://github.com/morhetz/gruvbox.git ./gruvbox/
    check_error "Failed to clone gruvbox vim theme"
fi

cp gruvbox/colors/gruvbox.vim ~/.vim/colors/
check_error "Failed to copy gruvbox theme to ~/.vim/colors/ directory"

if [ -f ~/.vimrc ] ; then
    test -h ~/.vimrc
    if [[ $? -ne 0 ]] ; then
        log_warn "Moving old ~/.vimrc file to ~/old_vimrc"
        mv ~/.vimrc ~/old_vimrc
        check_error "Failed to move old ~/.vimrc file"
    fi
fi

ln -sf ${PWD}/vimrc ~/.vimrc
check_error "Failed to create soft link to $cwd/vimrc in ${HOME} directory"
popd

vim +PluginInstall +qall
check_error "Failed to install Vundle plugins"

echo
log_info "VIM CONFIG DONE! Do not forget to add 'export TERM=screen-256color'"\
    "to your environment"
echo

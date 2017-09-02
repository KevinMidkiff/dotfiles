#!/bin/bash

RED='\033[0;31m'
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
NC='\033[0m' # No Color

cwd=${PWD}
neededPackages=(
    "vim"
    "vim-nox"
    "ruby"
    "ruby-dev"
    "git"
    "python-pip"
    "cmake"
)

function verifyNotRoot() {
    if [[ $EUID -eq 0 ]]; then
        echo -e "${RED}!!! ERROR: Should not be started as root${NC}" 1>&2
        exit -1
    fi
}

function echoWarn() {
    echo -e "${YELLOW}WARN: $1 ${NC}"
}

function echoInfo() {
    echo -e "${GREEN}INFO: $1 ${NC}"
}

function checkError() {
    if [ $? -ne 0 ] ; then
        echo -e "${RED}!!! ERROR: $1 ${NC}"
        exit -1
    fi
}

# Make sure script is running as root
verifyNotRoot

# for package in ${neededPackages[@]}
# do
#     sudo apt-get -y install $package
#     checkError "Failed to install $package"
# done

# sudo pip install powerline-status
# checkError "Failed to install pip powerline-status package"

if [ ! -d ~/.fonts/conf.d/]; then
    mkdir -p ~/.fonts/conf.f
fi

# Add other settings installation
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
checkError "Failed to get PowerlineSymbols.otf"

mv PowerlineSymbols.otf ~/.fonts/
checkError "Failed to move PowerlineSymbols.otf to ~/.fonts"

wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
checkError "Failed to get 10-powerline-symbols.conf"

mv 10-powerline-symbols.conf ~/.fonts/conf.d/
checkError "Failed to move 10-powerline-symbols.otf to /etc/fonts/conf.d/"

# sudo fc-cache -vf
# checkError "fc-cache update failed"

# Removing fonts directory if it already exists
if [ -d ./fonts/ ] ; then
    rm -r ./fonts/
    checkError "Failed to remove old ./fonts/ git repository directory"
fi

git clone https://github.com/powerline/fonts.git
checkError "Failed to clone https://github.com/powerline/fonts.git"

cd fonts
checkError "Fonts git repository folder does not exist"

./install.sh
checkError "Failed to install fonts"

cd ..

# Deleting old vundle installation
if [ -d ~/.vim/bundle/Vundle.vim ] ; then
    sudo rm -r ~/.vim/bundle/Vundle.vim
    checkError "Failed to delete old Vundle installation"
fi

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
checkError "Failed to clone Vundle"

if [ -d ./badwolf/ ] ; then
    sudo rm -r ./badwolf/
    checkError "Failed to delete old badwolf git repository directory"
fi

git clone https://github.com/sjl/badwolf.git ./badwolf/
checkError "Failed to clone badwolf vim theme"

if [ ! -d ~/.vim/colors/ ] ; then
    mkdir -p ~/.vim/colors/
    checkError "Failed to create ~/.vim/colors/ folder"
fi

cp badwolf/colors/badwolf.vim ~/.vim/colors/
checkError "Failed to copy badwolf theme to ~/.vim/colors/ directory"

pushd ${PWD}
cd ${HOME}

if [ -f ~/.vimrc ] ; then
    echoWarn "Moving old ~/.vimrc file to ~/old_vimrc"
    mv ~/.vimrc ~/old_vimrc
    checkError "Failed to move old ~/.vimrc file"
fi

ln -s $cwd/vimrc .vimrc
checkError "Failed to create soft link to $cwd/vimrc in ${HOME} directory"
popd

vim +PluginInstall +qall
checkError "Failed to install Vundle plugins"

# cd ~/.vim/bundle/command-t/ruby/command-t/
# checkError "Failed to go to ~/.vim/bundle/command-t/ruby/command-t/"
# 
# ruby extconf.rb
# checkError "Failed to execute command-t extconf.rb script"
# 
# make
# checkError "Make failed for command-t vim plugin"
# 
# cd ~/.vim/bundle/YouCompleteMe/
# ./install.sh --clang-completer
# checkError "Failed to install YouCompleteMe vim plugin"

# Add echo to make sure to set TERM=screen-256color
echo
echoInfo "DONE! Do not forget to add 'export TERM=screen-256color' to your ~/.bashrc, and you may need to change your terminal font to a powerlines one"
echo

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

function verify_not_root() {
    if [[ $EUID -eq 0 ]]; then
        echo -e "${RED}!!! ERROR: Should not be started as root${NC}" 1>&2
        exit -1
    fi
}

function echo_warn() {
    echo -e "${YELLOW}WARN: $1 ${NC}"
}

function echo_info() {
    echo -e "${GREEN}INFO: $1 ${NC}"
}

function echo_error() {
    echo -e "${RED}ERROR: $1 ${NC}"
}

function echo_fatal() {
    echo -e "${RED}FATAL: $1 ${NC}"
    exit -1
}

function check_error() {
    if [ $? -ne 0 ] ; then
        echo_fatal "$1"
    fi
}

function usage() {
    echo "usage: $1 [-h|--help] [--install-deps] [--setup-cmd-t] [--setup-ycm]"
    echo -e "\t-h|--help : Show this help"
    echo -e "\t--install-deps : Install linux dependencies"
    echo -e "\t--setup-cmd-t  : Setup the command-t plugin"
    echo -e "\t--setup-ycm    : Setup the YCM plugin with rust, C, py"
    exit 0
}


# Make sure script is running as root
# verify_not_root

install_deps=0
setup_cmd_t=0
setup_ycm=0

for var in "$@" ; do
    case "$var" in
        "-h" | "--help" )
            usage $0 ;;
        "--install-deps" )
            install_deps=1 ;;
        "--setup-cmd-t" )
            setup_cmd_t=1 ;;
        "--setup-ycm" )
            setup_ycm=1 ;;
    esac
done

if [[ $install_deps -eq 1 ]] ; then
    echo_info "Installing dependencies"
    for package in ${neededPackages[@]}
    do
        echo_info "Installing $package"
        if [[ $EUID -eq 0 ]]; then
            apt-get -y install $package
        else
            sudo apt-get -y install $package
        fi
        check_error "Failed to install $package"
    done

    echo_info "Installing Python powerline-status"
    sudo -H pip install powerline-status
    check_error "Failed to install pip powerline-status package"
fi

if [ ! -d ~/.fonts/conf.d/ ]; then
    echo_info "Creating ~/.fonts/conf.d"
    mkdir -p ~/.fonts/conf.d
    check_error "Failed to create directory ~/.fonts/conf.d"
fi

# Add other settings installation
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
check_error "Failed to get PowerlineSymbols.otf"

mv PowerlineSymbols.otf ~/.fonts/
check_error "Failed to move PowerlineSymbols.otf to ~/.fonts"

wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
check_error "Failed to get 10-powerline-symbols.conf"

mv 10-powerline-symbols.conf ~/.fonts/conf.d/
check_error "Failed to move 10-powerline-symbols.otf to /etc/fonts/conf.d/"

# sudo fc-cache -vf
# check_error "fc-cache update failed"

# Removing fonts directory if it already exists
if [ -d ./fonts/ ] ; then
    rm -r ./fonts/
    check_error "Failed to remove old ./fonts/ git repository directory"
fi

git clone https://github.com/powerline/fonts.git
check_error "Failed to clone https://github.com/powerline/fonts.git"

cd fonts
check_error "Fonts git repository folder does not exist"

./install.sh
check_error "Failed to install fonts"

cd ..

# Deleting old vundle installation
if [ -d ~/.vim/bundle/Vundle.vim ] ; then
    sudo rm -r ~/.vim/bundle/Vundle.vim
    check_error "Failed to delete old Vundle installation"
fi

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
check_error "Failed to clone Vundle"

if [ -d ./badwolf/ ] ; then
    sudo rm -r ./badwolf/
    check_error "Failed to delete old badwolf git repository directory"
fi

git clone https://github.com/sjl/badwolf.git ./badwolf/
check_error "Failed to clone badwolf vim theme"

if [ ! -d ~/.vim/colors/ ] ; then
    mkdir -p ~/.vim/colors/
    check_error "Failed to create ~/.vim/colors/ folder"
fi

cp badwolf/colors/badwolf.vim ~/.vim/colors/
check_error "Failed to copy badwolf theme to ~/.vim/colors/ directory"

pushd ${PWD}
cd ${HOME}

if [ -f ~/.vimrc ] ; then
    echo_warn "Moving old ~/.vimrc file to ~/old_vimrc"
    mv ~/.vimrc ~/old_vimrc
    check_error "Failed to move old ~/.vimrc file"
fi

ln -s $cwd/vimrc .vimrc
check_error "Failed to create soft link to $cwd/vimrc in ${HOME} directory"
popd

vim +PluginInstall +qall
check_error "Failed to install Vundle plugins"

if [[ $setup_cmd_t -eq 1 ]] ; then
    echo_info "Setting up command-t plugin"
    cd ~/.vim/bundle/command-t/ruby/command-t/
    check_error "Failed to go to ~/.vim/bundle/command-t/ruby/command-t/"

    ruby extconf.rb
    check_error "Failed to execute command-t extconf.rb script"

    make
    check_error "Make failed for command-t vim plugin"
fi

if [[ $setup_ycm -eq 1 ]] ; then
    params="--clang-completer"

    which cargo > /dev/null

    if [ $? -eq 0 ] ; then
        params="$params --rust-completer"
    fi

    echo_info "Setting up YCM with $params"

    cd ~/.vim/bundle/YouCompleteMe/
    ./install.sh $params 
    check_error "Failed to install YouCompleteMe vim plugin"
fi

echo
echo_info "DONE! Do not forget to add 'export TERM=screen-256color' to your "\
    "~/.bashrc, and you may need to change your terminal font to a powerlines"\
    " one"
echo

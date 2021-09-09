#!/bin/bash

RED='\033[0;31m'
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
NC='\033[0m' # No Color

cwd=${PWD}
needed_packages=(
    "vim"
    "git"
    "python-pip"
    "cmake"
    "tmux"
    "zsh"
)

function verify_not_root() {
    if [[ $EUID -eq 0 ]]; then
        echo -e "${RED}!!! ERROR: Should not be started as root${NC}" 1>&2
        exit -1
    fi
}

function log_warn() {
    echo -e "${YELLOW}WARN: $1 ${NC}"
}

function log_info() {
    echo -e "${GREEN}INFO: $1 ${NC}"
}

function log_error() {
    echo -e "${RED}ERROR: $1 ${NC}"
}

function log_fatal() {
    echo -e "${RED}FATAL: $1 ${NC}"
    exit -1
}

function check_error() {
    if [ $? -ne 0 ] ; then
        log_fatal "$1"
    fi
}

function install_config() {
    args=( $@ )
    params=( "${args[@]:1}" )
    dir=$1

    cd ./$dir/
    check_error "Failed to go to directory ./$dir/"

    log_info "Installing $dir configuration"

    ./install.sh ${params[*]}
    check_error "Failed to install $dir configuration"

    cd ..
    check_error "Failed to return to root directory"
}

function usage() {
    echo "usage: $1 [-h|--help] [--install-deps] [--no-vim] [--no-zsh] [--no-tmux] [--setup-ycm]"
    echo -e "\t-h|--help      : Show this help"
    echo -e "\t--install-deps : Install linux dependencies"
    echo -e "\t--no-vim       : Do not install vim configuration"
    echo -e "\t--no-zsh       : Do not install zsh configuration"
    echo -e "\t--no-tmux      : Do not install tmuxzsh configuration"
    echo -e "\t--setup-ycm    : Setup the YCM plugin"
    exit 0
}

install_deps=0
install_vim_conf=1
install_zsh_conf=1
install_tmux_conf=1
setup_ycm=0

for var in "$@" ; do
    case "$var" in
        "-h" | "--help" )
            usage $0 ;;
        "--install-deps" )
            install_deps=1 ;;
        "--setup-ycm" )
            setup_ycm=1 ;;
        "--no-vim" )
            install_vim_conf=0 ;;
        "--no-zsh" )
            install_zsh_conf=0 ;;
        "--no-tmux" )
            install_tmux_conf=0 ;;
    esac
done

if [[ $install_vim_conf -eq 0 ]] && [[ $install_zsh_conf -eq 0 ]] && [[ $install_tmux_conf -eq 0 ]] ; then
    log_fatal "No configuration specified to be installed"
fi

# Make sure submodules are downloaded
git submodule update --init

if [[ $install_deps -eq 1 ]] ; then
    log_info "Installing dependencies"
    for package in ${needed_packages[@]}
    do
        log_info "Installing $package"
        if [[ $EUID -eq 0 ]]; then
            apt-get -y install $package
        else
            sudo apt-get -y install $package
        fi
        check_error "Failed to install $package"
    done

    log_info "Installing Python powerline-status"
    sudo -H pip install powerline-status
    check_error "Failed to install pip powerline-status package"
fi

if [[ $install_vim_conf -eq 1 ]] ; then
    params=""
    if [[ $setup_ycm -eq 1 ]] ; then
        params="--setup-ycm"
    fi

    install_config "vim" $params
fi

if [[ $install_zsh_conf -eq 1 ]] ; then
    install_config "zsh"
fi

if [[ $install_tmux_conf -eq 1 ]] ; then
    install_config "tmux"
fi

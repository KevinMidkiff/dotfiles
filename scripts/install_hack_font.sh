#!/bin/bash

RED='\033[0;31m'
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
NC='\033[0m' # No Color

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

base_url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts"
font_filename="HackNerdFont-Regular.ttf"
font_path="Hack/Regular"

uname_out="$(uname -s)"

case "${uname_out}" in 
    Linux*)  machine=Linux;;
    Darwin*) machine=Darwin;;
    *)
        log_fatal "Unsupported OS: ${uname_out}" ;;
esac

if [[ "${machine}" -eq "Linux" ]] ; then
    if [ ! -d "~/.local/share/fonts" ] ; then
        log_info "Creating fonts directory"
        mkdir -p ~/.local/share/fonts
        check_error "Failed to create fonts directory"
    fi
        
    cd ~/.local/share/fonts 
    check_error "Failed to go to honts directory"

    log_info "Downloading font: ${font_filename}"
    curl -fLo \
        "${font_filename}" \
        ${base_url}/${font_path}/${font_filename} 
    check_error "Failed to download font"

    log_info "Reloading font cache"
    fc-cache -f -v
    check_error "Failed to rebuild font cache"
else
    cd ~/Library/Fonts 
    check_error "Failed to go to ~/Library/Fonts"
    
    log_info "Downloading font: ${font_filename}"
    curl -fLo \
        "${font_filename}" \
        ${base_url}/${font_path}/${font_filename} 
    check_error "Failed to download font"
fi

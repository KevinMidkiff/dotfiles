#!/bin/bash

# Import utilities
source ${PWD}/../../scripts/utils.sh

##
## Install various commonly used Ubuntu packages
##

# Verify running on Ubuntu
assert-distro "Ubuntu"

version=$(lsb_release -s -r)
check_error "Failed to get Ubuntu version"

pkgs="${PWD}/pkgs/${version}"

if [ ! -f "${pkgs}" ] ; then
    log_fatal "Unsupported Ubuntu version: ${version}"
fi

cat ${pkgs} | xargs sudo apt install -y
if [[ "${PIPESTATUS[1]}" -ne 0 ]] ; then
    log_fatal "Failed to install Ubuntu packages"
fi

nvim_version=$(cat ${PWD}/nvim-version)
nvim_url="https://github.com/neovim/neovim/releases/download/${nvim_version}/nvim-linux64.tar.gz"
install_location=/opt/nvim-linux64/

if [ -d "${install_location}" ] ; then
    log_info "neovim already installed"
else
    neovim_tarfile=${PWD}/nvim-linux64.tar.gz
    if [ -f "${neovim_tarfile}" ] ; then
        rm ${neovim_tarfile}
        check_error "Failed to delete previous download"
    fi

    log_info "Downloading NeoVIM version ${nvim_version}"
    wget ${nvim_url}
    check_error "Failed to download NeoVIM"

    cwd=${PWD}
    cd /opt/
    check_error "Failed to go to /opt/ directory"

    log_info "Extracting neovim tarfile to /opt/"
    sudo tar xvf ${neovim_tarfile}
    check_error "Failed to extract neovim"

    log_info "Creating neovim binary soft-links to /usr/local/"

    sudo ln -sf /opt/nvim-linux64/bin/* /usr/local/bin/
    check_error "Failed to create soft-links for neovim binary"

    sudo ln -sf /opt/nvim-linux64/lib/* /usr/local/lib/
    check_error "Failed to create soft-links for neovim libs"

    sudo ln -sf /opt/nvim-linux64/share/* /usr/local/share/man/
    check_error "Failed to create soft-links for neovim libs"

    sudo ln -sf /opt/nvim-linux64/share/* /usr/local/share/
    check_error "Failed to create soft-links for neovim libs"
fi

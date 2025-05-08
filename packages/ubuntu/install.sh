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
nvim_url="https://github.com/neovim/neovim/releases/download/${nvim_version}/nvim-linux-x86_64.tar.gz"
install_location=/opt/nvim-linux-x86_64/

if [ -d "${install_location}" ] ; then
    log_info "neovim already installed"
else
    neovim_tarfile=${PWD}/nvim-linux-x86_64.tar.gz
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

    log_warn "!!! ATTENTION !!!"
    log_warn "Neovim has been installed into ${install_location}"
    log_warn "Make sure to either soft-link this into your PATH OR"
    log_warn "Make sure to add the ${install_location}/bin/ to your PATH"

    ## TODO: Was lazy and didn't care to finish figuring this out right now,
    ##       will need to fix it in the future.
    # log_info "Creating neovim binary soft-links to /usr/local/"

    #sudo ln -sf ${install_location}/bin/* /usr/local/bin/
    #check_error "Failed to create soft-links for neovim binary"

    #sudo ln -sf ${install_location}/lib/* /usr/local/lib/
    #check_error "Failed to create soft-links for neovim libs"

    # sudo ln -sf ${install_location}/share/* /usr/local/share/man/
    # check_error "Failed to create soft-links for neovim libs"

    # sudo ln -sf ${install_location}/share/* /usr/local/share/
    # check_error "Failed to create soft-links for neovim libs"
fi

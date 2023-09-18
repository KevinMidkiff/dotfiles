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

# TODO(kmidkiff): Install neovim

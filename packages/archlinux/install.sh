#!/bin/bash

# Import utilities
source ${PWD}/../../scripts/utils.sh

pkgs="${PWD}/pkgs/${version}"
pkgs="${PWD}/pkgs.txt"

if [ ! -f "${pkgs}" ] ; then
    log_fatal "Cannot find ${pkgs} file"
fi

cat ${pkgs} | xargs sudo pacman -Sy --noconfirm 
if [[ "${PIPESTATUS[1]}" -ne 0 ]] ; then
    log_fatal "Failed to install archlinux packages"
fi

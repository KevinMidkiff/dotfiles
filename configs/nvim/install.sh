#!/bin/bash

# == IMPORTANT ==
#  ONLY USE THIS SCRIPT THROUGH THE TOP LEVEL INSTALL SCRIPT
# ===============

source ${PWD}/../../scripts/utils.sh

if [ ! -d "${HOME}/.config" ] ; then
    log_info "Creating ${HOME}/.config directory"
    mkdir ${HOME}/.config
    check_error "Failed to create directory ${HOME}/.config"
fi

ln -sf ${PWD} ${HOME}/.config/nvim
check_error "Failed to create soft link to ${PWD}/ directory"

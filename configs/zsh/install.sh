#!/bin/bash

# == IMPORTANT ==
#  ONLY USE THIS SCRIPT THROUGH THE TOP LEVEL INSTALL SCRIPT
# ===============

source ${PWD}/../../scripts/utils.sh

if [ -f ~/.zshrc ] ; then
    test -h ~/.zshrc
    if [[ $? -ne 0 ]] ; then
        log_warn "Moving old ~/.zshrc file to ~/old_zshrc"
        mv ~/.zshrc ~/old_zshrc
        check_error "Failed to move old ~/.zshrc file"
    fi
fi

ln -sf $PWD/zshrc ~/.zshrc
check_error "Failed to create soft link to $cwd/zshrc in ${HOME} directory"

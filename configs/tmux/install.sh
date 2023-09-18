#!/bin/bash

# == IMPORTANT ==
#  ONLY USE THIS SCRIPT THROUGH THE TOP LEVEL INSTALL SCRIPT
# ===============

source ${PWD}/../../scripts/utils.sh

if [ -f ~/.tmux.conf ] ; then
    test -h ~/.tmux.conf
    if [[ $? -ne 0 ]] ; then
        log_warn "Moving old ~/.tmux.conf file to ~/old_tmux.conf"
        mv ~/.tmux.conf ~/old_tmux.conf
        check_error "Failed to move old ~/.tmux.conf file"
    fi
fi

ln -sf ${PWD}/tmux.conf ~/.tmux.conf
check_error "Failed to create soft link to $cwd/tmux.conf in ${HOME} directory"

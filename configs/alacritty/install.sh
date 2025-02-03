#!/bin/bash

# == IMPORTANT ==
#  ONLY USE THIS SCRIPT THROUGH THE TOP LEVEL INSTALL SCRIPT
# ===============

source ${PWD}/../../scripts/utils.sh
cfg="alacritty.toml"
dst="${HOME}/.${cfg}"
src="${PWD}/${cfg}"
old="${HOME}/old_${cfg}"

if [ -f "${dst}" ] ; then
    test -h "${dst}"
    if [[ $? -ne 0 ]] ; then
        log_warn "Moving old ${dst} file to ${old}"
        mv ${dst} ${old}
        check_error "Failed to move old ${dst} file"
    fi
fi

ln -sf ${src} ${dst}
check_error "Failed to create soft link - src: ${src}, dst: ${dst}"

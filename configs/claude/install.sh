#!/bin/bash

# == IMPORTANT ==
#  ONLY USE THIS SCRIPT THROUGH THE TOP LEVEL INSTALL SCRIPT
# ===============

source ${PWD}/../../scripts/utils.sh

CONFIG_DIR="${HOME}/.claude"
SETTINGS="${CONFIG_DIR}/settings.json"
STATUSLINE="${CONFIG_DIR}/statusline.sh"

if [ ! -d "${CONFIG_DIR}" ] ; then
    log_info "Creating Claude config dir: ${CONFIG_DIR}"
    mkdir -p ${CONFIG_DIR}
    check_error "Failed to create Claude config dir"
fi

if [ ! -f "${SETTINGS}" ] ; then
    log_info "Linking settings file to ${SETTINGS}"
    ln -sf ${PWD}/settings.json ${SETTINGS}
    check_error "Failed to link settings JSON file"
fi

if [ ! -f "${STATUSLINE}" ] ; then
    log_info "Linking statusline script to ${STATUSLINE}"
    ln -sf ${PWD}/statusline.sh ${STATUSLINE}
    check_error "Failed to link statusline script"
fi

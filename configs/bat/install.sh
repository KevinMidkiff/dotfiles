#!/bin/bash

# == IMPORTANT ==
#  ONLY USE THIS SCRIPT THROUGH THE TOP LEVEL INSTALL SCRIPT
# ===============

source ${PWD}/../../scripts/utils.sh

BAT_BIN=$(which bat)
if [ "$?" -ne 0 ] ; then
    BAT_BIN=$(which batcat)
    if [ "$?" -ne 0 ] ; then
        log_fatal "Cannot find bat or batcat binary"
    fi
fi

CONFIG_DIR=$(${BAT_BIN} --config-dir)
if [ ! -d "${CONFIG_DIR}" ] ; then
    log_info "Creating bat config dir: ${CONFIG_DIR}"
    mkdir -p ${CONFIG_DIR}/themes
    assert "Failed to create directory ${CONFIG_DIR}"
fi

theme_fn="$(bat --config-dir)/theme/Catppuccin Mocha.tmTheme"
if [ ! -f "${theme_fn}" ] ; then
    log_info "Downloading bat theme"
    wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
    assert "Failed to download theme"
fi

log_info "Rebuilding bat cache"
bat cache --build
assert "Failed to rebuild bat cache"

log_info "Setting up bat theme"
echo "--theme=\"Catppuccin Mocha\"" >> $(bat --config-file)
assert "Failed to setup theme"

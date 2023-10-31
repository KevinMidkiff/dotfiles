#!/bin/bash

source ${PWD}/scripts/utils.sh

base_url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts"
font_filename="HackNerdFont-Regular.ttf"
font_path="Hack/Regular"

uname_out="$(uname -s)"

case "${uname_out}" in
    Linux*)  machine=Linux;;
    Darwin*) machine=Darwin;;
    *)
        log_fatal "Unsupported OS: ${uname_out}" ;;
esac

if [[ "${machine}" == "Linux" ]] ; then
    log_info "Linux???"
    if [ ! -d "~/.local/share/fonts" ] ; then
        log_info "Creating fonts directory"
        mkdir -p ~/.local/share/fonts
        check_error "Failed to create fonts directory"
    fi

    cd ~/.local/share/fonts
    check_error "Failed to go to honts directory"

    log_info "Downloading font: ${font_filename}"
    curl -fLo \
        "${font_filename}" \
        ${base_url}/${font_path}/${font_filename}
    check_error "Failed to download font"

    log_info "Reloading font cache"
    fc-cache -f -v
    check_error "Failed to rebuild font cache"
else
    cd ~/Library/Fonts
    check_error "Failed to go to ~/Library/Fonts"

    log_info "Downloading font: ${font_filename}"
    curl -fLo \
        "${font_filename}" \
        ${base_url}/${font_path}/${font_filename}
    check_error "Failed to download font"
fi

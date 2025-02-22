#!/bin/bash

SELF=$( cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SELF}/utils.sh

if [[ $(is_macos) -ne 0 && $(is_linux) -ne 0 ]] ; then
    log_fatal "Unsupported platform $(uname -a)"
fi

if [ ! -d "~/miniconda3" ] ; then
    log_info "Creating ~/miniconda3"
    mkdir ~/miniconda3
    check_error "Failed to create ~/miniconda3"
fi

if is_macos ; then
    log_info "Downloadind MacOS miniconda installer"
    curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh
    check_error "Failed to download miniconda installer"

    mv Miniconda3-latest-MacOSX-arm64.sh ~/miniconda3/miniconda.sh
else
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
        -O ~/miniconda3/miniconda.sh
    check_error "Failed to download miniconda installer"
fi

log_info "Running miniconda installer"
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
check_error "Miniconda installer failed"

log_info "Cleaning up"
rm ~/miniconda3/miniconda.sh
check_error "Failed to clean-up..."

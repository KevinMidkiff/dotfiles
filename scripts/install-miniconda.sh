#!/bin/bash

SELF=$( cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SELF}/utils.sh

# Just for now...
assert-linux

if [ ! -d "~/miniconda3" ] ; then
    log_info "Creating ~/miniconda3"
    mkdir ~/miniconda3
    check_error "Failed to create ~/miniconda3"
fi


log_info "Getting miniconda installer"
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    -O ~/miniconda3/miniconda.sh
check_error "Failed to download miniconda installer"

log_info "Running miniconda installer"
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
check_error "Miniconda installer failed"

log_info "Cleaning up"
rm ~/miniconda3/miniconda.sh
check_error "Failed to clean-up..."

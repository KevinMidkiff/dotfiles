#!/bin/bash

# Import utilities
source ${PWD}/../../scripts/utils.sh

##
## Install various commonly used Homebrew packages
##

# Verify running on Mac
assert-macos

# Install homebrew packages
log_info "Installing Homebrew packages"
cat ${PWD}/pkgs | xargs brew install
if [[ "${PIPESTATUS[1]}" -ne 0 ]] ; then
    log_fatal "Failed to install Homebrew packages"
fi
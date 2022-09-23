#!/bin/bash

# == IMPORTANT ==
#  ONLY USE THIS SCRIPT THROUGH THE TOP LEVEL INSTALL SCRIPT
# ===============

RED='\033[0;31m'
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
NC='\033[0m' # No Color

cwd=${PWD}

function verify_not_root() {
    if [[ $EUID -eq 0 ]]; then
        echo -e "${RED}!!! ERROR: Should not be started as root${NC}" 1>&2
        exit -1
    fi
}

function log_warn() {
    echo -e "${YELLOW}WARN: $1 ${NC}"
}

function log_info() {
    echo -e "${GREEN}INFO: $1 ${NC}"
}

function log_error() {
    echo -e "${RED}ERROR: $1 ${NC}"
}

function log_fatal() {
    echo -e "${RED}FATAL: $1 ${NC}"
    exit -1
}

function check_error() {
    if [ $? -ne 0 ] ; then
        log_fatal "$1"
    fi
}

function usage() {
    log_error "ONLY USE THIS SCRIPT THROUGH THE TOP LEVEL INSTALL SCRIPT"
    exit 0
}

ln -s ${PWD} ${HOME}/.config/nvim
check_error "Failed to create soft link to ${PWD}/nvim/ directory"

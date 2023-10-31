#!/bin/bash

##
## Various bash utility functions
##

# Various helpful colors
RED='\033[0;31m'
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
NC='\033[0m' # No Color

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

function assert-linux() {
    uname_out="$(uname -s)"
    if [[ "${uname_out}" =~ "Linux"* ]] ; then
        log_info "Running on Linux"
    else
        log_fatal "Not running on Linux"
    fi
}

function assert-macos() {
    uname_out="$(uname -s)"
    if [[ "${uname_out}" =~ "Darwin"* ]] ; then
        log_info "Running on Mac"
    else
        log_fatal "Not running on Mac"
    fi
}

function assert-distro() {
    # First verify running on Linux
    assert-linux

    # Verify lsb_release
    lsb_release -a >/dev/null &2>/dev/null
    check_error "Missing 'lsb_release'"

    expected="$1"
    distro_id=$(lsb_release -s -i)
    if [ "${distro_id}" != "${expected}" ] ; then
        log_fatal "Incorrect distro - got '${distro_id}', expected '${expected}'"
    fi
}

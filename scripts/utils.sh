#!/bin/bash

##
## Various bash utility functions
##

# Various helpful colors
RED='\033[0;31m'
YELLOW="\033[1;33m"
GREEN="\033[0;32m"
GREY="\033[2;49m"
NC='\033[0m' # No Color

function ts() {
    date --iso-8601="seconds"
}

function log() {
    level=$1
    color=$2
    msg=$3
    echo -e "${GREY}[$(ts)${NC} ${color}${level}${NC}${GREY}]${NC} ${msg}"
}

function log_warn() {
    log "WARN" "${YELLOW}" "$1"
}

function log_info() {
    log "INFO" "${GREEN}" "$1"
}

function log_error() {
    log "ERROR" "${RED}" "$1"
}

function log_fatal() {
    log "FATAL" "${RED}" "${RED}$1${NC}"
    exit -1
}

function assert() {
    if [ $? -ne 0 ] ; then
        log_fatal "$1"
    fi
}

function check_error() {
    assert "${1}"
}

function verify_not_root() {
    if [[ $EUID -eq 0 ]]; then
        echo -e "${RED}!!! ERROR: Should not be started as root${NC}" 1>&2
        exit -1
    fi
}

function is_linux() {
    uname_out="$(uname -s)"
    if [[ "${uname_out}" =~ "Linux"* ]] ; then
        return 0
    else
        return 1
    fi
}

function is_macos() {
    uname_out="$(uname -s)"
    if [[ "${uname_out}" =~ "Darwin"* ]] ; then
        return 0
    else
        return 1
    fi
}

function assert-linux() {
    if is_linux ; then
        log_info "Running on Linux"
    else
        log_fatal "Not running on Linux"
    fi
}

function assert-macos() {
    if is_macos ; then
        log_info "Running on Linux"
    else
        log_fatal "Not running on Linux"
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

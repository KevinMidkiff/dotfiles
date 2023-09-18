#!/bin/bash

##
## Various bash utility functions
##

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

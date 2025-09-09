#!/bin/bash

##
## Utility for ssh'ing to systems via Cloudflare Warp
##

function _comp_warpssh {
    clist=$(ssh he "sed -n 's/^Host \(.*\)/\1/p' ~/.ssh/config")
    COMPREPLY=($(compgen -W "$clist" -- $2))
}

function warpssh {
    host="${1}"
    shift 1
    ssh -o ProxyCommand="ssh he netcat %h %p" ${host} ${@}
}
complete -o bashdefault -F _comp_warpssh warpssh

function warpscp {
    scp -o ProxyCommand="ssh he netcat %h %p" ${@}
}


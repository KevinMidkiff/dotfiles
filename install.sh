#!/bin/bash

source ${PWD}/scripts/utils.sh

function exec-install() {
    cwd=${PWD}
    args=( $@ )
    params=( "${args[@]:1}" )
    dir=$1/$2
    pkg_name=$(basename ${dir})

    cd $dir
    check_error "Failed to go to directory '$dir'"

    if [ ! -f "${PWD}/install.sh" ] ; then
        log_warn "No installer for ${pkg_name}"
    else
        log_info "Installing ${pkg_name} configuration"
        ./install.sh ${params[*]}
        check_error "Failed to install $dir configuration"
    fi

    cd ${cwd}
    check_error "Failed to return to root directory"
}

function usage() {
    echo "usage: $1 [-h] [-c <package> -c ...] [-p <platform>]"
    echo -e "\t-h               - Show this help"
    echo -e "\t-c <package>     - Install configuration for the specified package"
    echo -e "\t-p <platform>    - Install expected applications for the platform"
    exit 0
}

install_all=0
configs=()
install_pkgs=0
pkgs=""

while getopts ":c:h:p:f:" arg ; do
    case ${arg} in
        # Install configs for OPTARG application
        c)
            # Fail if all is already specified
            if [[ ${install_all} -eq 1 ]] ; then
                log_fatal "Unnecessary argument '-i ${OPTARG}', '-i all' already specified"
            fi

            if [ "${OPTARG}" == "all" ] ; then
                log_warn "Installing ALL configurations"
                install_all=1
                configs=$(ls ./configs/)
            elif [[ " ${configs[*]} " =~ " ${OPTARG} " ]] ; then
                log_fatal "${OPTARG} config specified twice"
            else
                if [ ! -d "${PWD}/configs/${OPTARG}" ] ; then
                    log_fatal "Unknown application to configure: ${OPTARG}"
                fi

                configs+=("${OPTARG}")
            fi
            ;;

        # Install packages for OPTARG platform
        p)
            if [[ ${install_pkgs} -eq 1 ]] ; then
                log_fatal "Already specified packages to install"
            fi

            if [ ! -d "${PWD}/packages/${OPTARG}" ] ; then
                log_fatal "Unknown packages installer: ${OPTARG}"
            fi

            pkgs="${OPTARG}"
            install_pkgs=1
            ;;

        # Default
        *)
            if [ "${OPTARG}" == "h" ] ; then
                usage $0
                exit 0
            else
                log_fatal "Unknown argument - arg: ${arg} OPTARG: ${OPTARG}"
            fi
            ;;
    esac
done

if [ "${install_pkgs}" -eq 0 ] && [ ${#configs[@]} -eq 0 ] ; then
    log_fatal "Nothing to do"
fi

# Make sure submodules are downloaded
git submodule update --init
check_error "Getting submodules failed"

if [[ ${install_pkgs} -eq 1 ]] ; then
    log_info "Installing packages for platform: ${pkgs}"
    exec-install ${PWD}/packages/ ${pkgs}
    check_error "Failed to install packages for platform: ${pkgs}"
fi

if [[ ${install_all} -eq 1 ]] ; then
    log_info "Installing ALL application configurations"
fi

for i in ${configs[*]} ; do
    exec-install ${PWD}/configs ${i}
done

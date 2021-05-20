#!/bin/bash

DEBUG=true

HOME_PATH=$(eval echo ~${SUDO_USER})
OMZ_PATH=${HOME_PATH}/.oh-my-zsh
ZPLUG_PATH=${HOME_PATH}/.zplug
DEV_FONTS_PATH=${HOME_PATH}/.local/share/fonts/dev_fonts

function log() {
    if [ ${DEBUG} = true ]; then
        echo "L:${BASH_LINENO[0]}- $@"
    else
	echo "$@"
    fi
}

function my_cd() {
    # wrapper for cd command in bash script
    if [ ${DEBUG} = true ]; then 
	log "The given path:" $1
    fi

    if [ -d $1 ]; then
	cd $1
    else
	log "Invalid directory was given." 2>&1
	exit
    fi
}

function chsh_shell() {
    if [ -z "$(grep $(command -v bash) /etc/shells)" ]; then
        command -v bash | tee -a /etc/shells
    fi
    chsh -s $(command -v bash) ${SUDO_USER}
}

function clear_home_path_zsh_stuffs() {
    my_cd ${HOME_PATH}
    rm -rf ${OMZ_PATH}
    rm -rf ${ZPLUG_PATH}
    rm -rf tmp-????????-??????????/
    rm -f .zsh*
    rm -f .p10k.zsh*
    rm -f .zcompdump*
}

function clear_dev_fonts() {
    rm -rf ${DEV_FONTS_PATH}
    my_cd ${HOME_PATH}
    fc-cache -fv
}

clear_dev_fonts
clear_home_path_zsh_stuffs
chsh_shell



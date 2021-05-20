#!/usr/bin/env bash

############################################################################
# --------------------------------------------------------------
#      ____            __                                      
#     / __ \  ____    / /_   ____   _____  ____ _   _____  ___ 
#    / /_/ / / __ \  / __ \ / __ \ / ___/ / __ `/  / ___/ / _ \
#   / _, _/ / /_/ / / /_/ // /_/ // /__  / /_/ /  / /    /  __/
#  /_/ |_|  \____/ /_.___/ \____/ \___/  \__,_/  /_/     \___/ 
#                                                             
# --------------------------------------------------------------
#
# Robocare License (RCL)
#
# Copyright (c) Robocare, Inc. - All Rights Reserved
#
# This software is proprietary and confidential.
# Unauthorized copying of this file, via any medium is strictly prohibited.
############################################################################

DEBUG=true

HOME_PATH=$(eval echo ~${SUDO_USER})
WORKING_DIR=$(mktemp -d -t tmp-$(date +%Y%m%d)-XXXXXXXXXX --tmpdir=${HOME_PATH})
OMZ_PATH=${HOME_PATH}/.oh-my-zsh

OUTPUT_LOGFILE=${WORKING_DIR}/install.log
ERROR_LOGFILE=${WORKING_DIR}/install_error.log

SUPPORTED_DEBIAN=("10" "11")
SUPPORTED_UBUNTU=("16.04" "18.04" "20.04")

# Install several fundamental packages
PACKAGES="acl build-essential ca-certificates curl git libtool lsb-release make openssl pkg-config sudo unzip vim wget zip"

# Install python development packages
LANG_PACKAGES="python3-dev python3-pip virtualenv cargo golang-go"

# TODO: add more packages you want to install
ADDITIONAL_PACKAGES="autojump cscope exuberant-ctags fontconfig fonts-powerline jq tmux"

# Install useful utilities, you can choose which one you want to install by y-or-n question
USEFUL_UTILS="bat fd fzf ripgrep marker cheat bit exa loop yank nnn tokei bpytop tldr lazydocker"

# More useful utility candidates
MORE_USEFUL_UTILS="logo-ls"

COMMON_CONFIGS_URI="http://192.168.112.182/knowledge-base/technicalreport/common_configs.git"

############################################################################
# Colors, from ANSI escape codes
export RESET="\e[0m"  # text reset, no color, no highlight
export BOLD="\e[1m"

export RED="\e[31m"
export GREEN="\e[32m"
export YELLOW="\e[33m"
export BLUE="\e[34m"
export PURPLE="\e[35m"
export CYAN="\e[36m"
export WHITE="\e[37m"

############################################################################



############################################################################
echo -e "\n\n${GREEN}${BOLD}0. Check if user is non-root and don't have sudo privilege.${RESET}"

function ctrl_c() {
    echo -en "\n\n${RED}${BOLD}*** Ouch! Exiting ***\n${RESET}"
    exit $?
}
trap ctrl_c SIGINT

function log() {
    if [ ${DEBUG} = true ]; then
        echo -e "${YELLOW}L:${BASH_LINENO[0]}${RESET}- $@" 2>&1
    else
	echo -e "$@"
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
	log "Invalid directory was given."
	exit
    fi
}

# Check if user is non-root
if [ ${EUID} -eq 0 ] ; then
    log "Do not run this script with root or with the sudo command."
    exit 1
fi
############################################################################



############################################################################
echo -e "\n\n${GREEN}${BOLD}1. Check if your environment is supported.${RESET}"

function check_environment() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=${NAME}
        VER=${VERSION_ID}
    elif type lsb_release >/dev/null 2>&1; then
	OS=$(lsb_release -si)
	VER=$(lsb_release -sr)
    elif [ -f /etc/lsb-release ]; then
	# for some versions of Debian/Ubuntu without lsb_release command
	. /etc/lsb-release
	OS=${DISTRIB_ID}
	VER=${DISTRIB_RELEASE}
    elif [ -f /etc/debian_version ]; then
	OS="Debian"
	VER=$(cat /etc/debian_version)
    else
	OS=$(uname -s)
	VER=$(uname -r)
    fi
}

function check_supported_distro() {
    if [ ${OS} == "Ubuntu" ]; then
	for ver in ${SUPPORTED_UBUNTU[*]}
            do
		if [ ${ver} == ${VER} ]; then
		    log "Your environement: " ${CYAN}${BOLD}${OS} ${VER}${RESET} "is supported."
		fi
	    done
    elif [ ${OS} == "Debian" ]; then
        for ver in ${SUPPORTED_DEBIAN[*]}
            do
                if [ ${ver} == ${VER} ]; then
                    log "Your environment: " ${CYAN}${BOLD}${OS} ${VER}${RESET} "is supported."
		fi
            done
    else
	log "Your environment: "${CYAN}${BOLD}${OS} ${VER}${RESET} "is NOT supported." 2>&1
	exit 2
    fi
}

# Check if the running environment is supported
check_environment
check_supported_distro
############################################################################



############################################################################
echo -e "\n\n${GREEN}${BOLD}2. Install some fundamental packages.${RESET}"

function install_fundamentals() {
    sudo apt-get update
    for package in $@
    do
        #sudo apt-get install --print-uris $package >> ${OUTPUT_LOGFILE} 2>>${ERROR_LOGFILE}
        sudo apt-get -y install $package
    done
}

install_fundamentals ${PACKAGES}


echo -e "\n\n${GREEN}${BOLD}3. Install additional packages.${RESET}"
function install_additional_packages() {
    for package in $@
    do
	#sudo apt-get install --print-uris $package >> ${OUTPUT_LOGFILE} 2>>${ERROR_LOGFILE}
	sudo apt-get -y install $package
    done
}

install_additional_packages ${ADDITIONAL_PACKAGES}

function install_devel_packages() {
    for package in $@
    do
        sudo apt-get -y install $package
    done
}

install_devel_packages ${LANG_PACKAGES}

############################################################################



############################################################################
# Setup common_configs
echo -e "\n\n${GREEN}${BOLD}4. Setup common_configs.\n Cloning common_configs from Robocare VCS...${RESET}"

if [ ! -d ${WORKING_DIR} ]; then
    log "Something wrong in making a temporary working directory."
    exit 3
fi

my_cd ${WORKING_DIR}

# TODO: if git clone fails, force to quit the installation
git clone ${COMMON_CONFIGS_URI}
if [ $? -ne 0 ]; then
    log "Failed to clone ${YELLOW}${BOLD}common_configs${RESET}."
    exit 3
fi
############################################################################



############################################################################
# Install common utilities and fonts for developers
echo -e "\n\n${GREEN}${BOLD}5. Install common utilities...${RESET}"

return_value=""
function ask_yes_or_no() {
    echo  # (optional) move to a new line
    read -p "$(echo -e ${YELLOW}" Do you want to install <$1>? "${RESET})" -n 1 -r
    echo  # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "\n Install ${CYAN}<$1>${RESET}..."
    else
	echo -e "\n You skipped ${CYAN}<$1>${RESET}."
    fi
}

function install_utilities() {
    # check if jq, curl, wget are installed successfully
    if [[ ! -x "$(command -v jq)" || ! -x "$(command -v curl)" || ! -x "$(command -v wget)" ]]; then
        log "The command jq not found."
        exit 4
    fi    

    # ncdu, htop, 
    sudo apt-get -y install ncdu htop bmon httpie

    # Let user choose packages he/she wants to install
    for package in ${USEFUL_UTILS}
    do
	ask_yes_or_no ${package}
        if [ $REPLY == "y" ]; then install_${package}; fi
    done
}

function install_bat() {  
    # bat: https://github.com/sharkdp/bat
    full_url=$(curl -sL https://api.github.com/repos/sharkdp/bat/releases/latest | jq -r '.assets[].browser_download_url' | grep musl | grep amd64.deb)
    url_nopro=${full_url:7}
    bat_latest_filename=${url_nopro##/*/}

    curl -sL https://api.github.com/repos/sharkdp/bat/releases/latest | jq -r '.assets[].browser_download_url' | grep musl | grep ${bat_latest_filename} | wget -i -

    sudo dpkg -i ${bat_latest_filename}
}

function install_fd() {  
    # fd: https://github.com/sharkdp/fd
    full_url=$(curl -sL https://api.github.com/repos/sharkdp/fd/releases/latest | jq -r '.assets[].browser_download_url' | grep musl | grep amd64.deb)
    url_nopro=${full_url:7}
    fd_latest_filename=${url_nopro##/*/}

    curl -sL https://api.github.com/repos/sharkdp/fd/releases/latest | jq -r '.assets[].browser_download_url' | grep musl | grep ${fd_latest_filename} | wget -i -

    sudo dpkg -i ${fd_latest_filename}
}

function install_fzf() {  
    # fzf: https://github.com/junegunn/fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

function install_ripgrep() {
    # ripgrep: https://github.com/BurntSushi/ripgrep
    full_url=$(curl -sL https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | jq -r '.assets[].browser_download_url' | grep amd64.deb)
    url_nopro=${full_url:7}
    ripgrep_latest_filename=${url_nopro##/*/}

    curl -sL https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | jq -r '.assets[].browser_download_url' | grep ${ripgrep_latest_filename} | wget -i -

    sudo dpkg -i ${ripgrep_latest_filename}
}

function install_marker() {
    # marker: https://github.com/pindexis/marker
    git clone --depth=1 https://github.com/pindexis/marker ~/.marker && ~/.marker/install.py
}

function install_cheat() {
    # cheat: https://github.com/cheat/cheat
    go get -u github.com/cheat/cheat/cmd/cheat
}

function install_bit() {
    # bit: https://github.com/chriswalz/bit
    curl -sf https://gobinaries.com/chriswalz/bit | sh;
    bit complete;
}

function install_exa() {
    # exa: https://github.com/ogham/exa 
    cargo install --git https://github.com/ogham/exa.git exa
}

function install_logo_ls() {
    # logo-ls: https://github.com/Yash-Handa/logo-ls
    full_url=$(curl -sL https://api.github.com/repos/Yash-Handa/logo-ls/releases/latest | jq -r '.assets[].browser_download_url' | grep amd64.deb)
    url_nopro=${full_url:7}
    logo_ls_latest_filename=${url_nopro##/*/}

    curl -sL https://api.github.com/repos/Yash-Handa/logo-ls/releases/latest | jq -r '.assets[].browser_download_url' | grep ${logo_ls_latest_filename} | wget -i -

    sudo dpkg -i ${logo_ls_latest_filename}
}

function install_loop() {
    # loop: https://github.com/Miserlou/loop 
    cargo install --git https://github.com/Miserlou/loop.git loop-rs
}

function install_yank() {
    # yank: https://github.com/mptre/yank
    sudo apt-get -y install yank
}

function install_nnn() {
    # nnn: https://github.com/jarun/nnn
    full_url=$(curl -sL https://api.github.com/repos/jarun/nnn/releases/latest | jq -r '.assets[].browser_download_url' | grep ${VER})
    url_nopro=${full_url:7}
    nnn_latest_filename=${url_nopro##/*/}

    curl -sL https://api.github.com/repos/jarun/nnn/releases/latest | jq -r '.assets[].browser_download_url' | grep ${nnn_latest_filename} | wget -i -

    sudo dpkg -i ${nnn_latest_filename}
}

function install_tokei() {
    # tokei: https://github.com/XAMPPRocky/tokei
    cargo install --git https://github.com/XAMPPRocky/tokei.git tokei
}

function install_bpytop() {
    # bpytop: https://github.com/aristocratos/bpytop
    pip3 install bpytop --upgrade --verbose
}

function install_tldr() {
    # tldr: https://github.com/tldr-pages/tldr
    pip3 install tldr.py --upgrade --verbose
}

function install_lazydocker() {
    # lazydocker: https://github.com/jesseduffield/lazydocker
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
}

install_utilities
############################################################################



############################################################################
# Install common utilities and fonts for developers
echo -e "\n\n${GREEN}${BOLD}6. Install several useful fonts for S/W development...${RESET}"

function install_dev_fonts() {
    mkdir -p ${HOME_PATH}/.local/share/fonts/dev_fonts
    if [ $? -ne 0 ]; then
        log "Failed to create dev_fonts directory"
	exit 5
    fi
    my_cd ${HOME_PATH}/.local/share/fonts/dev_fonts
    cp -ar ${WORKING_DIR}/common_configs/dev_fonts/* ${HOME_PATH}/.local/share/fonts/dev_fonts/
    fc-cache -fv
}

install_dev_fonts
############################################################################



############################################################################
# Common
function chsh_shell() {
    echo -e "\n\nUpdate your default shell..."
    if [ -z "$(grep $(command -v $1) /etc/shells)" ]; then
        command -v zsh | tee -a /etc/shells
    fi
    chsh -s $(command -v $1) ${SUDO_USER}
}
############################################################################



############################################################################
# Bash stuffs
function install_bash_stuffs() {
    chsh_shell $1
    install_bash_it
    install_bash_it_plugins
}

function install_bash_it() {
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    sh -c ${HOME_PATH}/.bash_it/install.sh
}

function install_bash_it_plugins() {
    :
}
############################################################################



############################################################################
# Zsh stuffs
function install_zsh_stuffs() {
    sudo apt-get -y install zsh

    # NOTE:
    # Don't use the following url, it needs interactive installation
    # oh_my_zsh_url="https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"

    # instead of the above link, use the next one
    oh_my_zsh_url="https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh"
    sh -c "$(curl -fsSL ${oh_my_zsh_url})" -s --batch

    chsh_shell $1
    install_powerlevel10k
    install_zsh_plugins
    launch_p10k_configure
}

function install_powerlevel10k() {
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${OMZ_PATH}/custom/themes/powerlevel10k
    if [ -z "$(grep powerline10k.zsh-theme ~/.zshrc)" ]; then
        echo "source ${OMZ_PATH}/custom/themes/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
    fi
}

function install_zsh_plugins() {
    # zplug
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}

function launch_p10k_configure() {
    my_cd ${HOME_PATH}
    zsh
}
############################################################################



############################################################################
# Install the shell you want to install (w/ CLI menu)
echo -e "\n\n${GREEN}${BOLD}7. Install shell...${RESET}"
PS3="Please enter your shell choice: "
options=("BASH" "ZSH" "Quit")
select opt in "${options[@]}"
do
    case $opt in
	"BASH")
	    YOUR_SHELL="bash"
	    # call install_bash_stuffs
	    install_bash_stuffs ${YOUR_SHELL}
	    break
	    ;;
	"ZSH")
	    YOUR_SHELL="zsh"
	    # call install_zsh_stuffs
	    install_zsh_stuffs ${YOUR_SHELL}
	    break
	    ;;
	"Quit")
	    break
	    ;;
	*) log "Invalid option ${REPLY}.";;
    esac
done
############################################################################


############################################################################
# Clean-up
echo -e "\n\n${GREEN}${BOLD}99. Clean up intermediary files and folders...${RESET}"
function cleanup() {
    my_cd ${HOME_PATH}
    rm -rf tmp-????????-??????????/
    
    if [ ${YOUR_SHELL} == "bash" ]; then
        :
    elif [ ${YOUR_SHELL} == "zsh" ]; then
        :
    else
        log "Something wrong with YOUR_SHELL variable."
        exit 99
    fi
}

echo -e "\n\n${GREEN}${BOLD} ! DONE !${RESET}\n"
############################################################################


#!/bin/bash

RED='\e[0;31m'
LIGHT_RED='\e[1;31m'
YELLOW='\e[1;33m'
GREEN='\e[0;32m'
LIGHT_GREEN='\e[1;32m'
CYAN='\e[0;36m'
LIGHT_CYAN='\e[1;36m'
BLUE='\e[0;34m'
LIGHT_BLUE='\e[1;34m'
PURPLE='\e[0;35m'
LIGHT_PURPLE='\e[1;35m'
BROWN='\e[0;33m'
BLACK='\e[0;30m'
DARK_GREY='\e[1;30m'
LIGHT_GREY='\e[0;37m'
WHITE='\e[1;37m'
CLEAR='\e[0m'
BLINK='\e[5m'
BOLD='\e[1m'

checkCount=0
checkTotal=100

check()
{
    code="$?"
    checkCount=$((checkCount+=1))
    if [ "$code" -ne 0 ]; then
        error "Aborting: previous command failed (code ${code})"
        exit 1
    fi
}

success()
{
    echo -e "${LIGHT_GREEN}=(${checkCount}/${checkTotal})=[ ${*}${CLEAR}"
}

log()
{
    echo -e "${LIGHT_BLUE}=(${checkCount}/${checkTotal})=[ ${*}${CLEAR}"
}

warn()
{
    echo -e "${YELLOW}=(${checkCount}/${checkTotal})=[ ${*}${CLEAR}"
}

error()
{
    echo -e "${RED}${BLINK}=(${checkCount}/${checkTotal})=[ ${*}${CLEAR}"
}

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

log "Installing Dein plugin manager ..."
if [ ! -z "$(command -v curl)" ]; then
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh; check
elif [ ! -z "$(command -v wget)" ]; then
    wget https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh -O /tmp/installer.sh; check
else
    error "Neither wget nor curl are installed -- can not complete installation"
    exit 1
fi

if [ -s /tmp/installer.sh ]; then
    sh /tmp/installer.sh "$HOME/.dein"; check
    rm /tmp/installer.sh; check
else
    error "Download for Dein failed"
    exit 1
fi

cd "$HOME" || exit
if [ -s "$HOME/.vimrc" ]; then
    log "Backing up old .vimrc to $HOME/.vimrc.bak ..."
    mv "$HOME/.vimrc" "$HOME/.vimrc.bak"; check
fi

log "Linking new .vimrc ..."
ln -s "$SCRIPT_DIR/vim-studio-lite.vim" "$HOME/.vimrc"; check

log "Installing plugins ..."
vim +qa; check

success "Installation complete for Vim Studio Lite"
success "Execute \`vim\` to begin an epic experience"

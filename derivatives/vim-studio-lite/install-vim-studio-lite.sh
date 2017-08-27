#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install Dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
sh /tmp/installer.sh "$HOME/.dein"
rm /tmp/installer.sh

# Make a backup of the vimrc
cd "$HOME" || exit
if [ -s "$HOME/.vimrc" ]; then
    mv "$HOME/.vimrc" "$HOME/.vimrc.bak"
fi

# Link the new vimrc
ln -s "$SCRIPT_DIR/vim-studio-lite.vim" "$HOME/.vimrc"

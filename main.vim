if &compatible
    set nocompatible
endif

if empty($NEOVIM_STUDIO_DIR)
    let $NEOVIM_STUDIO_DIR='home/max/.neovim-studio'
endif

set runtimepath+=$NEOVIM_STUDIO_DIR/dein/repos/github.com/Shougo/dein.vim

if dein#load_state($NEOVIM_STUDIO_DIR . '/dein/')
    call dein#begin($NEOVIM_STUDIO_DIR . '/dein/')
    call dein#add($NEOVIM_STUDIO_DIR . '/dein/')

    call dein#add('deoplete.nvim')

    source $NEOVIM_STUDIO_DIR/includes/plugins.vim
    source $NEOVIM_STUDIO_DIR/includes/custom_plugins.vim

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

source $NEOVIM_STUDIO_DIR/includes/general.vim
source $NEOVIM_STUDIO_DIR/includes/plugin_paths.vim
source $NEOVIM_STUDIO_DIR/includes/plugin_settings.vim
source $NEOVIM_STUDIO_DIR/includes/themes.vim
source $NEOVIM_STUDIO_DIR/includes/autocommands.vim
source $NEOVIM_STUDIO_DIR/includes/custom_settings.vim

"" Automatically install new plugins.
if dein#check_install()
    call dein#install()
endif

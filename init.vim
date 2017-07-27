"""""""""""""""""""
" NEOVIM SETTINGS "
"""""""""""""""""""
set nocompatible
set encoding=utf-8
syntax on
filetype on
filetype plugin on
filetype indent on

"" Format
set autoindent smartindent softtabstop=4 tabstop=4 shiftwidth=4
""" Use Tabs
set noexpandtab
" set list lcs=tab:\┊\ 
" let g:indentLine_char = '┊'
""" Use Spaces
" set expandtab

"" Features
set number
set whichwrap+=<,>,h,l,[,]
set colorcolumn=125
set cursorline " Slow
set relativenumber " Slow

"" Graphical
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
set termguicolors
set lazyredraw
" set ttyfast " Enabled by default in Neovim
" set synmaxcol=125
" syntax sync minlines=255

"" Additional Filetypes
autocmd BufRead,BufNewFile *.aatstest set filetype=json

"" Enable python
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

"" Use system clipboard
set clipboard+=unnamedplus

""""""""""""""""
" LOAD PLUGINS "
""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

"" Modules
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
" Plug 'mhinz/vim-signify' " SLOW, BUGGY
Plug 'scrooloose/nerdcommenter'
Plug 'sbdchd/neoformat'
Plug 'bling/vim-bufferline'
Plug 'farmergreg/vim-lastplace'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sirver/ultisnips' " REQUIRES SOME FURTHER CONFIGURATION & SNIPPETS
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mhinz/vim-startify'
Plug 'chiel92/vim-autoformat'
Plug 'tpope/vim-surround'
Plug 'luochen1990/rainbow'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'shougo/echodoc.vim'
" Plug 'yggdroot/indentline'
" Plug 'nathanaelkane/vim-indent-guides' 
" Plug 'scrooloose/syntastic'
" Plug 'valloric/youcompleteme'
" Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}

"" Syntax / File Support
Plug 'sheerun/vim-polyglot'
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
" Plug 'elzr/vim-json'
" Plug 'pangloss/vim-javascript'

"" Autocompletion
Plug 'zchee/deoplete-clang'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'wokalski/autocomplete-flow'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'shougo/neoinclude.vim'
Plug 'zchee/deoplete-jedi'
Plug 'shougo/neco-vim'
Plug 'artur-shaik/vim-javacomplete2'
" Plug 'landaire/deoplete-d'
Plug 'othree/csscomplete.vim'
Plug 'othree/html5.vim'
Plug 'othree/xml.vim'
Plug 'c9s/perlomni.vim'
" Plug 'tweekmonster/deoplete-clang2'

"" Themes
Plug 'lifepillar/vim-solarized8'
Plug 'mhartington/oceanic-next'
Plug 'dikiaap/minimalist'
Plug 'flazz/vim-colorschemes'
Plug 'felixhummel/setcolors.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'ryanoasis/vim-devicons'

"" Under Investigation
" Plug 'metakirby5/codi' " INVESTIGATE REPL DEPENDENCIES
" Plug 'Shougo/denite.nvim'
" Plug 'bagrat/vim-workspace'
" Plug 'vim-scripts/dbext.vim'
    " OR Plug 'nathanaelkane/vim-indent-guides'
" Plug 'raimondi/delimitmate'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'sjl/gundo.vim'
" Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-sensible'
" Plug 'janko-m/vim-test'
    " WITH Plug 'tpope/dispatch'
" Plug 'editorconfig/editorconfig-vim'
" Plug 'thinca/vim-quickrun'
" Plug 'bronson/vim-trailing-whitespace'
" Plug 'plugin/vim-paste-easy'
" Plug 'godlygeek/csapprox'
" Plug 'gregsexton/matchtag'
" Plug 'mattn/emmet-vim'
" Plug 'yuttie/comfortable-motion.vim' " Debatable, could slow down productivity
" Debuggers, diagnostics, R language, syntaxes, autocompletes, formatters
" Consider switching to Dein
" Test over an SSH Connection

call plug#end()

""""""""""
" THEMES "
""""""""""
"" Font
set guifont=DejaVuSansMono\ Nerd\ Font\ 9

"" Colorscheme
colorscheme solarized8_dark
" colorscheme OceanicNext
" colorscheme minimalist
" hi Normal guibg=NONE ctermbg=NONE
" hi NonText guibg= NONE ctermbg=NONE

"" Airline
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme='oceanicnext'
" let g:airline_theme='powerlineish'
" let g:airline_theme='minimalist'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

"" Bufferline
let g:airline#extensions#bufferline#enabled = 1
let g:bufferline_echo = 0 " This will keep your messages from getting quickly hidden.

"" Tmuxline
let g:airline#extensions#tmuxline#enabled = 0 " Airline breaks tmuxline for some reason.
let g:tmuxline_theme = 'vim_statusline_3'
let g:tmuxline_preset = 'tmux'

""""""""""""
" NERDTREE "
""""""""""""
" This setting causes issues because new windows do not open as expected in afterward.
" let g:nerdtree_tabs_open_on_console_startup = 1

""""""""""""
" DEOPLETE "
""""""""""""
let g:deoplete#enable_at_startup = 1

"" Deoplete per-autocompleter settings
""" Clang
let g:deoplete#sources#clang#libclang_path = '/lib/libclang.so' " '/usr/lib/i386-linux-gnu/libclang-4.0.so.1'
let g:deoplete#sources#clang#clang_header = '/lib/clang/4.0.0/include' " '/usr/lib/llvm-4.0/lib/clang/4.0.0/include'

""" TernJS
let g:tern_request_timeout = 1
" let g:tern_show_signature_in_pum = '0'

""" Rust
let g:deoplete#sources#rust#racer_binary='/home/bats/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/bats/src/rust/src'

""" Java
" autocmd FileType java setlocal omnifunc=javacomplete#Complete

""" Omnifunctions
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.java = 'javacomplete#Complete'
let g:deoplete#omni#functions.javascript = [
	\ 'tern#Complete',
	\ 'autocomplete_flow#Complete',
	\ 'javascriptcomplete#CompleteJS'
\]
let g:deoplete#omni#functions.css = 'csscomplete#CompleteCSS'
let g:deoplete#omni#functions.html = [
	\ 'htmlcomplete#CompleteTags',
	\ 'xmlcomplete#CompleteTags'
\]
let g:deoplete#omni#functions.xml = 'xmlcomplete#CompleteTags'
let g:deoplete#omni#functions.perl = 'perlomni#PerlComplete'

set completeopt=menuone " Preview mode causes flickering

"" Increase command height for echodoc
set cmdheight=2

"""""""
" ALE "
"""""""
" Add an error indicator to Ale
let g:ale_sign_column_always = 1

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

set statusline=%{LinterStatus()}

"""""""""""
" SIGNIFY "
""""""""""
" accurev
let g:signify_vcs_list = [ 'git', 'perforce', 'hg', 'svn','bzr', 'cvs', 'darcs', 'fossil', 'hg', 'rcs', 'svn', 'tfs' ]
let g:signify_realtime = 1
" let g:signify_cursorhold_insert = 1
" let g:signify_cursorhold_normal = 1
" let g:signify_update_on_bufenter = 0
" let g:signify_update_on_focusgained = 1

"""""""""""""
" GITGUTTER "
"""""""""""""
" Set GitGutter's update time to 250ms
set updatetime=250

"""""""""""""
" ULTISNIPS "
"""""""""""""
let g:UltiSnipsSnippetsDir = '~/.config/nvim/my-snippets'
" let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsListSnippets = "<c-tab>"
" let g:UltiSnipsJumpForwardTrigger = "<c-j>"
" let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

"""""""""""""""""""""""""""""""""""""
" SUPERTAB (AND COMPLETION HOTKEYS) "
"""""""""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
let g:UltiSnipsExpandTrigger = "<C-j>"
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

"""""""""""""""""""""""""
" SYNTAX / FILE SUPPORT "
"""""""""""""""""""""""""
" Enable JSDoc syntax highlighting
let g:javascript_plugin_jsdoc = 1

" Ale alias for .aatstest
" let g:ale_linters = {'aatstest': ['jsonlint']}
" call ale#linter#Define('aatstest', g:aatstest)
" let ale_linter_aliases = {'json': ['json', 'aatstest']}

"""""""""""""""""""""""""""
" STARTUP / MISCELLANEOUS "
"""""""""""""""""""""""""""
" Enable NERDTree and Tagbar, recenter the cursor as well
autocmd vimenter * NERDTree
autocmd vimenter * wincmd p
autocmd vimenter * Tagbar

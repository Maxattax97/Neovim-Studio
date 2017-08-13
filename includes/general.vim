" General ----------{{{
set nocompatible

" Make controls more comfortable for line wrapping.
set backspace=eol,start,indent
set whichwrap+=<,>,h,l,[,]

" Detect line endings, but prefer Unix endings.
set fileformats=unix,dos,mac

" Allow switching to other buffers without requiring a save.
set hidden

" Attempt to fix colors and improve performance cheaply.
set termguicolors
set lazyredraw

" Faster cursorhold events and swapfile writing.
set updatetime=250

" Enable some mouse control.
set mouse=a
" }}}



" File Format ----------{{{
set encoding=utf-8
filetype plugin indent on
syntax on

" Default formatting when not detected.
set autoindent
set smartindent
set smarttab
set shiftround
set softtabstop=4
set tabstop=4
set shiftwidth=4

" Default to TABS when not detected.
"set noexpandtab

" Default to SPACES when not detected
set expandtab
" }}}



" Aesthetics ----------{{{
" Show line numbers.
" NOTE: Controlled by a plugin. Disable relativenumber to improve performance.
set number
"set relativenumber

" Both the standard and Github's line length.
set colorcolumn=80,125

" Highlight the cursor's line.
" NOTE: Disable for performance improvement.
set cursorline

" Blink matching enclosures.
set showmatch
set matchtime=2

" Keep lines above or below the cursor at all times
set scrolloff=7

" Increase command bar height (for Echodoc).
set cmdheight=2
" }}}



" Tools ----------{{{
" In autocmpletion, show the option that has the most matches, and display
" even if there is only a single option.
set completeopt=longest,menuone

" Wildmode
set wildmenu
set wildmode=list:longest,full

" RegEx search settings.
set ignorecase
set smartcase
set hlsearch
set incsearch

" Use the system clipboard.
set clipboard+=unnamedplus
" }}}

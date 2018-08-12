if &compatible
    set nocompatible
endif

if empty($NEOVIM_STUDIO_DIR)
    let $NEOVIM_STUDIO_DIR=$HOME . '/.dein'
endif

set runtimepath+=$NEOVIM_STUDIO_DIR/repos/github.com/Shougo/dein.vim

if dein#load_state($NEOVIM_STUDIO_DIR . '/')
    call dein#begin($NEOVIM_STUDIO_DIR . '/')
    call dein#add($NEOVIM_STUDIO_DIR . '/repos/github.com/Shougo/dein.vim')


    " DISABLED: An autocompletion engine.
    "call dein#add('shougo/deoplete.nvim')

    " Asynchronous Lint Engine.
    call dein#add('w0rp/ale')

    " Access project files in side-bar.
    call dein#add('scrooloose/nerdtree')
    call dein#add('xuyuanp/nerdtree-git-plugin')
    call dein#add('jistr/vim-nerdtree-tabs')

    " DISABLED: Access function tags in side-bar.
    "call dein#add('majutsushi/tagbar')

    " Integrated Git commands and change indicator.
    call dein#add('tpope/vim-fugitive')
    call dein#add('airblade/vim-gitgutter')

    " Combine all autocompletion into a single keymap.
    call dein#add('ervandew/supertab')

    " Efficient commenting.
    call dein#add('scrooloose/nerdcommenter')

    " Efficient text-alignment.
    call dein#add('godlygeek/tabular')

    call dein#add('lifepillar/vim-colortemplate')

    " DISABLED: Asynchronous fuzzy finder.
    "call dein#add('shougo/denite.nvim')
    " }}}



    " Autocompletion ----------{{{
    " Include/import files from headers for autocompletion, etc.
    call dein#add('shougo/neoinclude.vim')

    " DISABLED: C languages
    "call dein#add('zchee/deoplete-clang')

    " DISABLED: Javascript
    "call dein#add('carlitux/deoplete-ternjs')
    ", { 'do': 'npm install -g tern' }
    call dein#add('wokalski/autocomplete-flow')

    " Rust
    "call dein#add('sebastianmarkow/deoplete-rust')

    " Python
    "call dein#add('zchee/deoplete-jedi')

    " DISABLED: D language
    "call dein#add('landaire/deoplete-d')

    " Perl
    call dein#add('c9s/perlomni.vim')

    " Vimscript
    call dein#add('shougo/neco-vim')

    " Web languages (HTML, CSS, XML, XHTML, ...)
    call dein#add('othree/csscomplete.vim')
    call dein#add('othree/html5.vim')
    call dein#add('othree/xml.vim')
    " }}}

    " Syntax / File Support ----------{{{
    " Syntax support for a huge number of languages.
    call dein#add('sheerun/vim-polyglot')
    call dein#add('justinmk/vim-syntax-extra')

    " Improved Perl support.
    call dein#add('vim-perl/vim-perl')
    ", { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
    " }}}



    " Aesthetics ----------{{{
    " Informational and sexy statusline.
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    " Displays buffers on the top of the screen.
    call dein#add('bling/vim-bufferline')

    " Opens a start page with project file recommendations.
    call dein#add('mhinz/vim-startify')

    " Colorschemes / Themes
    call dein#add('lifepillar/vim-solarized8')
    call dein#add('mhartington/oceanic-next')
    call dein#add('dikiaap/minimalist')
    call dein#add('flazz/vim-colorschemes')

    " Icons for filetypes, Git, and more.
    call dein#add('ryanoasis/vim-devicons')

    " Guides for code indenting.
    call dein#add('nathanaelkane/vim-indent-guides')
    " }}}



    " Miscellaneous ----------{{{
    " Open the to the last cursor position you were at in a file.
    call dein#add('farmergreg/vim-lastplace')

    " A collection of default, useful snippets.
    call dein#add('honza/vim-snippets')

    " Previews CSS colors.
    call dein#add('ap/vim-css-color')

    " Efficiently surround text.
    call dein#add('tpope/vim-surround')

    " Automatically swap between absolute and relative line numbering.
    call dein#add('jeffkreeftmeijer/vim-numbertoggle')

    " Automatically detect indent type and width.
    call dein#add('tpope/vim-sleuth')

    " Automatically add the { to your }.
    call dein#add('jiangmiao/auto-pairs')

    " Efficiently move between buffers, among other things.
    call dein#add('tpope/vim-unimpaired')
    " }}}

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

" Make controls more comfortable for line wrapping.
set backspace=eol,start,indent
set whichwrap+=<,>,h,l,[,]

" Detect line endings, but prefer Unix endings.
set fileformats=unix,dos,mac

" Allow switching to other buffers without requiring a save.
set hidden

" Attempt to fix colors and improve performance cheaply.
" DISABLED: set termguicolors
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

" Deoplete ----------{{{
let g:deoplete#enable_at_startup = 1

" TernJS
let g:tern_request_timeout = 1

" Eclim
let g:EclimCompletionMethod = 'omnifunc'

" D Lang
let g:deoplete#sources#d#dcd_server_autostart = 1

" Omnifunctions
let g:deoplete#omni#functions = {}

let g:EclimCompletionMethod = 'omnifunc'
let g:deoplete#omni#functions.java = 'eclim#java#complete#CodeComplete'

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
" }}}



" ALE ----------{{{
" Add an error indicator to ALE.
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
" }}}



" Signify ----------{{{
let g:signify_vcs_list = [ 'git', 'perforce', 'hg', 'svn', 'bzr', 'cvs', 'darcs', 'fossil', 'hg', 'rcs', 'svn', 'tfs' ]
" 'accurev' is broken?

let g:signify_realtime = 1
"let g:signify_cursorhold_insert = 1
"let g:signify_cursorhold_normal = 1
"let g:signify_update_on_bufenter = 0
"let g:signify_update_on_focusgained = 1
" }}}



" UltiSnips ----------{{{
"let g:UltiSnipsSnippetsDir = '~/.config/nvim/my-snippets'
"let g:UltiSnipsExpandTrigger = '<tab>'
"let g:UltiSnipsListSnippets = '<c-tab>'
"let g:UltiSnipsJumpForwardTrigger = '<c-j>'
"let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
" }}}



" SuperTab ----------{{{
let g:SuperTabDefaultCompletionType = '<C-n>'
"let g:UltiSnipsExpandTrigger = '<C-j>'
"inoremap <expr><Tab> pumvisible() ? '\<C-n>' : '\<Tab>'
" }}}



" Syntax / File Support ----------{{{
" Enable JSDoc syntax highlighting
let g:javascript_plugin_jsdoc = 1
" }}}

" Try to set the default font.
set guifont=DejaVuSansMono\ Nerd\ Font\ 9

" Set the colorscheme to a widely preferred, beautiful _Solarized_.
colorscheme Tomorrow-Night-Bright

hi Normal guibg=NONE ctermbg=NONE

" This will repair colors in Tmux/Screen sessions.
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"set t_8b=[48;2;%lu;%lu;%lum
"set t_8f=[38;2;%lu;%lu;%lum

" Alternative, popular colorschemes
" TODO: Test and add whatever additional configuration is necessary for these.
"colorscheme OceanicNext
"let g:airline_theme='oceanicnext'

"colorscheme one_dark

"colorscheme tomorrow-night

"colorscheme molokai

"colorscheme base16

"colorscheme jellybeans

"colorscheme gruvbox

" Airline
let g:airline_theme='tomorrow'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Bufferline
let g:airline#extensions#bufferline#enabled = 1
let g:bufferline_echo = 0 " This will keep your messages from getting quickly hidden.

" Tmuxline
"let g:airline#extensions#tmuxline#enabled = 0
"let g:tmuxline_theme = 'vim_statusline_3'
"let g:tmuxline_preset = 'tmux'

" Indent Lines
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" Display ALE errors in the statusline.
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

" Map Tab and Enter to autocompletion.
"inoremap <expr> <Tab> pumvisible() ? '\<C-n>' : '\<Tab>'
"inoremap <expr> <CR>  pumvisible() ? '\<C-y>' : '\<CR>'

" Map Denite fuzzy search to act like CtrlP.
noremap <C-p> :Denite buffer file_rec tag<CR>

" Strip trailing whitespace for most of filetypes.
function! StripTrailingWhitespace()
    " Filetype blacklist
    if &filetype =~ 'markdown\|whitespace'
        return
    endif
    %s/\s\+$//e
endfun

" Automatically strip trailing whitespace before saving.
augroup neovim_studio_strip_whitespace
    autocmd!
    autocmd BufWritePre * call StripTrailingWhitespace()
augroup END

" Enable NERDTree and Tagbar, and recenter the cursor on startup.
augroup neovim_studio_startup
    autocmd!
    autocmd vimenter * NERDTree
    autocmd vimenter * wincmd p
    " DISABLED: autocmd vimenter * Tagbar
augroup END

"" Automatically install new plugins.
if dein#check_install()
    call dein#install()
endif

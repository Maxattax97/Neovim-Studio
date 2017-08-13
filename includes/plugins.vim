" Modules ----------{{{
" An autocompletion engine.
call dein#add('Shougo/deoplete')

" Asynchronous Lint Engine.
call dein#add('w0rp/ale')

" Access project files in side-bar.
call dein#add('scroolose/nerdtree')
call dein#add('xuyuanp/nerdtree-git-plugin')
call dein#add('jistr/vim-nerdtree-tabs')

" Access function tags in side-bar.
call dein#add('majutsushi/tagbar')

" Integrated Git commands and change indicator.
call dein#add('tpope/vim-fugitive')
call dein#add('airblade/vim-gitgutter')

" Combine all autocompletion into a single keymap.
call dein#add('ervandew/supertab')

" Efficient commenting.
call dein#add('scroolose/nerdcommenter')

" Efficient text-alignment.
call dein#add('godlygeek/tabular')

" Asynchronous fuzzy finder.
call dein#add('shougo/denite.nvim')
" }}}



" Autocompletion ----------{{{
" Include/import files from headers for autocompletion, etc.
call dein#add('shougo/neoinclude.vim')

" C languages
call dein#add('zchee/deoplete-clang')

" Javascript
call dein#add('carlitux/deoplete-ternjs')
", { 'do': 'npm install -g tern' }
call dein#add('wokalski/autocomplete-flow')

" Rust
call dein#add('sebastianmarkow/deoplete-rust')

" Python
call dein#add('zchee/deoplete-jedi')

" D language
call dein#add('landaire/deoplete-d')

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


" In Development ----------{{{
" Code formatter engine.
" TODO: Needs formatters.
call dein#add('sbdchd/neoformat')
call dein#add('chiel92/vim-autoformat')

" Snippet engine.
" TODO: Requires further configuration and snippets.
call dein#add('sirver/ultisnips')

" Color enclosing characters for easy reading.
" TODO: ... does this even work?
call dein#add('luochen1990/rainbow')

" Display function arguments in command bar.
" TODO: Not displaying?
call dein#add('shougo/echodoc.vim')

" Vim-Eclim
" }}}

" Disabled ---------{{{
"call dein#add('edkolev/tmuxline.vim')

" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'mhinz/vim-signify'
" Plug 'elzr/vim-json'
" Plug 'pangloss/vim-javascript'
" Plug 'artur-shaik/vim-javacomplete2'
" Plug 'tweekmonster/deoplete-clang2'

" Needs Investigation
" Plug 'idanarye/vim-dutyl' " Requires DMD and DCD
" Plug 'metakirby5/codi' " INVESTIGATE REPL DEPENDENCIES
" Plug 'bagrat/vim-workspace'
" Plug 'vim-scripts/dbext.vim'
    " OR Plug 'nathanaelkane/vim-indent-guides'
" Plug 'raimondi/delimitmate'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'sjl/gundo.vim'
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

" NOTES:
" Debuggers, diagnostics, R language, syntaxes, autocompletes, formatters
" Test over an SSH Connection

" }}}

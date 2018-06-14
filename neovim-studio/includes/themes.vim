" Try to set the default font.
set guifont=DejaVuSansMono\ Nerd\ Font\ 9

" Set the colorscheme to a widely preferred, beautiful _Solarized_.
colorscheme solarized8_dark

" This will repair colors in Tmux/Screen sessions.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
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
let g:airline_theme='solarized'
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

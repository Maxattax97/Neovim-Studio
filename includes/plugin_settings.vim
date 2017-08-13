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
let g:SuperTabDefaultCompletionType = '<C-x><C-o>'
let g:UltiSnipsExpandTrigger = '<C-j>'
inoremap <expr><Tab> pumvisible() ? '\<C-n>' : '\<Tab>'
" }}}



" Syntax / File Support ----------{{{
" Enable JSDoc syntax highlighting
let g:javascript_plugin_jsdoc = 1
" }}}

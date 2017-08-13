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
inoremap <expr> <Tab> pumvisible() ? '\<C-n>' : '\<Tab>'
inoremap <expr> <CR>  pumvisible() ? '\<C-y>' : '\<CR>'

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
    autocmd vimenter * Tagbar
augroup END

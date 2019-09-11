" gq wrapper that tries its best at keeping the cursor in place
function! Format(type, ...)
  normal! '[v']gq
    call winrestview(b:gqview)
    unlet b:gqview
endfunction
nmap <silent> GQ :let b:gqview = winsaveview()<CR>:set opfunc=Format<CR>g@

" maximize, minimize window
command! Maximize :exe "normal! <C-w>\|<C-W>_"
command! Minimize :exe "normal! <C-W>="
function! ToggleMaximizeWindow()
    if !exists('b:window_maximized')
        let b:window_maximized = 0
    endif
    if b:window_maximized
        Minimize
        let b:window_maximized = 0
    else
        Maximize
        let b:window_maximized = 1
    endif
endfunction
nnoremap <leader>wm :call ToggleMaximizeWindow()<CR>


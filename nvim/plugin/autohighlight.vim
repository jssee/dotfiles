" Automatically toggle `hlsearch`
" credit goes to @purpleP for this genius solution
" ================================================
if exists('g:loaded_autohighlight')
    finish
endif
let g:loaded_autohighlight = 1

let s:disable = 0

augroup AutoHighlight
    autocmd!
    autocmd OptionSet hlsearch call <SID>AutoHighlight(v:option_old, v:option_new)
augroup END

function! s:HlSearch()
    if s:disable
        let s:disable = 0
        return
    endif
    silent! if !search('\%#\zs'.@/,'cnW')
        call <SID>StopHL()
    endif
endfunction

function! s:StopHL()
    if v:hlsearch && mode() is 'n'
        sil call feedkeys("\<Plug>(StopHL)", 'm')
    endif
endfunction

function! s:TurnOffOrKeepHL()
    if matchstr(@", @/) == @"
        let s:disable = 1
    elseif search('\%#\zs'.@/,'cnW')
        call <SID>StopHL()
    endif
endfunction

function! s:AutoHighlight(old, new)
    if a:old == 0 && a:new == 1
        noremap <expr> <Plug>(StopHL) execute('nohlsearch')[-1]
        noremap! <expr> <Plug>(StopHL) execute('nohlsearch')[-1]
        autocmd AutoHighlight CursorMoved * call <SID>HlSearch()
        autocmd AutoHighlight TextYankPost * call <SID>TurnOffOrKeepHL()
    elseif a:old == 1 && a:new == 0
        nunmap <Plug>(StopHL)
        unmap! <expr> <Plug>(StopHL)
        autocmd! AutoHighlight CursorMoved
        autocmd! AutoHighlight TextYankPost
    else
        return
    endif
endfunction

if v:hlsearch
    call <SID>AutoHighlight(0, 1)
endif

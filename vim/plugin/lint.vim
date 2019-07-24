"
" TITLE:   VIM-MAKEJOB
" AUTHOR:  Daniel Moch <daniel AT danielmoch DOT com>
" LICENSE: MIT
" VERSION: 1.3.1
"
if exists('g:loaded_makejob') || &cp
    finish
endif
if !has('job') || !has('channel') || !has('quickfix')
    finish
endif
let g:loaded_makejob = 1
let s:save_cpo = &cpo
set cpo&vim
let s:jobinfo = {}

if !exists('g:makejob_hide_preview_window')
    let g:makejob_hide_preview_window = 0
endif

function! s:InitAutocmd(lmake, grep, cmd)
    let l:returnval = 'doautocmd QuickFixCmd'.a:cmd.' '
    if a:grep
        let l:returnval .= a:lmake ? 'lgrep' : 'grep'
    else
        let l:returnval .= a:lmake ? 'lmake' : 'make'
    end
    return l:returnval
endfunction

function! s:JobStop(...) abort
    if a:0
       if bufexists(a:1)
           call win_gotoid(win_findbuf(bufnr(a:1))[0])
           if exists('b:makejob')
               if !job_stop(b:makejob)
                   echoerr 'Failed to stop current MakeJob'
               end
           else
               echoerr 'Provided buffer is not a MakeJob'
           end
           wincmd p
       else
           echoerr 'Provided MakeJob does not exist'
       endif
    elseif exists('b:makejob')
       let l:job = s:jobinfo[split(job_getchannel(b:makejob))[1]]
       if !job_stop(b:makejob)
           echoerr 'Failed to stop '.l:job['prog']
       endif
    else
        echoerr 'Not in a MakeJob buffer, and none specified'
    endif
endfunction

function! s:JobHandler(channel) abort
    let l:job = remove(s:jobinfo, split(a:channel)[1])
    let l:lcwd = getcwd()
    let l:cwd = getcwd(-1)

    if l:cwd != l:lcwd
        execute 'lcd'.l:job['cwd']
    endif
    execute 'cd '.l:job['cwd']

    let l:curwinid = win_getid()
    let l:srcbuf = win_findbuf(l:job['srcbufnr'])
    let l:outbuf = win_findbuf(l:job['outbufnr'])
    let l:lmake = 0

    " For reasons I don't understand, copying and re-writing
    " errorformat fixes a lot of parsing errors
    let l:tempefm = l:job['grep'] ? &grepformat : &errorformat
    if l:job['grep']
        let &grepformat = l:tempefm
    else
        let &errorformat = l:tempefm
    endif

    if !empty(l:srcbuf)
        call win_gotoid(l:srcbuf[0])
        unlet b:makejob
        nunmap <buffer> <C-c>
        let l:lmake = l:job['lmake'] ? 1 : 0
    endif
    let l:exitval = job_info(l:job['job']).exitval

    if l:lmake
        let l:qfcmd = l:job['grepadd'] ? 'laddbuffer' : 'lgetbuffer'
    else
        let l:qfcmd = l:job['grepadd'] ? 'caddbuffer' : 'cgetbuffer'
    endif

    silent execute l:qfcmd.' '.l:job['outbufnr']
    if !empty(l:outbuf) && l:job['outbufhidden'] == 0
        call win_gotoid(l:outbuf[0])
        silent execute 'close'
    endif
    if l:lmake
        call win_gotoid(l:curwinid)
        call setloclist(0, [], 'a', {'title':l:job['prog']})
    else
        call setqflist([], 'a', {'title':l:job['prog']})
    endif
    silent execute l:job['outbufnr'].'bwipe!'
    call win_gotoid(l:curwinid)

    let l:initqf = l:lmake ? getloclist(bufwinnr(l:srcbuf[0])) :
                \ getqflist()
    let l:makeoutput = 0
    let l:idx = 0
    while l:idx < len(l:initqf)
        let l:qfentry = l:initqf[l:idx]
        if l:qfentry['valid']
            let l:makeoutput += 1
        endif
        let l:idx += 1
    endwhile

    execute 'cd '.l:cwd
    if l:cwd != l:lcwd
        execute 'lcd'.l:lcwd
    endif

    silent execute s:InitAutocmd(l:job['lmake'], l:job['grep'], 'Post')

    if l:lmake
        if l:job['cfirst'] && !empty(l:srcbuf)
            silent! lfirst
        end
    else
        if l:job['cfirst'] && !empty(l:srcbuf)
            silent! cfirst
        end
    endif

    echomsg l:job['prog']." returned ".l:exitval." with ".l:makeoutput." findings"
endfunction

function! s:CreateMakeJobBuffer(prog, lmake)
    let l:winct = winnr('$')
    let l:curwinnr = winnr()
    if !a:lmake
        execute l:winct.'wincmd w'
    endif
    silent execute 'belowright 10split '.a:prog
    setlocal bufhidden=hide buftype=nofile buflisted nolist
    setlocal noswapfile nowrap nomodifiable
    nmap <buffer> <C-c> :MakeJobStop<CR>
    let l:bufnum = winbufnr(0)
    if g:makejob_hide_preview_window
        hide
    else
        execute l:curwinnr.'wincmd w'
    endif
    return l:bufnum
endfunction

function! s:Expand(input)
    let l:split_input = split(a:input)
    let l:expanded_input = []
    for l:token in l:split_input
        if l:token =~ '^\\\?%\|^\\\?#\|^\\\?\$' && l:token != '$*' &&
                    \ expand(l:token) != ''
            let l:expanded_input += [expand(l:token)]
        else
            let l:expanded_input += [l:token]
        endif
    endfor
    return join(l:expanded_input)
endfunction

function! s:MakeJob(grep, lmake, grepadd, bang, ...) abort
    let l:make = a:grep ? s:Expand(&grepprg) : s:Expand(&makeprg)
    let l:prog = split(l:make)[0]
    let l:internal_grep = l:make ==# 'internal' ? 1 : 0
    let l:cwd = getcwd()
    execute 'let l:openbufnr = bufnr("^'.l:prog.'$")'
    if l:openbufnr != -1
        echohl WarningMsg
        echomsg l:prog.' already running'
        echohl None
        return
    endif
    "  Need to check for whitespace inputs as well as no input
    if a:0 && (a:1 != '')
        let l:arg = substitute(a:1, '^\s\+\|\s\+$', '', 'g')

        " Fix wonky Ex shell escape in Windows to work like :make
        if l:arg =~ '^\\"' && (has('win32') || has('win64'))
            let l:arg = substitute(l:arg, '\\"', '"', 'g')
            let l:arg = substitute(l:arg, '\\ ', ' ', 'g')
        endif

        if l:internal_grep
            let l:make = 'vimgrep '.l:arg
        elseif l:make =~ '\$\*'
            let l:make = substitute(l:make, '\$\*', l:arg, 'g')
        else
            let l:make = l:make.' '.l:arg
        endif

        if !has('win32') && !has('win64')
            let l:make = [&shell, &shellcmdflag, l:make]
        endif
    endif

    silent execute s:InitAutocmd(a:lmake, a:grep, 'Pre')

    if &autowrite && !empty(bufname('%')) && !a:grep
        silent update
    endif

    if l:internal_grep
        execute l:make
        return
    else
        let l:outbufnr = s:CreateMakeJobBuffer(l:prog, a:lmake)

        let l:opts = { 'close_cb' : function('s:JobHandler'),
                    \  'out_io': 'buffer',
                    \  'out_buf': l:outbufnr,
                    \  'out_modifiable': 0,
                    \  'err_io': 'buffer',
                    \  'err_buf': l:outbufnr,
                    \  'err_modifiable': 0,
                    \  'in_io': 'null'}

        let l:makejob = job_start(l:make, l:opts)
        let b:makejob = l:makejob
        let s:jobinfo[split(job_getchannel(b:makejob))[1]] =
                    \ { 'prog': l:prog,'lmake': a:lmake,
                    \   'outbufnr': l:outbufnr,
                    \   'srcbufnr': winbufnr(0),
                    \   'cfirst': !a:bang, 'grep': a:grep,
                    \   'grepadd': a:grepadd, 'job': b:makejob,
                    \   'outbufhidden': g:makejob_hide_preview_window,
                    \   'cwd': l:cwd }
        echomsg s:jobinfo[split(job_getchannel(b:makejob))[1]]['prog']
                    \ .' started'

        execute bufwinnr(l:outbufnr).'wincmd w'
        let b:makejob = l:makejob
        wincmd p
        nmap <buffer> <C-c> :MakeJobStop<CR>
    end
endfunction

function! s:MakeJobCompletion(arglead, cmdline, cursorpos)
    let l:return = []
    for l:key in keys(s:jobinfo)
        let l:return += [s:jobinfo[l:key]['prog']]
    endfor
    return l:return
endfunction

command! -bang -bar -nargs=* -complete=file MakeJob
            \ call <sid>MakeJob(0,0,0,<bang>0,<q-args>)
command! -bang -bar -nargs=* -complete=file LmakeJob
            \ call <sid>MakeJob(0,1,0,<bang>0,<q-args>)
command! -bang -bar -nargs=+ -complete=file GrepJob
            \ call <sid>MakeJob(1,0,0,<bang>0,<q-args>)
command! -bang -bar -nargs=+ -complete=file LgrepJob
            \ call <sid>MakeJob(1,1,0,<bang>0,<q-args>)
command! -bang -bar -nargs=+ -complete=file GrepaddJob
            \ call <sid>MakeJob(1,0,1,<bang>0,<q-args>)
command! -bang -bar -nargs=+ -complete=file LgrepaddJob
            \ call <sid>MakeJob(1,1,1,<bang>0,<q-args>)
command! -nargs=? -complete=customlist,<sid>MakeJobCompletion
            \ MakeJobStop call <sid>JobStop(<f-args>)
let &cpo = s:save_cpo
unlet s:save_cpo
" vim: et sts=4 sw=4 tw=72

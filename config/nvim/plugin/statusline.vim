function! StatusBranch()
  let branch = fugitive#head()
  return empty(branch) ? '' : '(' . branch . ')'
endfunction

set statusline=\ ❮\ %<%f\ %{StatusBranch()}\ %h%m%r%=\ %y\ ❯\ 

" Status line
" let s:min_status_width = 70
" let s:mode_map = {
"       \ 'n':      '  NORMAL ',
"       \ 'no':     '  NO     ',
"       \ 'v':      '  V-CHAR ',
"       \ 'V':      '  V-LINE ',
"       \ 'CTRL-V': '  V-BLOCK',
"       \ 's':      '  S-CHAR ',
"       \ 'S':      '  S-LINE ',
"       \ 'CTRL-S': '  S-BLOCK',
"       \ 'i':      '  INSERT ',
"       \ 'ic':     '  I-COMP ',
"       \ 'ix':     '  I-COMP ',
"       \ 'R':      '  REPLACE',
"       \ 'Rc':     '  R-COMP ',
"       \ 'Rv':     '  R-VIRT ',
"       \ 'Rx':     '  R-COMP ',
"       \ 'c':      '  C-LINE ',
"       \ 'cv':     '  EX     ',
"       \ 'ce':     '  EX     ',
"       \ 'r':      '  ENTER  ',
"       \ 'rm':     '  MORE   ',
"       \ 'r?':     '  CONFIRM',
"       \ '!':      '  SHELL  ',
"       \ }

" func! s:status_ignore()
"   return winwidth(0) <= s:min_status_width || &ft ==# 'netrw'
" endfunc

" func! StatusMode()
"   if s:status_ignore() || &readonly
"     return ''
"   endif
"   let l:mode = mode()
"   return has_key(s:mode_map, l:mode) ? s:mode_map[l:mode] : ''
" endfunc

" func! StatusPaste()
"   if s:status_ignore()
"     return ''
"   endif
"   return &paste ? ' PASTE ' : ''
" endfunc

" func! StatusFilename()
"   let name = expand('%:p:t')
"   let name = name !=# '' ? "⋱  ". name : '[No Name]'
"   if &ft ==# 'netrw'
"     let name = '  netrw'
"   endif
"   call s:hi_filename()
"   let ignore = s:status_ignore()
"   let empty = ignore ? '  ' : '    '
"   return empty . name
" endfunc

" func! StatusFileType()
"   return empty(&ft) ? '' : '  ' . &ft . '   '
" endfunc

" func! StatusLineInfo()
"   if s:status_ignore()
"     return ''
"   endif
"   let msg = printf('%d:%d', line('.'), col('.'))
"   return "  ⌁  " . msg . '  '
" endfunc

" func! s:hi(item, bg, ...)
"   let fg = ''
"   let extra = ''
"   if a:0 >= 2
"     let fg = a:1
"     let extra = a:2
"   elseif a:0 > 0
"     let fg = a:1
"   endif
"   let guifg = empty(fg) ? '' : ' guifg=' . fg
"   let extra = empty(extra) ? '' : ' ' . extra
"   exe 'hi ' . a:item . guifg . ' guibg=' . a:bg . extra
" endfunc


" let s:color = {
"       \ 'status_bg': 'NONE',
"       \ 'status_fg': 'Comment',
"       \ 'fname_modified': '#d65d0e',
"       \ 'fname_readonly': '#b16286',
"       \ }

" func! s:hi_filename()
"   if &modified
"     call s:hi('StatusActiveFName', s:color.status_bg, s:color.fname_modified)
"     call s:hi('StatusInactiveFName', s:color.status_bg, s:color.fname_modified)
"   elseif &readonly
"     call s:hi('StatusActiveFName', s:color.status_bg, s:color.fname_readonly)
"     call s:hi('StatusInactiveFName', s:color.status_bg, s:color.fname_readonly)
"   else
"     hi clear StatusActiveFName
"     hi clear StatusInactiveFName
"     hi link StatusActiveFName       StatusActiveMode
"     hi link StatusInactiveFName     StatusActiveMode
"   endif
" endfunc

" let s:status_ignored_types = ['unite', 'finder', 'vaffle']


" func! s:set_highlight()
"   call s:hi('StatusLine', s:color.status_bg, s:color.status_bg)
"   call s:hi('StatusLineNC', s:color.status_bg, s:color.status_bg)

"   if index(s:status_ignored_types, &ft) >= 0
"     return
"   endif

"   call s:hi('StatusActiveMode', s:color.status_bg, s:color.status_fg)
"   hi link StatusActivePaste     StatusActiveMode
"   hi link StatusActiveBranch    StatusActiveMode
"   hi link StatusActiveFType     StatusActiveMode
"   hi link StatusActiveLInfo     StatusActiveMode
"   hi link StatusActiveALE       StatusActiveMode

"   call s:hi_filename()

"   call s:hi('ALEInfoSign', s:color.status_bg, '#83a598', 'cterm=bold')
"   call s:hi('ALEErrorSign', s:color.status_bg, '#fabd2f', 'cterm=bold')
"   call s:hi('ALEWarningSign', s:color.status_bg, '#fb4934', 'cterm=bold')
" endfunc
" call s:set_highlight()


" func! StatusSpace()
"   return &ft ==# 'netrw' ? '' : '  '
" endfunc


" func! s:create_statusline(mode)
"   if index(s:status_ignored_types, &ft) >= 0
"     return
"   endif

"   if a:mode ==? 'active'
"     let parts = [
"           \ '%#Status' .a:mode. 'Mode#%{StatusMode()}',
"           \ '%#Status' .a:mode. 'Paste#%{StatusPaste()}',
"           \ '%#Status' .a:mode. 'FName#%{StatusFilename()}',
"           \ '%#Status' .a:mode. 'Branch#%-{StatusBranch()}',
"           \ '%=',
"           \ '%#Status' .a:mode. 'FType#%{StatusFileType()}',
"           \ '%#Status' .a:mode. 'LInfo#%{StatusLineInfo()}',
"           \ ]
"   else
"     let parts = ['%{StatusSpace()}', '%#Status' .a:mode. 'FName#%{StatusFilename()}']
"   endif
"   exe 'setlocal statusline=' . join(parts, '')
" endfunc


" augroup mystatusline
"   hi StatusLineNC guibg=#f7f0ce
"   autocmd WinEnter,BufWinEnter * call s:create_statusline('Active')
"   autocmd WinLeave * call s:create_statusline('Inactive')
" augroup END

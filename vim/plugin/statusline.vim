let s:min_status_width = 70
let s:mode_map = {
      \ 'n':      '  NORMAL ',
      \ 'no':     '  NO     ',
      \ 'v':      '  V-CHAR ',
      \ 'V':      '  V-LINE ',
      \ 'CTRL-V': '  V-BLOCK',
      \ 's':      '  S-CHAR ',
      \ 'S':      '  S-LINE ',
      \ 'CTRL-S': '  S-BLOCK',
      \ 'i':      '  INSERT ',
      \ 'ic':     '  I-COMP ',
      \ 'ix':     '  I-COMP ',
      \ 'R':      '  REPLACE',
      \ 'Rc':     '  R-COMP ',
      \ 'Rv':     '  R-VIRT ',
      \ 'Rx':     '  R-COMP ',
      \ 'c':      '  C-LINE ',
      \ 'cv':     '  EX     ',
      \ 'ce':     '  EX     ',
      \ 'r':      '  ENTER  ',
      \ 'rm':     '  MORE   ',
      \ 'r?':     '  CONFIRM',
      \ '!':      '  SHELL  ',
      \ }

func! s:status_ignore()
  return winwidth(0) <= s:min_status_width || &ft ==# 'netrw'
endfunc

func! StatusMode()
  if s:status_ignore() || &readonly
    return ''
  endif
  let l:mode = mode()
  return has_key(s:mode_map, l:mode) ? s:mode_map[l:mode] : ''
endfunc

func! StatusFileType()
  return empty(&ft) ? '' : '<' . &ft . '>  '
endfunc

func! StatusFilename()
  let name = expand('%:p:t')
  let name = name !=# '' ?  name . '  ' : '[No Name]  '
  if &ft ==# 'netrw'
    let name = '  netrw'
  endif
  let ignore = s:status_ignore()
  let empty = ignore ? '  ' : ''
  return empty . name
endfunc

func! StatusBranch()
  if s:status_ignore() || !exists('*fugitive#head')
    return ''
  endif
  let branch = fugitive#head()
  return empty(branch) ? '' : branch . '  '
endfunc

func! s:create_statusline(mode)
  if a:mode ==? 'active'
    let parts = [
          \ '%{StatusMode()}',
          \ '%=',
          \ '%{StatusFileType()}',
          \ '%{StatusFilename()}',
          \ '%{StatusBranch()}',
          \ ]
  else
    let parts = [
          \ '%=',
          \ '%{StatusFilename()}',
	  \ ]
  endif
  exe 'setlocal statusline=' . join(parts, '')
endfunc

augroup mystatusline
  autocmd WinEnter,BufWinEnter * call s:create_statusline('Active')
  autocmd WinLeave * call s:create_statusline('Inactive')
augroup END


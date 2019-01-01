" File finder
function! FzyCommand(choice_command, vim_command) abort
  let l:callback = {
              \ 'window_id': win_getid(),
              \ 'filename': tempname(),
              \ 'vim_command':  a:vim_command
              \ }

  function! l:callback.on_exit(job_id, data, event) abort
    bdelete!
    call win_gotoid(self.window_id)
    if filereadable(self.filename)
      try
        let l:selected_filename = readfile(self.filename)[0]
        exec self.vim_command . l:selected_filename
      catch /E684/
      endtry
    endif
    call delete(self.filename)
  endfunction

  botright 10 new
  let l:term_command = a:choice_command . ' | fzy > ' .  l:callback.filename
  silent call termopen(l:term_command, l:callback)
  setlocal nonumber norelativenumber
  startinsert
endfunction


" Status line
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

func! StatusPaste()
  if s:status_ignore()
    return ''
  endif
  return &paste ? ' PASTE ' : ''
endfunc

func! StatusBranch()
  if s:status_ignore() || !exists('*fugitive#head')
    return ''
  endif
  let branch = fugitive#head()
  return empty(branch) ? '' : "  →  " . branch
endfunc

func! StatusFilename()
  let name = expand('%:t')
  let name = name !=# '' ? "→  " . name : '[No Name]'
  if &ft ==# 'netrw'
    let name = '  netrw'
  endif
  call s:hi_filename()
  let ignore = s:status_ignore()
  let empty = ignore ? '  ' : '    '
  return empty . name
endfunc

func! StatusTag()
  if s:status_ignore() || !exists('*tagbar#currenttag')
    return ''
  endif
  let tag = tagbar#currenttag('%s', '', '')
  return empty(tag) ? '' : tag . '  '
endfunc

func! StatusFileType()
  if s:status_ignore() || get(b:, 'statusline_hide_filetype', v:true)
    return ''
  endif
  return empty(&ft) ? '' : &ft . '   '
endfunc

function! StatusLinter() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '  ★ ' : printf(
    \   '  ⊘: %d  ×: %d',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

func! StatusLineInfo()
  if s:status_ignore()
    return ''
  endif
  let msg = printf('%d:%d', line('.'), col('.'))
  return "  ⌁  " . msg . '  '
endfunc

func! s:hi(item, bg, ...)
  let fg = ''
  let extra = ''
  if a:0 >= 2
    let fg = a:1
    let extra = a:2
  elseif a:0 > 0
    let fg = a:1
  endif
  let guifg = empty(fg) ? '' : ' guifg=' . fg
  let extra = empty(extra) ? '' : ' ' . extra
  exe 'hi ' . a:item . guifg . ' guibg=' . a:bg . extra
endfunc


let s:color = {
      \ 'status_bg': 'NONE',
      \ 'status_fg': '#757575',
      \ 'fname_modified': '#c38300',
      \ 'fname_readonly': '#525252',
      \ }

func! s:hi_filename()
  if &modified
    call s:hi('StatusActiveFName', s:color.status_bg, s:color.fname_modified)
    call s:hi('StatusInactiveFName', s:color.status_bg, s:color.fname_modified)
  elseif &readonly
    call s:hi('StatusActiveFName', s:color.status_bg, s:color.fname_readonly)
    call s:hi('StatusInactiveFName', s:color.status_bg, s:color.fname_readonly)
  else
    hi clear StatusActiveFName
    hi clear StatusInactiveFName
    hi link StatusActiveFName       StatusActiveMode
    hi link StatusInactiveFName     StatusActiveMode
  endif
endfunc


let s:status_ignored_types = ['unite', 'finder']


func! s:set_highlight()
  call s:hi('StatusLine', s:color.status_bg, s:color.status_bg)
  call s:hi('StatusLineNC', s:color.status_bg, s:color.status_bg)

  if index(s:status_ignored_types, &ft) >= 0
    return
  endif

  call s:hi('StatusActiveMode', s:color.status_bg, s:color.status_fg)
  hi link StatusActivePaste     StatusActiveMode
  hi link StatusActiveBranch    StatusActiveMode
  hi link StatusActiveTag       StatusActiveMode
  hi link StatusActiveFType     StatusActiveMode
  hi link StatusActiveLInfo     StatusActiveMode
  hi link StatusActiveTmux      StatusActiveMode

  call s:hi_filename()

  call s:hi('VertSplit', s:color.status_bg, s:color.status_fg)
  call s:hi('SignColumn', s:color.status_bg)
  call s:hi('ALEErrorSign', s:color.status_bg, '#C62828', 'cterm=bold')
  call s:hi('ALEWarningSign', s:color.status_bg, '#F9A825', 'cterm=bold')
endfunc
call s:set_highlight()


func! StatusSpace()
  return &ft ==# 'netrw' ? '' : '  '
endfunc


func! s:create_statusline(mode)
  if index(s:status_ignored_types, &ft) >= 0
    return
  endif

  if a:mode ==? 'active'
    let parts = [
          \ '%#Status' .a:mode. 'Mode#%{StatusMode()}',
          \ '%#Status' .a:mode. 'Paste#%{StatusPaste()}',
          \ '%#Status' .a:mode. 'Branch#%-{StatusBranch()}',
          \ '%#Status' .a:mode. 'FName#%{StatusFilename()}',
          \ '%=',
          \ '%#Status' .a:mode. 'Tag#%{StatusTag()}',
          \ '%#Status' .a:mode. 'FType#%{StatusFileType()}',
          \ '%#Status' .a:mode. 'LInfo#%{StatusLineInfo()}',
          \ '%#Status' .a:mode. 'ALE#%{StatusLinter()}',
          \ ]
  else
    let parts = ['%{StatusSpace()}', '%#Status' .a:mode. 'FName#%{StatusFilename()}']
  endif
  exe 'setlocal statusline=' . join(parts, '')
endfunc

augroup mystatusline
  autocmd WinEnter,BufWinEnter * call s:create_statusline('Active')
  autocmd WinLeave * call s:create_statusline('Inactive')
augroup END

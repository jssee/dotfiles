scriptencoding utf-8

" Trims empty white spaces
" ========================
function! fun#trim()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

" Toggles a terminal window
" =========================
function! fun#toggle_term(height)
  let l:term_win = 0
  let l:term_buf = 0

  if win_gotoid(l:term_win)
    hide
  else
    botright new
    exec "resize " . a:height
    try
      exec "buffer " . l:term_buf
    catch
      call termopen($SHELL, {"detach": 0})
      let l:term_buf = bufnr("")
      setlocal nonumber norelativenumber
    endtry
    startinsert!
    let l:term_win = win_getid()
  endif
endfunction

function! fun#grep(...)
  return system(join([&grepprg] + [a:1] + [expandcmd(join(a:000[1:-1], ' '))], ' '))
endfunction

" Fuzzy find project files and buffers
" ====================================
function! fun#fuzzy_cmd(choice_command, vim_command) abort
  let l:callback = {
        \ 'window_id': win_getid(),
        \ 'filename': tempname(),
        \ 'vim_command':  a:vim_command
        \ }

  function! l:callback.on_exit(job_id, data, event) abort
    setlocal bufhidden=delete
    close!
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

  botright 5 new
  let l:term_command = a:choice_command . ' | fzy > ' .  fnameescape(l:callback.filename)
  silent call termopen(l:term_command, l:callback)
  let b:stsline = 'Find file [command: ' . a:vim_command . ']'

  setlocal nonumber norelativenumber statusline=%{b:stsline}
  setfiletype fzy
  startinsert
endfunction


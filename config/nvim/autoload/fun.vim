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

function! fun#grep(...)
  return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
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


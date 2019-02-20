" Feed files and buffers through a fuzzy finder window
" ====================================================
if exists('g:loaded_fzy_filesearch')
    finish
endif

let g:loaded_fzy_filesearch = 1
let s:files_cmd = 'fd --type f . '
let s:buffer_cmd = 'bat '

function! FuzzBuf() abort
  let l:tmp = tempname()
  call writefile(map(getbufinfo(), 'v:val.name'), l:tmp)
  call fun#fuzzy_cmd(s:buffer_cmd . fnameescape(l:tmp), ':b ')
endfunction

function! FuzzFile() abort
  call fun#fuzzy_cmd(s:files_cmd, ':e ')
endfunction

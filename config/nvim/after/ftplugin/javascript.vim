setlocal autoread
setlocal errorformat+=%f:\ line\ %l\\,\ col\ %c\\,\ %m,%-G%.%#

if executable('eslint')
  setlocal makeprg=eslint\ --format\ compact
endif

if executable('prettier')
  setlocal formatprg=prettier\ --stdin-filepath\ %
endif

let b:match_words = '\<function\>:\<return\>,'
      \ . '\<do\>:\<while\>,'
      \ . '\<switch\>:\<case\>:\<default\>,'
      \ . '\<if\>:\<else\>,'
      \ . '\<try\>:\<catch\>:\<finally\>'


augroup javascript
  autocmd! * <buffer>
  autocmd BufWritePost <buffer> silent make <afile> | checktime | silent redraw!
augroup END


setlocal autoread
setlocal errorformat+=%f:\ line\ %l\\,\ col\ %c\\,\ %m,%-G%.%#

if executable('eslint')
  setlocal makeprg=eslint\ --format\ compact
endif

if executable('prettier')
  setlocal formatprg=prettier\ --\ --stdin-filepath\ %
endif

augroup JS
  autocmd! * <buffer>
  autocmd BufWritePost <buffer> silent make <afile> | checktime | silent redraw!
augroup END


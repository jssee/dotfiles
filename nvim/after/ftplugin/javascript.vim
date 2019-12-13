if executable('eslint')
  setlocal errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m,%-G%.%#
  setlocal makeprg=eslint\ --format\ compact

  augroup JS
    autocmd!
    autocmd BufWritePost <buffer> silent make! <afile> | silent redraw!
  augroup END
endif


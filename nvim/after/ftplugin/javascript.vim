if executable('eslint')
  let &l:errorformat = '%EERROR: %f:%l:%c - %m,'
                         \ . '%WWARNING: %f:%l:%c - %m,'
                         \ . '%E%f:%l:%c - %m,'
                         \ . '%-G%.%#'

  let &l:makeprg = 'eslint --format=node_modules/eslint-formatter-vim'

  augroup JS
    autocmd!
    autocmd BufWritePost <buffer> silent make! <afile> | silent redraw!
  augroup END
endif

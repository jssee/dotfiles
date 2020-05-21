if exists("b:did_jsx_setup")
  finish
endif
let b:did_jsx_setup = 1

runtime! $MYVIMRC/after/ftplugin/javascript.vim

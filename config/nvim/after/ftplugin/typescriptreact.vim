if exists("b:did_tsx_setup")
  finish
endif
let b:did_tsx_setup = 1

runtime! $MYVIMRC/after/ftplugin/typescript.vim

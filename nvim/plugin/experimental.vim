function! Format(type, ...)
  normal! '[v']gq
  call winrestview(b:gqview)
  unlet b:gqview
endfunction



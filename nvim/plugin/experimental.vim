if executable('typescript-language-server')
  " call nvim_lsp#setup("tsserver", {})
    " call lsp#add_filetype_config({
    "             \ 'filetype': ['typescript', 'typescriptreact', 'javascript', 'javascriptreact'],
    "             \ 'name': 'tsjs-lsp',
    "             \ 'cmd': 'typescript-language-server --stdio'
    "             \ })
endif

" if executable('css-languageserver')
"   call nvim_lsp#setup("cssls", {})
" endif

function! Format(type, ...)
  normal! '[v']gq
  call winrestview(b:gqview)
  unlet b:gqview
endfunction

" function! LSPSetMappings()
"   nnoremap <silent> <buffer> K :call lsp#text_document_hover()<CR>
"   nnoremap <silent> <buffer> <leader>D :call lsp#text_document_definition()<CR>
"   setlocal omnifunc=lsp#omnifunc
"   nmap <silent> GQ :let b:gqview = winsaveview()<CR>:set opfunc=Format<CR>g@
" endfunction

" augroup lsp
"   autocmd!
"   autocmd FileType typescript,typescriptreact,javascript,javascriptreact,html,css :call LSPSetMappings()
"   autocmd BufWritePre typescript,typescriptreact,javascript,javascriptreact,html,css :call :norm ggGQG
" augroup END


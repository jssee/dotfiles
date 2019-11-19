if executable('typescript-language-server')
    call lsp#add_filetype_config({
                \ 'filetype': ['typescript', 'typescriptreact', 'javascript', 'javascriptreact'],
                \ 'name': 'tsjs-lsp',
                \ 'cmd': 'typescript-language-server --stdio'
                \ })
endif

function! LSPSetMappings()
  nnoremap <silent> <buffer> K :call lsp#text_document_hover()<CR>
  nnoremap <silent> <buffer> <leader>D :call lsp#text_document_definition()<CR>
  setlocal omnifunc=lsp#omnifunc
endfunction

augroup lsp
  autocmd!
  au FileType typescript,typescriptreact,javascript,javascriptreact :call LSPSetMappings()
augroup END


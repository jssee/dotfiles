" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Tab for completion trgger
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

set signcolumn=no

au VimEnter,BufEnter,ColorScheme *
  \ exec "hi! CocInfoHighlight
    \ guifg=".(&background=='light'?'#808000':'#458588')."
    \ guibg=".(&background=='light'?'#ffff00':'#282828') |
  \ exec "hi! CocWarningHighlight
    \ guifg=".(&background=='light'?'#808000':'#FFD700')."
    \ guibg=".(&background=='light'?'#ffff00':'#282828') |
  \ exec "hi! CocErrorHighlight
    \ guifg=".(&background=='light'?'#ff0000':'#FF6347')."
    \ guibg=".(&background=='light'?'#ffcccc':'#282828')



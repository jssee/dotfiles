" let g:ale_sign_column_always = 1
" let g:ale_sign_error = '×'
" let g:ale_sign_warning = '⊘'

" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1

" Don't use the sign column/gutter for ALE
let g:ale_set_signs = 0

" Lint when leaving Insert Mode but don't lint when in Insert Mode 
let g:ale_lint_on_insert_leave = 1

" Lint always in Normal Mode
let g:ale_lint_on_text_changed = 'normal'

" Set ALE's 200ms delay to zero
let g:ale_lint_delay = 0

" Set gorgeous colors for marked lines to sane, readable combinations 
" working with any colorscheme
au VimEnter,BufEnter,ColorScheme *
  \ exec "hi! ALEInfoLine
    \ guifg=".(&background=='light'?'#808000':'#ALEInfoSign#')." 
    \ guibg=".(&background=='light'?'#ffff00':'#282828') |
  \ exec "hi! ALEWarningLine
    \ guifg=".(&background=='light'?'#808000':'#ALEWarningSign#')."
    \ guibg=".(&background=='light'?'#ffff00':'#282828') |
  \ exec "hi! ALEErrorLine
    \ guifg=".(&background=='light'?'#ff0000':'#ALEErrorSign#')."
    \ guibg=".(&background=='light'?'#ffcccc':'#282828')

let g:ale_linters = {
      \  'javascript': ['eslint', 'prettier'],
      \  'typescript': ['tsserver', 'tslint', 'prettier'],
      \  'css': ['prettier'],
      \  'scss': ['prettier'],
      \ }

let g:ale_linters = {
      \  'javascript': ['eslint', 'prettier'],
      \  'typescript': [ 'tsserver', 'tslint', 'eslint', 'prettier'],
      \  'css': ['prettier'],
      \  'scss': ['prettier'],
      \ }

let g:ale_fixers = {
      \ 'javascript': ['eslint', 'prettier'],
      \ 'typescript': ['tslint', 'eslint', 'prettier'],
      \ 'css': ['prettier'],
      \ 'scss': ['prettier'],
      \ }

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

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
    \ guifg=".(&background=='light'?'#808000':'#458588')."
    \ guibg=".(&background=='light'?'#ffff00':'#282828') |
  \ exec "hi! ALEWarningLine
    \ guifg=".(&background=='light'?'#808000':'#FFD700')."
    \ guibg=".(&background=='light'?'#ffff00':'#282828') |
  \ exec "hi! ALEErrorLine
    \ guifg=".(&background=='light'?'#ff0000':'#FF6347')."
    \ guibg=".(&background=='light'?'#ffcccc':'#282828')


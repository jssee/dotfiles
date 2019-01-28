let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_smart_completion = 1
let g:asyncomplete_auto_popup = 1

let g:lsp_diagnostics_enabled = 0
let g:lsp_signs_enabled = 0

set completeopt+=preview

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

if has('python3')
    let g:UltiSnipsExpandTrigger="<tab>"
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'whitelist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif

call asyncomplete#register_source(asyncomplete#sources#tscompletejob#get_source_options({
    \ 'name': 'tscompletejob',
    \ 'whitelist': ['typescript', 'typescript.tsx'],
    \ 'completor': function('asyncomplete#sources#tscompletejob#completor'),
    \ }))

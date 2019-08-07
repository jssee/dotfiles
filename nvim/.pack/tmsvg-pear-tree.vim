let g:pear_tree_repeatable_expand = 0

" Add HTML style closing for jsx/tsx files
augroup Jsx
  autocmd!
  autocmd FileType javascript.jsx,typescript.tsx let b:pear_tree_pairs = extend(deepcopy(g:pear_tree_pairs), {'<*>': {'closer': '</*>'}, }, 'keep')
augroup END

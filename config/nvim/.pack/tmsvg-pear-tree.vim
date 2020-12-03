let g:pear_tree_repeatable_expand = 0

augroup tagsclose
  autocmd!
  autocmd BufNewFile,BufEnter *.jsx,*.tsx
        \ let b:pear_tree_pairs = extend(deepcopy(g:pear_tree_pairs), {
        \ '<*>': {'closer': '</*>',
        \         'not_if': ['br', 'hr', 'img', 'input', 'link', 'meta',
        \                    'area', 'base', 'col', 'command', 'embed',
        \                    'keygen', 'param', 'source', 'track', 'wbr'],
        \         'not_like': '{[^}]*$\|/$',
        \         'not_at': ['[^> ]<[^>]*'],
        \         'not_in': ['String'],
        \         'until': '[^a-zA-Z0-9-._]'
        \        }
        \ }, 'keep')
augroup END

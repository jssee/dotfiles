let g:pear_tree_repeatable_expand = 0

let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

let b:pear_tree_pairs = {
        \ '<*>': {
        \   'closer': '</*>',
        \   'not_if': ['br', 'hr', 'img', 'input', 'link', 'meta', 'area', 'base', 'col', 'command', 'embed', 'keygen', 'param', 'source', 'track', 'wbr'],
        \ }
        \}

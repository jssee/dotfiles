let g:prettier#autoformat = 0
let g:prettier#config#single_quote = 'false'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#parser = 'babylon'
let g:prettier#config#bracket_spacing = 'true'
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync


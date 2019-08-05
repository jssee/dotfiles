if executable('eslint')
	setlocal makeprg=eslint\ --format=compact
	setlocal errorformat=%l.%c:\ %m
endif

if executable('prettier')
	setlocal formatprg=prettier\ --parser=babel
endif

augroup Js
	autocmd!
	" run eslint on save
	autocmd BufWritePost *.js,*.jsx make! <afile> | silent redraw!
	" run prettier on save
	autocmd BufWritePost *.js,*.jsx normal mXggGQG'X
augroup END

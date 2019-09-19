if executable('eslint')
	setlocal makeprg=eslint\ --format=compact
	setlocal errorformat=%l.%c:\ %m
endif

if executable('prettier')
	setlocal formatprg=prettier\ --parser=babel
endif

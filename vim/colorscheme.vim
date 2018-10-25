" Background color scheduler
if strftime('%H') >= 7 && strftime('%H') < 12
  set background=light
  let g:lightline = { 'colorscheme': 'stellarized_light'  }
else
  set background=dark
  let g:lightline = { 'colorscheme': 'stellarized_dark'  }
endif

colorscheme stellarized
set termguicolors
filetype on

" Background color scheduler
if strftime('%H') >= 7 && strftime('%H') < 12
  set background=light
  let g:lightline = { 'colorscheme': 'stellarized_light'  }
else
  set background=dark
  let g:lightline = { 'colorscheme': 'gruvbox'  }
endif

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg0'

colorscheme gruvbox
set termguicolors
filetype on

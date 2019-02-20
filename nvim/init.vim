
" [1] SETTINGS
" ============
set nocompatible
let mapleader = "\<Space>"
filetype plugin indent on
syntax on
set encoding=utf-8 nobomb

" General Settings
set autoread " read changes that happen elsewhere
set autowriteall " Automatically write everything
set backspace=indent,eol,start " Backspacebhavior
set breakindent " Indents wrapped lines
set clipboard=unnamed
set formatoptions+=t
set hidden
set lazyredraw " Dont redraw during macros
set mouse=a " Use the mouse
set noerrorbells
set scrolloff=10
set splitbelow
set splitright
set timeoutlen=300 ttimeoutlen=100 " Shorten the time to complete map sequences
set visualbell
set whichwrap=b,h,l,s,<,>,[,],~       " allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries

"Tabs and indent behavior
set autoindent
set copyindent
set expandtab
set shiftwidth=2
set smartindent
set softtabstop=2
set tabstop=2

" Display
set modelines=0
set noshowmode " Dont show current mode
set number
set ruler
set title
set tw=100

" Clean up messaging
set shortmess+=o
set shortmess+=s
set shortmess+=c
set shortmess+=q
set shortmess+=F

" Folds
set foldlevel=99
set foldnestmax=10
set foldmethod=indent
set foldlevelstart=999

" Search
set incsearch " typeahead
set infercase " case sensitive completion
set magic " use regex special chars
set ignorecase " ignore case
set smartcase " ...if all chars are lowercase

" Popup menu options
set completeopt+=menuone
set completeopt+=noinsert

" No backup files, live on the edge
set directory^=$HOME/.vim/tmp//
set nobackup
set noswapfile

" Colors
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg0'
set termguicolors
set background=dark
colorscheme gruvbox

" Nicer vertical splits
let &fillchars='vert: ,fold:·'
let &listchars='tab:| ,eol:¬,trail:⣿,extends:→,precedes:←'

" Opt into some optional vim stuff
packadd cfilter
runtime macros/matchit.vim

" Setup specific settings
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

if has('persistent_undo')
  set undodir=~/.undodir/
  set undofile
endif

if exists('&inccommand')
  set inccommand=nosplit " (neovim) specific, live substitutin preview
endif


" [2] Mappings
" ============
:nmap ; :
xnoremap ; :

inoremap jk <Esc>
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> <Leader>qq :silent qa!<CR>
nnoremap <silent> <Leader>fs :silent w<CR> :echo "write @ " . strftime("%X")<CR>

" faster viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Buffers
nnoremap <silent> <Leader>bn :bn<CR>
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <silent> <Leader>bp :bp<CR>
nnoremap <silent> <Leader>bb :ls<CR>:b<Space>

" Windows
nnoremap <silent> <Leader>wd :silent close<CR>
nnoremap <silent> <Leader>w- :silent sp<CR>
nnoremap <silent> <Leader>w/ :silent vsp<CR>
nnoremap <silent> <Leader>wh :silent wincmd h<CR>
nnoremap <silent> <Leader>wj :silent wincmd j<CR>
nnoremap <silent> <Leader>wk :silent wincmd k<CR>
nnoremap <silent> <Leader>wl :silent wincmd l<CR>

" Smoother searching, tab through partially complete candidates
cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>/<C-r>/" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>?<C-r>/" : "<S-Tab>"

" Use tab and shift tab to indent and de-indent code
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
xnoremap <Tab>   >><Esc>gV
xnoremap <S-Tab> <<<Esc>gV

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR><CR>:cw<CR>

" Find and replace in 'paragraph'
nnoremap <Leader>rw :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
" Find and replace in buffer
nnoremap <Leader>ra :%s/\<<C-r>=expand("<cword>")<CR>\>/

" Plugin mappings
nnoremap <silent> <Leader>ft :Vaffle<CR>
nnoremap <silent> <Leader>pf :call FuzzFile()<CR>
nnoremap <silent> <Leader>bf :call FuzzBuf()<CR>
nnoremap <silent> <Leader>tt :call fun#toggle_term(10)<cr>


" [3] AUTOCMDS
" ============
augroup Groupie
  autocmd!
  " Return to last edit position when opening files
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  " Trim empty whitespace on save
  autocmd BufWritePre * call fun#trim()
  " Resize splits when the window is resized
  autocmd VimResized * :wincmd =
  " Tone done popup menu
  autocmd VimEnter,BufEnter * exec "hi! Pmenu guibg='#282828' guifg='#928374'"
  " Tone down cursorline while we're at it
  autocmd BufEnter * highlight CursorLine guibg=#1d2021
augroup END

augroup Term
  autocmd!
  autocmd TermOpen * setlocal nonu nornu
augroup END

"  Quickfix specifics, useful for grepping
" ==================
augroup Qf
	autocmd!
	" Automatically open quickfix window
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
augroup END
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr system(&grepprg . ' <args>')
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr system(&grepprg . ' <args>')

" Correct syntax for incorrect filetypes
" ======================================
augroup FileTyping
  autocmd!
  autocmd BufRead,BufNewFile jrnl*.txt,TODO,*.mdx setfiletype markdown
  autocmd BufRead,BufNewFile .{babel,eslint,stylelint,jshint,prettier}rc,.tern-* setfiletype json
  autocmd BufRead,BufNewFile .envrc setfiletype bash
augroup END

" Vimrc ergonomics
" ================
augroup MyRc
  autocmd!
  autocmd BufWritePost *vimrc\|*init.vim source $MYVIMRC
  autocmd BufEnter .vimrc set ft=vim
augroup END

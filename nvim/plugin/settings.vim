set nocompatible

" Display
set modelines=0 
set noshowmode
set number
set ruler
set showcmd
set title
set tw=100

" Search
set incsearch " typeahead
set infercase " case sensitive completion
set magic " use regex special chars
set ignorecase " ignore case
set smartcase " ...if all chars are lowercase

" Scroll
set mouse=a
set scrolloff=10

" Fix Backspace
set backspace=indent,eol,start

" Syntax settings
filetype off
filetype plugin indent on
set encoding=utf-8 nobomb
syntax on

" Tab and indent
set autoindent
set copyindent
set expandtab
set shiftwidth=2
set smartindent
set softtabstop=2
set tabstop=2

" Motion
set formatoptions+=t
set nostartofline

" Copy and Pasting
set clipboard=unnamed

" Buffers
set hidden

" Windows
set splitright
set splitbelow

set autoread
set autowrite

" Nicer vertical splits
let &fillchars='vert: ,fold:·'
let &listchars='tab:| ,eol:¬,trail:⣿,extends:→,precedes:←'

" like, chill out
set visualbell
set noerrorbells

set whichwrap=b,h,l,s,<,>,[,],~ " Allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries

" No backup files, live on the edge
set directory^=$HOME/.vim/tmp//
set nobackup
set noswapfile

" Folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Misc
set timeoutlen=1000 ttimeoutlen=100
set autoread

" Colors
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg0'

set background=dark
colorscheme gruvbox
set termguicolors

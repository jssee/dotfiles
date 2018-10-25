set nocompatible

" Almighty leader
let mapleader = "\<Space>"

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
set scrolloff=5

" Fix Backspace
set backspace=indent,eol,start

" Syntax settings
filetype plugin indent on
set encoding=utf-8 nobomb
set t_Co=256
syntax enable " colorscheme settings at colorscheme.vim

" Tabs and indent
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

" Misc
set directory^=$HOME/.vim/tmp//
set nobackup
set noswapfile

" Change cursor depending on mode
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

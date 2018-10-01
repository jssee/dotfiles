call plug#begin('~/.config/plug')

Plug 'SirVer/ultisnips'
Plug 'ap/vim-buftabline'
Plug 'cocopon/vaffle.vim'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'maralla/completor.vim', { 'do': 'make js' }
Plug 'maralla/completor-typescript'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-signify'
Plug 'nightsense/stellarized'
Plug 'sheerun/vim-polyglot' 
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

call plug#end()

" Map leader to space
let mapleader = "\<Space>"

" Settings
set autoindent
set backspace=indent,eol,start
set copyindent
set directory^=$HOME/.vim/tmp//
set encoding=utf-8 nobomb
set expandtab
set formatoptions+=t
set hidden
set ignorecase
set incsearch
set modelines=0 
set mouse=a
set nobackup
set nocompatible
set noshowmode
set nostartofline
set noswapfile
set number
set ruler
set scrolloff=5
set shiftwidth=2
set showcmd
set smartcase
set smartindent
set softtabstop=2
set t_Co=256
set tabstop=2
set title
set tw=100
syntax enable
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Change cursor depending on mode
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" move lines up and down
nnoremap <S-j> :m .+1<CR>==
nnoremap <S-k> :m .-2<CR>==
inoremap <S-j> <Esc>:m .+1<CR>==gi
inoremap <S-k> <Esc>:m .-2<CR>==gi
vnoremap <S-j> :m '>+1<CR>gv=gv

" Syntax colors
colorscheme stellarized
filetype on
let g:lightline = { 'colorscheme': 'stellarized_dark' }
set background=dark
set termguicolors
syntax enable

" Remaps
nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>bd :bdelete<CR>
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>fs :w<CR>
nnoremap <Leader>ft :Vaffle<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader>qq :qa<CR>
nnoremap <Leader>ss :Ag<CR>
nnoremap <Leader>w- :sp<CR>
nnoremap <Leader>w/ :vsp<CR>
nnoremap <Leader>wh <C-W>h
nnoremap <Leader>wj <C-W>j
nnoremap <Leader>wk <C-W>k
nnoremap <Leader>wl <C-W>l

:nmap ; :
inoremap jk <Esc>

let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }


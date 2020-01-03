" [1] SETTINGS
" ============
if &compatible
  set nocompatible
endif

filetype plugin indent on
syntax on

let mapleader = "\<Space>"

" General Settings
set encoding=utf-8 nobomb
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
set completeopt=menuone,noselect,noinsert

" Tabs and indent behavior
set autoindent
set copyindent
set expandtab
set shiftwidth=2
set smartindent
set softtabstop=2
set tabstop=2

" Display
set cursorline
set modelines=0
set noshowmode
set showcmd
set title
set titlestring='•ᴗ•'
set tw=100
set updatetime=300

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

" menu options
set wildmenu
set wildmode=full
set wildcharm=<C-z>

" No backup files, live on the edge
set directory^=$HOME/.vim/tmp//
set nobackup
set noswapfile

set diffopt&
      \ diffopt+=vertical
      \ diffopt+=hiddenoff

" Nicer vertical splits
let &fillchars='vert: ,fold:·'
let &listchars='tab:| ,eol:¬,trail:⣿,extends:→,precedes:←'

" Colors
set termguicolors
colorscheme bruin

" Opt into some optional vim stuff
packadd cfilter
runtime macros/matchit.vim

" Setup specific settings
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr fun#grep(<q-args>)
  command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr fun#grep(<q-args>)
endif

if has('persistent_undo')
  set undodir=~/.undodir/
  set undofile
endif

if exists('&inccommand')
  set inccommand=nosplit
endif


" [2] MAPPINGS
" ============
nnoremap ; :
nnoremap : ;
xnoremap ; :

inoremap kj <Esc>
cnoremap kj <Esc>

nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> <Leader>w :silent w<CR> :echo "✨ " . strftime("%X")<CR>

" Buffers
nnoremap <silent> <Leader>x :bd!<CR>
nnoremap <silent> <Leader><Leader> <C-^>
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <S-Tab> :bn<CR>

" Windows
nnoremap <silent> <Leader>wd :silent close<CR>
nnoremap <silent> <Leader>w- :silent sp<CR>
nnoremap <silent> <Leader>w/ :silent vsp<CR>
nnoremap <silent> <Leader>wh :silent wincmd h<CR>
nnoremap <silent> <Leader>wj :silent wincmd j<CR>
nnoremap <silent> <Leader>wk :silent wincmd k<CR>
nnoremap <silent> <Leader>wl :silent wincmd l<CR>

" tab through search candidates
cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>/<C-r>/" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>?<C-r>/" : "<S-Tab>"

" tab through completion options
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" Find and replace in 'paragraph'
nnoremap <Leader>rw :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
" Find and replace cursor word in buffer
nnoremap <Leader>ra :%s/\<<C-r>=expand("<cword>")<CR>\>/

" Grep w/ Rg
nnoremap <Leader>/ :Grep<Space>
nnoremap <Leader>* :Grep <C-R>=expand("<cword>")<CR><CR>

" increment / decrement
nnoremap + <C-a>
nnoremap _ <C-x>

" natural changing
nnoremap ,, *``cgn

" resizing mad easy
nnoremap <silent> <Leader>= :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" Plugin mappings
nnoremap <silent> <Leader>ff :call FuzzFile()<CR>
nnoremap <silent> <Leader>fb :call FuzzBuf()<CR>
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
  " close popup on completion finish
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

augroup Term
  autocmd!
  autocmd TermOpen * setlocal nonu nornu
  if has('nvim')
    " make leaving the term window less of PITA
    tnoremap <Esc> <C-\><C-n>
    tnoremap <M-[> <Esc>
  endif
augroup END

"  Quickfix specifics, useful for grepping
" ========================================
augroup Qf
  " Automatically open quickfix window
  autocmd!
  autocmd QuickFixCmdPost cgetexpr cwindow
  autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

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

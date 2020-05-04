if &compatible
  set nocompatible
endif

filetype plugin indent on
syntax on

set termguicolors
colorscheme substrata

set autoread
set autowriteall
set backspace=indent,eol,start
set breakindent
set clipboard=unnamed
set completeopt=menuone,noselect,noinsert
set copyindent
set cursorline
set encoding=utf-8 nobomb
set expandtab
set foldlevelstart=999
set foldmethod=indent
set foldnestmax=10
set formatoptions+=t,c,b
set hidden
set ignorecase
set incsearch
set infercase
set lazyredraw
set magic
set modelines=0
set mouse=a
set nobackup
set noshowmode
set noswapfile
set scrolloff=999
set shiftwidth=0
set shiftround
set shortmess+=Fcos
set showbreak=↳\ \
set showcmd
set smartcase
set smartindent
set splitbelow
set splitright
set tabstop=2
set textwidth=80
set timeoutlen=500 ttimeoutlen=100
set title
set updatetime=300
set visualbell
set whichwrap=b,h,l,s,<,>,[,],~
set wildcharm=<C-z>
set wildmenu
set wildmode=full
set diffopt&
      \ diffopt+=vertical
      \ diffopt+=hiddenoff

let mapleader = "\<Space>"
let &softtabstop = &tabstop
let &fillchars='vert: ,fold:·'
let &listchars='tab:→\,space:⋅,trail:⣿,extends:→,precedes:←'

if executable('rg')
  set grepprg=rg\ --vimgrep
endif
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr fun#grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr fun#grep(<f-args>)

if has('persistent_undo')
  set undodir=~/.undodir/
  set undofile
endif

if exists('&inccommand')
  set inccommand=nosplit
endif

packadd cfilter
runtime macros/matchit.vim

nnoremap ; :
xnoremap ; :
nnoremap , ;

inoremap kj <Esc>
cnoremap kj <Esc>

nnoremap j gj
nnoremap k gk
nnoremap n nzvzz
nnoremap N Nzvzz
nnoremap * *zvzzN
nnoremap # #zvzz
nnoremap 0 ^
nnoremap ^ 0
nnoremap gg mpgg
nnoremap G mpG
nnoremap / mp/
nnoremap ** *``cgn

nnoremap <silent> <Leader>w :silent w<CR> :echo "✨ " . strftime("%X")<CR>
nnoremap <silent> <Leader>x :bd!<CR>
nnoremap <silent> <BS> <C-^>
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>
nnoremap <silent> <Leader>wx :silent close<CR>
nnoremap <silent> <Leader>w- :silent sp<CR>
nnoremap <silent> <Leader>w/ :silent vsp<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <Leader>/ :Grep<Space>
nnoremap <Leader>* :Grep <C-R>=expand("<cword>")<CR><CR>

cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ?
      \ "<CR>/<C-r>/" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ?
      \ "<CR>?<C-r>/" : "<S-Tab>"

cnoremap <expr> <space> '/?' =~ getcmdtype() ? ".*" : "<space>"

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <silent> <Leader><space> :call FuzzFile()<CR>
nnoremap <silent> <Leader>fb :call FuzzBuf()<CR>

if has('nvim')
  " make leaving the term window less of PITA
  tnoremap <Esc> <C-\><C-n>
  tnoremap <M-[> <Esc>
endif

augroup Groupie
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \| exe "normal! g'\""
        \| endif
  autocmd BufWritePre * call fun#trim()
  autocmd VimResized * :wincmd =
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
  autocmd TermOpen * setlocal nonu nornu
  autocmd BufWritePost *vimrc\|*init.vim source $MYVIMRC
augroup END

augroup Qf
  autocmd!
  autocmd QuickFixCmdPost cgetexpr cwindow
  autocmd QuickFixCmdPost lgetexpr lwindow
  autocmd Filetype qf setlocal nonumber scrolloff=2
augroup END

augroup FileTyping
  autocmd!
  autocmd BufRead,BufNewFile jrnl*.txt,TODO,*.mdx setfiletype markdown
  autocmd BufRead,BufNewFile .{babel,eslint,,prettier}rc setfiletype json
  autocmd BufRead,BufNewFile .envrc setfiletype bash
augroup END

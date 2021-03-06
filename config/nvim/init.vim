if &compatible
  set nocompatible
endif

filetype plugin indent on
syntax on

set termguicolors
colorscheme cortado

set breakindent
set clipboard=unnamed
set completeopt=menuone,noselect,noinsert
set copyindent
set diffopt&
      \ diffopt+=vertical
      \ diffopt+=hiddenoff
set expandtab
set hidden
set foldmethod=expr
set foldnestmax=10
set foldexpr=nvim_treesitter#foldexpr()
set inccommand=nosplit
set ignorecase infercase smartcase
set noshowcmd
set noshowmode
set noswapfile
set path+=src/**,static/,public/,components/
set scrolloff=999
set shiftround
set shiftwidth=0
set shortmess+=c
set showbreak=↳\ \
set smartindent
set splitbelow splitright
set tabstop=2
set textwidth=80
set timeoutlen=300 ttimeoutlen=100
set undofile undodir=~/.undodir/
set updatetime=300
set whichwrap=b,h,l,s,<,>,[,],~
set wildcharm=<C-z>

let mapleader = "\<Space>"
let &softtabstop = &tabstop
let &fillchars='vert: ,fold:·'
let &listchars='tab:→\,space:⋅,trail:⣿,extends:→,precedes:←'

if executable('rg')
  set grepprg=rg\ --vimgrep
endif
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr fun#grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr fun#grep(<f-args>)

packadd cfilter
runtime macros/matchit.vim

nnoremap ; :
xnoremap ; :
nnoremap : ;
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

nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>x :bd!<CR>
nnoremap <silent> <BS> <C-^>
nnoremap <silent> <Tab> :bn<CR>
nnoremap <silent> <S-Tab> :bp<CR>

nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

tnoremap <Esc> <C-\><C-n>
tnoremap <M-[> <Esc>

nnoremap <Leader>/ :Grep<Space>
nnoremap <Leader>* :Grep <C-R>=expand("<cword>")<CR><CR>

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"
cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?"
      \ ? "<CR>/<C-r>/" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?"
      \ ? "<CR>?<C-r>/" : "<S-Tab>"

nmap <Leader><space> <Plug>(fuzz_e)
nmap <Leader>v       <Plug>(fuzz_vsp)

augroup general
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
  autocmd BufWritePost *vimrc\|*init.vim source $MYVIMRC
  autocmd BufWritePre * call fun#trim()
  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd TermOpen * setlocal nonu nornu
  autocmd VimResized * :wincmd =
augroup END

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost cgetexpr cwindow
  autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

augroup filetyping
  autocmd!
  autocmd BufRead,BufNewFile .envrc setfiletype bash
  autocmd BufRead,BufNewFile .{babel,eslint,,prettier}rc setfiletype json
  autocmd BufRead,BufNewFile jrnl*.txt,TODO,*.mdx setfiletype markdown
augroup END

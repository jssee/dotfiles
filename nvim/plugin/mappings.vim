let mapleader = "\<Space>"

:nmap ; :
inoremap jk <Esc>

" use display line instead of file line
nnoremap j gj
nnoremap k gk

" Plugin mappings
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>fs :w<CR>
nnoremap <Leader>qq :qa<CR>
nnoremap <Leader>w- :sp<CR>
nnoremap <Leader>w/ :vsp<CR>
nnoremap <Leader>wh <C-W>h
nnoremap <Leader>wj <C-W>j
nnoremap <Leader>wk <C-W>k
nnoremap <Leader>wl <C-W>l
xnoremap <Leader>b %

nnoremap <Leader>ft :Vaffle<CR>

nnoremap <Leader>pf :Leaderf file<CR>
nnoremap <Leader>bb :Leaderf buffer<CR>
nnoremap <Leader>rg :Leaderf rg<CR>

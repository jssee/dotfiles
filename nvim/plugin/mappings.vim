let mapleader = "\<Space>"

:nmap ; :
inoremap jk <Esc>
nnoremap j gj
nnoremap k gk

nnoremap <Leader>qq :qa<CR>
nnoremap <Leader>fs :w<CR>

" Buffers
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bd :bd<CR>
nnoremap <Leader>bp :bp<CR>

" Windows
nnoremap <Leader>wd :close<CR>
nnoremap <Leader>w- :sp<CR>
nnoremap <Leader>w/ :vsp<CR>
nnoremap <Leader>wh <C-W>h
nnoremap <Leader>wj <C-W>j
nnoremap <Leader>wk <C-W>k
nnoremap <Leader>wl <C-W>l

" Visual Mode
xnoremap <Leader>b %

nnoremap <Leader>ft :Vaffle<CR>

nnoremap <silent> <Leader>pf :call FzyCommand('fd --type f .', ':e ')<CR>


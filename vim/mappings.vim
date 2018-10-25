:nmap ; :
inoremap jk <Esc>

" use display line instead of file line
nnoremap j gj
nnoremap k gk

" move lines up and down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv

" Plugin mappings
imap <Leader>ee <Plug>(emmet-expand-abbr)
nmap <Leader>jj <Plug>SneakLabel_s
nmap <Leader>kk <Plug>Sneak_s
nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>bd :Sayonara!<CR>
nnoremap <Leader>bn :bn<CR>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>fs :w<CR>
nnoremap <Leader>ft :Vaffle<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader>qq :qa<CR>
nnoremap <Leader>sa :Ag<CR>
nnoremap <Leader>ss :Ag!<CR>
nnoremap <Leader>w- :sp<CR>
nnoremap <Leader>w/ :vsp<CR>
nnoremap <Leader>wd :Sayonara<CR>
nnoremap <Leader>wh <C-W>h
nnoremap <Leader>wj <C-W>j
nnoremap <Leader>wk <C-W>k
nnoremap <Leader>wl <C-W>l


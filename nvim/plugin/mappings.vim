let mapleader = "\<Space>"

:nmap ; :
inoremap jk <Esc>
nnoremap <silent> j gj
nnoremap <silent> k gk

nnoremap <silent> <Leader>qq :silent qa<CR>
nnoremap <silent> <Leader>fs :silent w<CR> :echo "✨"<CR>

" Buffers
nnoremap <silent> <Leader>bn :bn<CR>
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <silent> <Leader>bp :bp<CR>

" Windows
nnoremap <silent> <Leader>wd :silent close<CR>
nnoremap <silent> <Leader>w- :silent sp<CR>
nnoremap <silent> <Leader>w/ :silent vsp<CR>
nnoremap <silent> <Leader>wh :silent wincmd h<CR>
nnoremap <silent> <Leader>wj :silent wincmd j<CR>
nnoremap <silent> <Leader>wk :silent wincmd k<CR>
nnoremap <silent> <Leader>wl :silent wincmd l<CR>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR><CR>:cw<CR>

nmap <Leader>fr :%s//g<Left><Left>

" Visual Mode
xnoremap <Leader>b %

nnoremap <silent> <Leader>ft :Vaffle<CR>
nnoremap <silent> <Leader>pf :call fuzzy#start('fd --type f  .', ':e ')<CR>
nnoremap <silent> <Leader>sa :FlyGrep<CR>

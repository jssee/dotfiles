let mapleader = "\<Space>"

:nmap ; :
inoremap jk <Esc>
nnoremap <silent> j gj
nnoremap <silent> k gk

nnoremap <silent> <Leader>qq :silent qa<CR>
nnoremap <silent> <Leader>fs :silent w<CR> :echo "saved: " . strftime("%X")<CR>


" Buffers
nnoremap <silent> <Leader>bn :bn<CR>
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <silent> <Leader>bp :bp<CR>
nnoremap <silent> <Leader>bb :ls<CR>:b<Space>

" Windows
nnoremap <silent> <Leader>wd :silent close<CR>
nnoremap <silent> <Leader>w- :silent sp<CR>
nnoremap <silent> <Leader>w/ :silent vsp<CR>
nnoremap <silent> <Leader>wh :silent wincmd h<CR>
nnoremap <silent> <Leader>wj :silent wincmd j<CR>
nnoremap <silent> <Leader>wk :silent wincmd k<CR>
nnoremap <silent> <Leader>wl :silent wincmd l<CR>

" Terminal
nnoremap <silent> <Leader>tt :call Term_toggle(10)<cr>

" use tab and shift tab to indent and de-indent code
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
xnoremap <Tab>   >><Esc>gv
xnoremap <S-Tab> <<<Esc>gv

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR><CR>:cw<CR>

" easy find and replace
nnoremap <Leader>rw :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap <Leader>ra :%s/\<<C-r>=expand("<cword>")<CR>\>/

" Visual Mode
xnoremap <Leader>b %
xnoremap ; :

nnoremap <silent> <Leader>ft :Vaffle<CR>
nnoremap <silent> <Leader>pf :call fuzzy#start('fd --type f  .', ':e ')<CR>

" Ferret mappings
nmap <Leader>sa <Plug>(FerretAck)
nmap <Leader>sb :Back 
nmap <Leader>sc <Plug>(FerretAckWord)
nmap <Leader>sr <Plug>(FerretAcks)


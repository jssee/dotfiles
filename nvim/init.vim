" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfun

if has("autocmd")
  autocmd BufWritePre *.go,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Tone done popup menu
exec "hi! Pmenu guibg='#282828' guifg='#928374'"

" Resize splits when the window is resized
autocmd VimResized * :wincmd =

" Use rg for grep if you have it 
if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

if exists('&inccommand')
  set inccommand=split " (neovim) specific, live substitutin preview
endif

augroup filetypedetect
  autocmd!
  autocmd BufRead,BufNewFile jrnl*.txt,TODO,*.mdx setfiletype markdown
  autocmd BufRead,BufNewFile {Gemfile,Brewfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} setfiletype ruby
  autocmd BufRead,BufNewFile .{babel,eslint,stylelint,jshint,prettier}rc,.tern-* setfiletype json
  autocmd BufRead,BufNewFile .envrc setfiletype bash
augroup END


function! Term_toggle(height)
    let l:term_win = 0
    let l:term_buf = 0

    if win_gotoid(l:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . l:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let l:term_buf = bufnr("")
            setlocal nonumber norelativenumber
        endtry
        startinsert!
        let l:term_win = win_getid()
    endif
endfunction


function! s:ListFilesCommand() abort
    " Return a shell command suitable for listing the files in the
    " current directory, based on whether the current directory is a Git
    " repository and if the preferred find tool is installed.
    "
    " Returns
    " -------
    " String
    "     Shell command to list files in the current directory.
    "     use fd for default 
    return 'fd --type f --color always .'
endfunction

function! s:ListBuffersCommand() abort
    " Return a shell command which will list current listed buffers.
    "
    " Returns
    " -------
    " String
    "     Shell command to list current listed buffers.
    let l:bufnrs = range(1, bufnr('$'))

    " Filter out buffers which do not exist or are not listed, and the
    " current buffer.
    let l:bufnrs = filter(l:bufnrs, 'buflisted(v:val) && v:val != bufnr("%")')

    let l:bufnames = map(l:bufnrs, 'bufname(v:val)')
    return 'echo "' . join(l:bufnames, "\n"). '"'
endfunction

function! s:PickerTermopen(list_command, vim_command, callback) abort
    " Open a Neovim terminal emulator buffer in a new window using termopen,
    " execute list_command piping its output to the fuzzy selector, and call
    " callback.on_select with the item selected by the user as the first
    " argument.
    "
    " Parameters
    " ----------
    " list_command : String
    "     Shell command to generate list user will choose from.
    " vim_command : String
    "     Readable representation of the Vim command which will be
    "     invoked against the user's selection, for display in the
    "     statusline.
    " callback.on_select : String -> Void
    "     Function executed with the item selected by the user as the
    "     first argument.
    let l:callback = {
                \ 'window_id': win_getid(),
                \ 'filename': tempname(),
                \ 'callback': a:callback
                \ }

    function! l:callback.on_exit(job_id, data, event) abort
        close!
        call win_gotoid(l:self.window_id)
        if filereadable(l:self.filename)
            try
                call l:self.callback.on_select(readfile(l:self.filename)[0])
            catch /E684/
            endtry
            call delete(l:self.filename)
        endif
    endfunction

    botright 10 new
    let l:term_command = l:list_command . ' | fzy > ' . l:callback.filename
    let b:picker_statusline = '[command: ' . a:vim_command .
                \ ', directory: ' . getcwd() . ']'
    
    silent call termopen(l:term_command, l:callback)
    setlocal nonumber norelativenumber statusline=%{b:picker_statusline}
    startinsert
endfunction

function! s:Picker(list_command, vim_command, callback) abort
    " Invoke callback.on_select on the line of output of list_command
    " selected by the user, using PickerTermopen() in Neovim and
    " PickerSystemlist() otherwise.
    "
    " Parameters
    " ----------
    " list_command : String
    "     Shell command to generate list user will choose from.
    " vim_command : String
    "     Readable representation of the Vim command which will be
    "     invoked against the user's selection, for display in the
    "     statusline.
    " callback.on_select : String -> Void
    "     Function executed with the item selected by the user as the
    "     first argument.
    if exists('*termopen')
        call s:PickerTermopen(a:list_command, a:vim_command, a:callback)
    else
        return 
    endif
endfunction

function! s:PickFile(list_command, vim_command) abort
    " Create a callback that executes a Vim command against the user's
    " selection escaped for use as a filename, and invoke Picker() with
    " that callback.
    "
    " Parameters
    " ----------
    " list_command : String
    "     Shell command to generate list user will choose from.
    " vim_command : String
    "     Readable representation of the Vim command which will be
    "     invoked against the user's selection, for display in the
    "     statusline.
    let l:callback = {'vim_command': a:vim_command}

    function! l:callback.on_select(selection) abort
        exec l:self.vim_command fnameescape(a:selection)
    endfunction

    call s:Picker(a:list_command, a:vim_command, l:callback)
endfunction

function! picker#Buffer() abort
    " Run fuzzy selector to choose a buffer and call buffer on it.
    call s:PickFile(s:ListBuffersCommand(), ':buffer ')
endfunction


" function! FzyCommand(choice_command, vim_command) abort
"   let l:callback = {
"               \ 'window_id': win_getid(),
"               \ 'filename': tempname(),
"               \ 'vim_command':  a:vim_command
"               \ }

"   function! l:callback.on_exit(job_id, data, event) abort
"     close!
"     call win_gotoid(self.window_id)
"     if filereadable(self.filename)
"       try
"         let l:selected_filename = readfile(self.filename)[0]
"         exec self.vim_command . l:selected_filename
"       catch /E684/
"       endtry
"     endif
"     call delete(self.filename)
"   endfunction

"   botright 10 new
"   let l:term_command = a:choice_command . ' | fzy > ' .  l:callback.filename
"   silent call termopen(l:term_command, l:callback)
"   setlocal nonumber norelativenumber
"   startinsert
" endfunction


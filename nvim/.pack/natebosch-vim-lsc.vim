let g:lsc_auto_map = v:false
let g:lsc_enable_autocomplete = v:true
let g:lsc_enable_diagnostics = v:false

autocmd BufEnter *.js,*.ts,*.tsx,*.jsx :call lsc#server#enable()
autocmd CompleteDone * silent! pclose

let g:lsc_server_commands = {
      \'typescript': { 'command': 'javascript-typescript-stdio', 'log_level': 'Error' },
      \'javascript': { 'command': 'javascript-typescript-stdio', 'log_level': 'Error' },
      \}

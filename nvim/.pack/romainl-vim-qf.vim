" Ack.vim-inspired mappings available only in location/quickfix windows:
"     s - open entry in a new horizontal window
"     v - open entry in a new vertical window
"     t - open entry in a new tab
"     o - open entry and come back
"     o - open entry and close the location/quickfix window
"     p - open entry in a preview window
let g:qf_mapping_ack_style = 1

" Toggle the current window's location window or the current location window and
" do not move if toggled open.
nmap <Up> <Plug>(qf_qf_toggle_stay)

" Jump to and from location/quickfix windows.
nmap <Leader>wq <Plug>(qf_qf_switch)

" Go up and down the quickfix list and wrap around.
nmap <Left> <Plug>(qf_qf_previous)
nmap <Right>  <Plug>(qf_qf_next)

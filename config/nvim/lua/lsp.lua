vim.cmd('packadd nvim-lsp')
local nvim_lsp = require'nvim_lsp'

vim.fn.sign_define('LspDiagnosticsErrorSign', {text='✖ ' or 'E', texthl='LspDiagnosticsError', linehl='', numhl=''})
vim.fn.sign_define('LspDiagnosticsWarningSign', {text='⚠' or 'W', texthl='LspDiagnosticsWarning', linehl='', numhl=''})
vim.fn.sign_define('LspDiagnosticsInformationSign', {text='ℹ' or 'I', texthl='LspDiagnosticsInformation', linehl='', numhl=''})
vim.fn.sign_define('LspDiagnosticsHintSign', {text='➤' or 'H', texthl='LspDiagnosticsHint', linehl='', numhl=''})

vim.api.nvim_command('highlight! link LspDiagnosticsError DiffDelete')
vim.api.nvim_command('highlight! link LspDiagnosticsWarning DiffChange')
vim.api.nvim_command('highlight! link LspDiagnosticsHint Comment')

local on_attach = function(client, bufnr)
  -- set the omnifunction to use the lsp
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- and set up some mappings
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ld', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gq', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

local servers = {
  elmls = {
    on_attach = on_attach
  },
  tsserver = {
    on_attach = on_attach
 }
}

for s, c in pairs(servers) do
  nvim_lsp[s].setup(c)
end

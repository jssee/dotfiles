local U = require'utils'

local has_diagnostic, diagnostic = pcall(require, 'diagnostic')
local has_completion, completion = pcall(require, 'completion')
local has_lsp, lsp = pcall(require, 'nvim_lsp')

if not has_lsp then return end

local on_attach = function(client)

  if has_diagnostic then
    diagnostic.on_attach(client)
  end

  if has_completion then
    completion.on_attach(client)
  end

  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local map_opts = { noremap=true, silent=true }
  U.bmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', map_opts)
  U.bmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', map_opts)
  U.bmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', map_opts)
  U.bmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', map_opts)
  U.bmap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', map_opts)
  U.bmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', map_opts)
end

local servers = {
  { name = 'cssls' },
  { name = 'elmls' },
  {
    name = 'tsserver',
    -- See https://github.com/neovim/nvim-lsp/issues/237
    root_dir = lsp.util.root_pattern("tsconfig.json", ".git")
  },
  {
    name = 'sumneko_lua', config = {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ';'),
          },
          completion = {
            keywordSnippet = "Disable",
          },
          diagnostics = {
            enable = true,
            globals = {"vim"},
          },
        }
      }
    }
  }
}

for _, server in ipairs(servers) do
  local server_disabled = (server.disabled ~= nil and server.disabled) or false

  if not server_disabled then
    if server.config then
      server.config.on_attach = on_attach
    else
      server.config = {
        on_attach = on_attach
      }
    end
  end

  lsp[server.name].setup(server.config)
end

local has_lsp, lsp = pcall(require, "lspconfig")
local has_completion, completion = pcall(require, "completion")

local U = require "utils"

if not has_lsp then
    return
end

local on_attach = function(client)
    vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")

    if has_completion then
        completion.on_attach(client)
    end

    local map_opts = {noremap = true, silent = true}
    U.bmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", map_opts)
    U.bmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", map_opts)
    U.bmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", map_opts)
    U.bmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", map_opts)
    U.bmap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", map_opts)
    U.bmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", map_opts)

    vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
        vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics,
            {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    prefix = "✦"
                }
            }
        )(...)
    end

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[augroup lsp_fmt]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
        vim.api.nvim_command [[augroup END]]
    end

    vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
        if err ~= nil or result == nil then
            return
        end
        if not vim.api.nvim_buf_get_option(bufnr, "modified") then
            local view = vim.fn.winsaveview()
            vim.lsp.util.apply_text_edits(result, bufnr)
            vim.fn.winrestview(view)
            if bufnr == vim.api.nvim_get_current_buf() then
                vim.cmd("noautocmd :update")
            end
        end
    end
end

local fixers = {
    luafmt = {
        formatCommand = [[luafmt --stdin]],
        formatStdin = true
    },
    prettier = {
        formatCommad = [[./node_modules/.bin/prettier]]
    },
    eslint = {
      lintCommand = [[./node_modules/.bin/eslint -f unix --stdin]],
      lintIgnoreExitCode = true,
      lintStdin = true
    }
}

local servers = {
    {name = "cssls"},
    {name = "elmls"},
    {name = "tsserver"},
    {
        name = "efm",
        config = {
            init_options = {documentFormatting = true},
            settings = {
                rootMarkers = {".git/", "package.json"},
                languages = {
                    lua = {fixers.luafmt},
                    typescript = {fixers.pretter, fixers.eslint},
                    typescriptreact = {fixers.prettier, fixers.eslint},
                    javascript = {fixers.prettier, fixers.eslint},
                    javascriptreact = {fixers.prettier, fixers.eslint},
                    css = {fixers.prettier}
                }
            }
        }
    },
    {
        name = "sumneko_lua",
        config = {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        path = vim.split(package.path, ";")
                    },
                    completion = {
                        keywordSnippet = "Disable"
                    },
                    diagnostics = {
                        enable = true,
                        globals = {"vim"}
                    }
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

require'nvim-treesitter.configs'.setup {
  ensure_install = {
    "css",
    "elm",
    "html",
    "javascript",
    "lua",
    "tsx",
    "typescript",
  },
  highlight = {
    enable = true,
  },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      }
    }
  }
}


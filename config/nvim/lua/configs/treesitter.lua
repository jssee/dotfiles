local has_config, config = pcall(require, 'nvim-treesitter.configs')

if not has_config then return end

config.setup {
  ensure_installed = 'all',
  highlight = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {                      -- mappings for incremental selection (visual mappings)
      init_selection = "<cr>",       -- maps in normal mode to init the node/scope selection
      node_incremental = "<Tab>",    -- increment to the upper named parent
      node_decremental = "<S-Tab>",  -- decrement to the previous node
    }
  }
}

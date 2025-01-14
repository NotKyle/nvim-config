-- lua/plugins/editor.lua
return {
  {
    'jeangiraldoo/codedocs.nvim',
  },
  {
    'nvim-telescope/telescope.nvim',
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = { prompt_position = 'top' },
        sorting_strategy = 'ascending',
        winblend = 0,
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function() end,
  },
  {
    'romgrk/barbar.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function() end,
  },
  {
    'nvimdev/guard.nvim',
    -- lazy load by ft
    ft = { 'lua', 'c', 'markdown' },
    -- Builtin configuration, optional
    dependencies = {
      'nvimdev/guard-collection',
    },
  },
}

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      -- I swapped these 2
      { "<leader>e", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      { "<leader>E", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
    },
    -- Show .env file, but not .git
    config = function()
      require("neotree").setup({
        disable_netrw = true,
        auto_open = true,
        open_on_setup = true,
        update_to_buf_dir = {
          enable = true,
          auto_open = true,
        },
        view = {
          width = 30,
          side = "left",
          auto_resize = true,
        },
        filters = {
          dotfiles = false,
          gitignore = true,
          custom = {},
        },
      })
    end,
  },
}

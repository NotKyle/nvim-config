print("Loading must-use plugins")

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
  },

  -- {
  -- "jose-elias-alvarez/null-ls.nvim",
  -- requires = { "nvim-lua/plenary.nvim" }, -- "neovim/nvim-lspconfig" },
  -- config = function()
  --   require("config.null-ls")
  --   require("lspconfig")["null-ls"].setup({})
  -- end,
  -- },
}

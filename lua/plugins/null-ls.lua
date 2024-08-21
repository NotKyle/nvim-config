return {
  "jose-elias-alvarez/null-ls.nvim",
  requires = { "nvim-lua/plenary.nvim" }, -- "neovim/nvim-lspconfig" },
  config = function()
    require("config.null-ls")
    require("lspconfig")["null-ls"].setup({})
  end,
}

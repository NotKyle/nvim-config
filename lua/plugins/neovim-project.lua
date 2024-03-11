return {
  "coffebar/neovim-project",
  config = function()
    require("neovim-project").setup({
      projects = {
        "~/Desktop/Sites/*",
        "~/.config/nvim",
      },
      vim.keymap.set("n", ";", ":Telescope neovim-project discover<CR>", {}),
    })
  end,
  dependencies = {
    { "Shatur/neovim-session-manager" },
  },
}

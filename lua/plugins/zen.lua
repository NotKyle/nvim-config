return {
  "folke/zen-mode.nvim",
  event = "VeryLazy",
  opts = {
    window = {
      width = 120,
      options = {
        relativenumber = true,
        number = true,
      },
    },
    plugins = {
      options = {
        laststatus = 3,
      },
    },
  },
}

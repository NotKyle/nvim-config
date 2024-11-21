-- lua/plugins/misc.lua
return {
  {
    "echasnovski/mini.nvim",
    version = "*",
  },
  {
    "tpope/vim-repeat",
  },
  {
    "ThePrimeagen/harpoon",
    lazy = false,
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "ptdewey/pendulum-nvim",
    config = function()
      require("pendulum").setup({
        log_file = vim.fn.expand("$HOME/Documents/pendulum.csv"),
        timeout_len = 300,
        timer_len = 60,
        gen_reports = true,
        top_n = 100,
      })
    end,
  },
  {
    "kylechui/nvim-surround", -- surround objects
    config = function()
      require("nvim-surround").setup({})
    end,
  },
}

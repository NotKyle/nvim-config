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
      local current_month = os.date("%Y-%m")
      require("pendulum").setup({
        log_file = vim.fn.expand("$HOME/Documents/pendulum/" .. current_month .. ".csv"),
        timeout_len = 300, -- 5 minutes
        timer_len = 60, -- 1 minute
        gen_reports = true, -- Enable report generation (requires Go)
        top_n = 10, -- Include top 10 entries in the report
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

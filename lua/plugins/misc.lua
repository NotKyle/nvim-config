-- lua/plugins/misc.lua
return {
  {
    "tpope/vim-obsession",
    cmd = "Obsession",
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },
  {
    "joshuadanpeterson/typewriter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("typewriter").setup()
    end,
    opts = {},
  },
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
  {
    "wellle/targets.vim", -- adds more targets like [ or ,
  },
  {
    "aserowy/tmux.nvim",
    config = function()
      return require("tmux").setup()
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
  {
    {
      "ChuufMaster/buffer-vacuum",
      opts = {},
    },
  },
  {
    "psych3r/vim-remembers",
  },
}

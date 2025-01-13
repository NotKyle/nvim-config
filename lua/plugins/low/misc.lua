-- lua/plugins/misc.lua
return {
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
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
      local log_path = vim.fn.expand("/Users/kylerussell/Documents/pendulum")
      require("pendulum").setup({
        log_file = log_path .. "/" .. current_month .. ".log",
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
  {
    "Dan7h3x/LazyDo",
    branch = "main",
    event = "VeryLazy",
    opts = {},
  },
  {
    "xzbdmw/colorful-menu.nvim",
    config = function()
      require("colorful-menu").setup({})
    end,
  },
  {
    "miversen33/sunglasses.nvim",
    -- event = "UIEnter",
    config = function()
      require("sunglasses").setup({})
    end,
    enabled = false, -- Causes nvim to hang on startup for some reason
  },
  {
    "levouh/tint.nvim",
    config = function()
      require("tint").setup({
        tint = -25, -- Darken colors, use a positive value to brighten
        saturation = 0.2, -- Saturation to preserve
        transforms = require("tint").transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
        tint_background_colors = true, -- Tint background portions of highlight groups
        highlight_ignore_patterns = { "WinSeparator", "Status.*" }, -- Highlight group patterns to ignore, see `string.find`
        window_ignore_function = function(winid)
          local bufid = vim.api.nvim_win_get_buf(winid)
          local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
          local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

          -- Do not tint `terminal` or floating windows, tint everything else
          return buftype == "terminal" or floating
        end,
      })
    end,
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = { -- Default  Range
      stiffness = 0.8, -- 0.6      [0, 1]
      trailing_stiffness = 0.5, -- 0.3      [0, 1]
      distance_stop_animating = 0.5, -- 0.1      > 0
      hide_target_hack = false, -- true     boolean
    },
  },
  {
    "nvzone/volt",
    lazy = true,
  },
  {
    "nvzone/menu",
    lazy = true,
  },
  {
    "atiladefreitas/tinyunit",
    config = function()
      require("tinyunit").setup()
    end,
  },
  {
    "atiladefreitas/lazyclip",
    config = function()
      require("lazyclip").setup()
    end,
    keys = {
      { "Cw", "Open Clipboard Manager" },
    },
    event = { "TextYankPost" },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "mxsdev/nvim-dap-vscode-js",
  },
  {
    "rcarriga/nvim-dap-ui",
  },
  {
    "vuki656/package-info.nvim",
  },
}

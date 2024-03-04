return {
  {
    "f-person/auto-dark-mode.nvim",
    config = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option("background", "dark")
        -- vim.cmd("colorscheme tokyonight-storm")
        vim.cmd("colorscheme nord")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option("background", "light")
        vim.cmd("colorscheme tokyonight-day")
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      -- colorScheme = "morning",
      colorScheme = "tokyonight-day",
    },
  },

  -- {
  -- "williamboman/mason.nvim",
  -- "williamboman/mason-lspconfig.nvim",
  -- "neovim/nvim-lspconfig",
  -- },

  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = false,
      projects = {
        ["/Users/kylerussell/Desktop/Sites/"] = {
          ["*.lua"] = { "nvim" },
          ["*.go"] = { "go" },
          ["*.py"] = { "python" },
          ["*.php"] = { "php" },
        },
      },
    }
  },
}

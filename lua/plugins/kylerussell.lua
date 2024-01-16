return {
	{
		"LazyVim/LazyVim",
		opts = {
	--		colorScheme = "morning",
      colorScheme = "default",
		},
	},

  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },

  {
    "pocco81/auto-save.nvim",
    opts = {
      enabled = true,
    }
  },

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

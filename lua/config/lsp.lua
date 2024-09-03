-- LSP-related configuration
local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
  -- Enable LSP completion and signature
  require("lsp_signature").on_attach({
    bind = true,
    floating_window = true,
    handler_opts = { border = "rounded" },
  })

  -- Document highlighting
  if client.server_capabilities.documentHighlightProvider then
    local highlight_group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })

    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = highlight_group })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = highlight_group,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = highlight_group,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

return {
  -- Plugin Imports
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.ui.mini-animate" },
  { import = "lazyvim.plugins.extras.ui.mini-diagnostics" },
  { import = "lazyvim.plugins.extras.ui.mini-lsp" },
  { import = "lazyvim.plugins.extras.ui.mini-lsp-diagnostics" },
  { import = "lazyvim.plugins.extras.ui.mini-lsp-highlight" },
  { import = "lazyvim.plugins.extras.ui.mini-lsp-symbols" },
  { import = "lazyvim.plugins.extras.ui.mini-lsp-trouble" },
  { import = "lazyvim.plugins.extras.ui.mini-lsp-ui" },

  -- LSP icons
  { "onsails/lspkind-nvim" },

  -- Treesitter with extended parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "php",
        "css",
        "scss",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- Adding specific parsers for TypeScript and TSX
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "tsx", "typescript" })
    end,
  },

  -- LSP configuration with pyright and tsserver
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {}, -- Python support
      },
    },
  },

  -- Setting up TypeScript LSP with typescript.nvim
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- Key mappings for organizing imports and renaming files
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    opts = {
      servers = {
        tsserver = {}, -- TypeScript support
      },
    },
  },
  {
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup({
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        })
      end,
    },

    {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup()
      end,
    },

    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      config = function()
        require("mason-tool-installer").setup({
          ensure_installed = {
            "glow",
            "lua-language-server",
            "marksman",
            "prettier",
            "python-lsp-server",
            "rust-analyzer",
            "shellcheck",
            "shellharden",
            "stylua",
            "zls",
            -- "phpactor",
            "intelephense",
            "php-cs-fixer",
            "phpstan",
            "phpmd",
            "phpunit",
          },
        })
      end,
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}

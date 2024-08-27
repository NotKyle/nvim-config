-- LSP-related configuration
local nvim_lsp = require("lspconfig")

-- local null_ls = require("null-ls")
-- local utils = require("null-ls.utils")

-- null_ls.setup({
--   root_dir = utils.root_pattern("composer.json", "package.json", "Makefile", ".git"), -- Add composer
--   diagnostics_format = "#{m} (#{c}) [#{s}]", -- Makes PHPCS errors more readeable
--   sources = {
--     null_ls.builtins.completion.spell, -- You still need to execute `:set spell`
--     null_ls.builtins.diagnostics.eslint, -- Add eslint to js projects
--     null_ls.builtins.diagnostics.phpcs.with({ -- Change how the php linting will work
--       prefer_local = "vendor/bin",
--     }),
--     null_ls.builtins.formatting.stylua, -- You need to install stylua first: `brew install stylua`
--     null_ls.builtins.formatting.phpcbf.with({ -- Use the local installation first
--       prefer_local = "vendor/bin",
--     }),
--   },
-- })

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
            "phpactor",
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

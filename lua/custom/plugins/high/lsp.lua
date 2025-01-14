local use_lsp = true

if not use_lsp then
  return {}
end

return {
  -- Plugin Imports
  -- { import = 'lazyvim.plugins.extras.lang.typescript' },
  -- { import = 'lazyvim.plugins.extras.lang.json' },

  -- LSP icons
  { 'onsails/lspkind-nvim' },

  -- Treesitter with extended parsers
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'bash',
        'html',
        'php',
        'css',
        'scss',
        'javascript',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'tsx',
        'typescript',
        'vim',
        'yaml',
      },
    },
  },

  -- Adding specific parsers for TypeScript and TSX
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'tsx', 'typescript' })
    end,
  },
  -- Mason
  {
    {
      'williamboman/mason.nvim',
      config = function()
        require('mason').setup {
          ui = {
            icons = {
              package_installed = '✓',
              package_pending = '➜',
              package_uninstalled = '✗',
            },
          },
        }
      end,
    },

    {
      'williamboman/mason-lspconfig.nvim',
      config = function()
        require('mason-lspconfig').setup()
      end,
    },

    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      config = function()
        require('mason-tool-installer').setup {
          ensure_installed = {
            'glow',
            'lua-language-server',
            'marksman',
            'prettier',
            'python-lsp-server',
            'rust-analyzer',
            'stylua',
            'zls',
            'phpactor',
            'php-cs-fixer',
            -- "intelephense",
            -- "phpstan",
            -- "phpmd",
            -- "phpunit",
          },
        }
      end,
    },
  },
  {
    -- TypeScript and JSON support
    {
      'neovim/nvim-lspconfig',
      config = function()
        require('lspconfig').ts_ls.setup {}
        require('lspconfig').jsonls.setup {}
      end,
    },

    -- LSP icons
    { 'onsails/lspkind-nvim' },
    -- (rest of your configuration remains)
  },

  -- LSP Saga
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {}
    end,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'jose-elias-alvarez/typescript.nvim',
      init = function()
        -- require('lazyvim.util').lsp.on_attach(function(_, buffer)
        --   -- stylua: ignore
        --   vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
        --   vim.keymap.set('n', '<leader>cR', 'TypescriptRenameFile', { desc = 'Rename File', buffer = buffer })
        -- end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require('typescript').setup { server = opts }
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
}

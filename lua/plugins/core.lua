return {
  {
    'neovim/nvim-lspconfig',
  },
  -- Mason & LSP management
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'mason.nvim' },
    config = true,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = {
          'intelephense',
          'html-lsp',
          'css-lsp',
          'lua-language-server',
          'stylua',
          'stylua', -- Lua
          'prettier', -- JS, HTML, CSS
          'php-cs-fixer', -- PHP
          'shfmt',
        },
        auto_update = true,
      }
    end,
  },

  -- Noice (UI)
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {}
    end,
  },

  -- CMP (completion)
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require 'core.cmp'
    end,
  },

  -- Treesitter & extras
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'lua',
          'php',
          'html',
          'css',
          'javascript',
          'json',
        },
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
      }
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-context' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },

  -- UI
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  { 'famiu/snacks.nvim', config = true },

  -- Telescope (no keymaps)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Productivity
  { 'folke/todo-comments.nvim', config = true },
  { 'mbbill/undotree' },
  { 'folke/trouble.nvim', config = true },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = true,
  },

  -- Yazi integration
  {
    'mikavilpas/yazi.nvim',
    cmd = { 'Yazi', 'YaziHere' },
    config = true,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'frappe', -- latte, frappe, macchiato, mocha
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
          mini = true,
          noice = true,
          which_key = true,
          mason = true,
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}

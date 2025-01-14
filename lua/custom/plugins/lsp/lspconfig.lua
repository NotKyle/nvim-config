return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('lspconfig').ts_ls.setup {}
      require('lspconfig').jsonls.setup {}
      require('lspconfig').phpactor.setup {}
    end,
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
        -- ts_ls will be automatically installed with mason and loaded with lspconfig
        ts_ls = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        ts_ls = function(_, opts)
          require('typescript').setup { server = opts }
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
}

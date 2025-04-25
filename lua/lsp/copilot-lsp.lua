return function(lspconfig)
  local enabled = true

  if enabled then
    local util = require 'lspconfig.util'

    lspconfig.copilot = {
      cmd = { 'copilot-language-server', '--stdio' },
      filetypes = {
        'javascript',
        'typescript',
        'lua',
        -- 'php',
        'python',
        'go',
        'rust',
        'scss',
        'css',
        'html',
        'markdown',
        'json',
        'yaml',
        'toml',
        'bash',
        'dockerfile',
      },
      root_dir = util.root_pattern('.git', '.'),
      init_options = {
        editorInfo = {
          name = 'neovim',
          version = vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch,
        },
        editorPluginInfo = {
          name = 'GitHub Copilot LSP for Neovim',
          version = '0.0.1',
        },
      },
      settings = {
        nextEditSuggestions = {
          enabled = true,
        },
      },
    }

    -- Load NES virtual text hint (💡) after LSP is set up
    vim.schedule(function()
      if vim.g.copilot_nes_enabled then
        require('core.nes').setup()
      end
    end)
  end
end

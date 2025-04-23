return function(lspconfig)
  local util = require 'lspconfig.util'

  lspconfig.copilot = {
    cmd = { 'copilot-language-server', '--stdio' }, -- Update if needed
    filetypes = { 'javascript', 'typescript', 'lua', 'php', 'python', 'go', 'rust' }, -- extend as needed
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
end

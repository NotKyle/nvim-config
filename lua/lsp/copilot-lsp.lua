local util = vim.lsp.util
return {
  cmd = { 'copilot-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'typescript',
    'lua',
    'php',
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
  -- root_dir = util.root_pattern('.git', '.'),
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

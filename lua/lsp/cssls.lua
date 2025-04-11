return function(lspconfig)
  lspconfig.cssls.setup {
    cmd = { 'vscode-css-language-server', '--stdio' }, -- ✅ correct binary
    filetypes = { 'css', 'scss', 'less' },
    root_dir = require('lspconfig.util').root_pattern('package.json', '.git'),
    settings = {
      css = { validate = true },
      scss = { validate = true },
      less = { validate = true },
    },
  }
end

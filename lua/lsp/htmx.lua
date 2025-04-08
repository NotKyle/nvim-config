return function(lspconfig)
  lspconfig.htmx.setup {
    cmd = { 'htmx-lsp' },
    filetypes = { 'html', 'htmx', 'php' }, -- Include filetypes where HTMX is used
    root_dir = require('lspconfig.util').root_pattern('.git', 'package.json', 'webpack.config.js', 'Dockerfile'), -- Specify the root dir based on your project setup
  }
end

return function(lspconfig)
  lspconfig.eslint.setup {
    settings = {
      workingDirectory = { mode = 'location' }, -- or "auto"
    },
    root_dir = require('lspconfig.util').root_pattern('eslint.config.js', '.git'),
  }
end

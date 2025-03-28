return function(lspconfig)
  return function(lspconfig)
  lspconfig.intelephense.setup({
        cmd = { 'intelephense', '--stdio' },
        filetypes = { 'php' },
        root_dir = require('lspconfig.util').root_pattern('composer.json', '.git', 'index.php'),
        -- capabilities = require('cmp_nvim_lsp').default_capabilities(), -- Ensure autocompletion works
  })
  end
end
return function(lspconfig)
  lspconfig.phpactor.setup {
    cmd = { 'phpactor', 'language-server' },
    filetypes = { 'php' },
    root_dir = lspconfig.util.root_pattern('composer.json', '.git', '.phpactor.yml'),
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
    init_options = {
      language_server_phpstan = {
        enabled = false,
      },
      language_server_psalm = {
        enabled = false,
      },
    },
  }
end

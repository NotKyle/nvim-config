local enabled = false

if enabled then
  return function(lspconfig)
    lspconfig.phpactor.setup {
      cmd = { 'phpactor', 'language-server' },
      filetypes = { 'php' },
      root_dir = lspconfig.util.root_pattern('composer.json', '.git', '.phpactor.yml'),
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
      settings = {
        language_server_phpstan = {
          enabled = false,
        },
      },
    }
  end
else
  return function(lspconfig) end
end

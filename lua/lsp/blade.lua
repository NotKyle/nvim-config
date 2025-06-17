return function(lspconfig)
  -- Attach HTML LSP
  lspconfig.html.setup {
    filetypes = { 'html', 'blade' },
    init_options = {
      configurationSection = { 'html', 'css', 'javascript' },
      embeddedLanguages = {
        css = true,
        javascript = true,
      },
    },
  }

  -- Attach Emmet LSP
  lspconfig.emmet_language_server.setup {
    filetypes = { 'html', 'blade', 'css', 'scss', 'javascript', 'typescriptreact' },
    init_options = {
      html = {
        options = {
          ['bem.enabled'] = true,
        },
      },
    },
  }
end

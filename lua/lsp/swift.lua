return function(lspconfig)
  lspconfig.sourcekit.setup {
    cmd = { 'sourcekit-lsp' }, -- ✅ correct binary for Swift
    filetypes = { 'swift' },
    root_dir = require('lspconfig.util').root_pattern('Package.swift', '.git'),
    settings = {
      -- SourceKit-LSP has limited settings; you typically configure things via Xcode project or Package.swift
    },
  }
end

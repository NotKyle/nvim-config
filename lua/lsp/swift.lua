return {
  cmd = { 'sourcekit-lsp' }, -- ✅ correct binary for Swift
  filetypes = { 'swift' },
  -- root_dir = lspconfig.util.root_pattern('Package.swift', 'project.xcworkspace', '.git'),
  root_dir = vim.fn.getcwd(),
  settings = {
    -- SourceKit-LSP has limited settings; you typically configure things via Xcode project or Package.swift
  },
}

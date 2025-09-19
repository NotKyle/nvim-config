return {
  cmd = { 'vscode-css-language-server', '--stdio' }, -- ✅ correct binary
  filetypes = { 'css', 'scss', 'less' },
  -- root_dir = lspconfig.util.root_pattern('package.json', 'yarn.lock', 'node_modules', '.git'),
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}

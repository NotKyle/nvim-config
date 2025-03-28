return function(lspconfig)
  return function(lspconfig)
  lspconfig.scss.setup({
    cmd = { 'sass-lint', '--format', 'JSON', '--stdin-filename', '$FILENAME' },
    stdin = true,
    args = { '--stdin-filename', '$FILENAME' },
  })
  end
end
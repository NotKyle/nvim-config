return {
  cmd = { 'blade-language-server', '--stdio' },
  filetypes = { 'blade' },
  root_dir = vim.fn.getcwd(),
  -- root_dir = function(fname)
  --   return require('lspconfig.util').find_git_ancestor(fname) or vim.loop.os.homedir()
  -- end,
  settings = {},
}

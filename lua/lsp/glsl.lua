-- in your LSP config (e.g. inside LazyVim's lspconfig setup)
return {
  cmd = { 'glsl_analyzer' },
  filetypes = { 'glsl', 'vert', 'frag' },
  -- root_dir = util.root_pattern('.git', '.'),
  root_dir = vim.fn.getcwd(),
}

return {
  settings = {
    workingDirectory = { mode = 'location' }, -- or "auto"
  },
  -- root_dir = lspconfig.util.root_pattern('.eslintrc', '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.yaml', '.eslintrc.yml', '.eslintrc.json', 'package.json'),
  root_dir = vim.fn.getcwd(),
}

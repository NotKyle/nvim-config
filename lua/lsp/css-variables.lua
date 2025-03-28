return function(lspconfig)
  return function(lspconfig)
    local util = require("lspconfig.util")
  
    lspconfig.cssmodules_ls.setup({
    cmd = { 'vscode-css-languageserver', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
      root_dir = util.root_pattern("tailwind.config.js", ".git"),
    })
  end
end
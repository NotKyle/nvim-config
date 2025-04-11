return function(lspconfig)
  lspconfig.html.setup {
    cmd = { 'vscode-html-language-server ', '--stdio' },
    filetypes = { 'html', 'php' },
    root_dir = require('lspconfig.util').root_pattern('.git', 'Cargo.toml', 'go.mod', 'build/compile_commands.json'),
  }
end


return function(lspconfig)
  return function(lspconfig)
    lspconfig.tailwind.setup {
      cmd = { 'tailwindcss-language-server', '--stdio' },
      filetypes = { 'html', 'css', 'javascript', 'typescript', 'php' },
      root_dir = require('lspconfig.util').root_pattern(
        'tailwind.config.js',
        'tailwind.config.cjs',
        'tailwind.config.ts',
        'tailwind.config.tsx',
        'tailwind.config.jsx',
        'tailwind.config.json',
        '.git'
      ),
    }
  end
end

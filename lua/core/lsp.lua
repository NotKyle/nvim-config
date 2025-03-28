-- Setup Mason
require('mason').setup()

-- Setup Mason LSP extension
require('mason-lspconfig').setup {
  ensure_installed = {
    'intelephense',
    'html',
    'cssls',
    'lua_ls',
    'tailwindcss',
  },
  automatic_installation = true,
}

-- Setup tools (like stylua)
require('mason-tool-installer').setup {
  ensure_installed = {
    'intelephense',
    'html-lsp',
    'css-lsp',
    'lua-language-server',
    'stylua',
  },
  auto_update = true,
  run_on_start = true,
}

local lspconfig = require 'lspconfig'

-- Automatically set up all installed servers
require('mason-lspconfig').setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {}
  end,
}

-- Optionally load custom overrides from lua/lsp/*.lua
local lsp_dir = vim.fn.stdpath 'config' .. '/lua/lsp'
for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
  if file:match '%.lua$' then -- ✅ only load .lua files
    local name = file:gsub('%.lua$', '')
    local ok, mod = pcall(require, 'lsp.' .. name)
    if ok and type(mod) == 'function' then
      mod(lspconfig)
    elseif not ok then
      vim.notify('LSP load error in ' .. name .. ': ' .. mod, vim.log.levels.ERROR)
    end
  end
end

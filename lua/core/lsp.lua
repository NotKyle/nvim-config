-- Setup Mason
require('mason').setup()

-- Setup Mason LSP extension
require('mason-lspconfig').setup {
  ensure_installed = {
    -- 'tsserver', -- ✅ yes, still correct for mason-lspconfig
    'intelephense',
    'html',
    'lua_ls',
    'tailwindcss',
  },
  automatic_installation = false,
}

-- Setup tools (like stylua)
require('mason-tool-installer').setup {
  ensure_installed = {
    'intelephense',
    'html-lsp',
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

vim.api.nvim_set_hl(0, 'LspInlayHint', {
  fg = '#666666', -- soft gray
  italic = true,
  bg = 'NONE', -- transparent background
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true)
    end
  end,
})

-- Optionally load custom overrides from lua/lsp/*.lua
local lsp_dir = vim.fn.stdpath 'config' .. '/lua/lsp'
for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
  local name = file:gsub('%.lua$', '')
  local ok, mod = pcall(require, 'lsp.' .. name)

  if ok then
    if type(mod) == 'function' then
      mod(require 'lspconfig')
    end
  else
    vim.notify('LSP load error in ' .. name .. ': ' .. mod, vim.log.levels.ERROR)
  end
end

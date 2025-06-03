local lspconfig = require 'lspconfig'

-- Setup Mason
require('mason').setup()

-- Setup Mason LSP extension (installs LSPs but does not configure them!)
require('mason-lspconfig').setup {
  ensure_installed = {
    'somesass_ls',
    -- 'cssmodules_ls',
    'intelephense',
    'emmet_language_server',
    'eslint',
    'harper_ls',
    'html',
    'htmx',
    'lua_ls',
    'tailwindcss',
    'ts_ls',
    'glsl_analyzer',
  },
  automatic_installation = false,
  -- handlers = {}, -- 🛑 disables auto-setup
}

-- Setup tools (like stylus)
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

-- Highlight inlay hints
vim.api.nvim_set_hl(0, 'LspInlayHint', {
  fg = '#666666', -- soft gray
  italic = true,
  bg = 'NONE', -- transparent background
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and vim.lsp.inlay_hint then
      vim.defer_fn(function()
        pcall(vim.lsp.inlay_hint.enable, args.buf, true)
      end, 100)
    end
  end,
})

-- Load custom LSP configurations from lsp/*.lua
local lsp_dir = vim.fn.stdpath 'config' .. '/lua/lsp'
for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
  local name = file:gsub('%.lua$', '')
  local ok, mod = pcall(require, 'lsp.' .. name)

  if ok then
    if type(mod) == 'function' then
      mod(lspconfig)
    end
  else
    vim.notify('LSP load error in ' .. name .. ': ' .. mod, vim.log.levels.ERROR)
  end
end

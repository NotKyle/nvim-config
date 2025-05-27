-- Setup Mason
require('mason').setup()

-- Setup Mason LSP extension
require('mason-lspconfig').setup {
  ensure_installed = {
    'cssmodules_ls',
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
}

-- Setup tools
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

-- Automatically set up all installed servers
require('mason-lspconfig').setup {
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup {}
    end,
  },
}
vim.api.nvim_set_hl(0, 'LspInlayHint', {
  fg = '#666666',
  italic = true,
  bg = 'NONE',
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

-- Only load custom overrides that do not conflict with Mason servers
local lsp_dir = vim.fn.stdpath 'config' .. '/lua/lsp'
for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
  local name = file:gsub('%.lua$', '')
  local ok, mod = pcall(require, 'lsp.' .. name)

  if ok then
    if type(mod) == 'function' then
      -- Only call custom setups for servers NOT in Mason's list!
      if
        not vim.tbl_contains({
          'cssmodules_ls',
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
        }, name)
      then
        mod(require 'lspconfig')
      end
    end
  else
    vim.notify('LSP load error in ' .. name .. ': ' .. mod, vim.log.levels.ERROR)
  end
end

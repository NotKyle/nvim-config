-- lua/plugins/lsp.lua
local M = {}

function M.setup()
  require("mason").setup()

  require("lspsaga").setup({
    -- Your lspsaga configuration
  })

  require("null-ls").setup({
    -- Your null-ls configuration
  })

  require("nvim-lspconfig").setup({
    -- Your lspconfig settings
  })
end

return M

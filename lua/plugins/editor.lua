-- lua/plugins/editor.lua
local M = {}

function M.setup()
  require("nvim-cmp").setup({
    -- Your nvim-cmp configuration
  })

  require("luasnip").setup({
    -- Your luasnip configuration
  })

  require("formatter").setup({
    -- Your formatter configuration
  })
end

return M

-- lua/plugins/appearance.lua
local M = {}

function M.setup()
  require("tokyonight").setup({
    -- Your tokyonight configuration
  })

  require("zen").setup({
    -- Your zen configuration
  })
end

return M

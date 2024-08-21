-- lua/plugins/coding.lua
local M = {}

function M.setup()
  require("autotag").setup({
    -- Your autotag configuration
  })

  require("matchups").setup({
    -- Your matchups configuration
  })

  require("conform").setup({
    -- Your conform configuration
  })
end

return M

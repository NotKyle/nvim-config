-- lua/plugins/misc.lua
local M = {}

function M.setup()
  require("obsession").setup({
    -- Your obsession configuration
  })

  require("persistence").setup({
    -- Your persistence configuration
  })

  require("NStefan002/screenkey.nvim").setup({
    -- Your screenkey configuration
  })

  require("typewriter").setup({
    -- Your typewriter configuration
  })
end

return M

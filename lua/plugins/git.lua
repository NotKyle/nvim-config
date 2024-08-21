-- lua/plugins/git.lua
local M = {}

function M.setup()
  require("gitsigns").setup({
    -- Your gitsigns configuration
  })

  require("git-blame").setup({
    -- Your git-blame configuration
  })
end

return M

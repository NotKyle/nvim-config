-- lua/plugins/ui.lua
local M = {}

function M.setup()
  require("neo-tree").setup({
    -- Your neo-tree configuration
  })

  require("harpoon").setup({
    -- Your harpoon configuration
  })

  require("mini.statusline").setup({
    -- Your mini statusline configuration
  })

  require("mini.files").setup({
    -- Your mini.files configuration
  })
end

return M

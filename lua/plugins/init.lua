-- lua/plugins/init.lua
local M = {}

function M.setup()
  require("lazy").setup({
    spec = {
      { import = "plugins.appearance" },
      { import = "plugins.editor" },
      { import = "plugins.lsp" },
      { import = "plugins.ui" },
      { import = "plugins.git" },
      { import = "plugins.coding" },
      { import = "plugins.misc" },
    },
    defaults = {
      lazy = false, -- Set true if you want lazy-loading for custom plugins
      version = false, -- Use the latest git commit
    },
    install = { colorscheme = { "tokyonight-storm" } },
    checker = { enabled = true }, -- Automatically check for plugin updates
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
          "neo-tree",
          "neotree",
        },
      },
    },
  })
end

return M

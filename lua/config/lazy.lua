-- Path for Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Neovide Configuration
if vim.g.neovide then
  -- Window and cursor effects
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.5
  vim.g.neovide_cursor_vfx_particle_density = 10
  vim.g.neovide_cursor_vfx_particle_speed = 0.1
  vim.g.neovide_cursor_vfx_particle_phase = 0.0
  vim.g.neovide_cursor_vfx_color_offset = 120

  -- Visual settings
  vim.opt.termguicolors = true
  vim.opt.background = "dark"
  vim.g.neovide_transparency = 0.95
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_cursor_antialiasing = true

  -- Cursor and line highlighting
  vim.cmd("highlight CursorLine guibg=#2e3440")
  vim.cmd("highlight CursorColumn guibg=#2e3440")
  vim.cmd("highlight LineNr guibg=#2e3440")
  vim.cmd("highlight CursorLineNr guibg=#2e3440")
end

-- Lazy.nvim Bootstrap
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins.low" },
    { import = "plugins.normal" },
    { import = "plugins.high" },
  },
  defaults = {
    lazy = false, -- Set true if you want lazy-loading for custom plugins
    version = false, -- Use the latest git commit
  },
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

vim.cmd("set background=dark")

local everforest = require("everforest")
everforest.setup({
  background = "soft",
  -- transparent_background_level = 0.8,
  -- italics = true,
  -- disable_italic_comments = false,
  -- on_highlights = function(hl, _)
  -- hl["@string.special.symbol.ruby"] = { link = "@field" }
  -- end,
  everforest.load(),
})

-- Include other
local other = true
if other then
  require("config.other")
end

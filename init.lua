require("config.lazy")

local o = vim.o
local wo = vim.wo
local opt = vim.opt
local g = vim.g

vim.cmd.colorscheme("nord")

-- This is the old line number highlight behaviour
--vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#6e738d", bold = false })
--vim.api.nvim_set_hl(0, "LineNr", { fg = "#b4befe", bold = true })
--vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#6e738d", bold = false })

-- Function to set a random highlight color for LineNr
function SetRandomLineNrColor()
  math.randomseed(os.time())

  local colors = {
    "#b4befe", -- Lavender
    "#eba0ac", -- Maroon
    "#d2fac5", -- Green
    "#f2cdcd", -- Flamingo
    "#cba6f7", -- Mauve
    "#fcc6a7", -- Peach
    "#89b4fa", -- Blue
    "#89dceb", -- Sky
  }

  local index = math.random(#colors)
  vim.api.nvim_set_hl(0, "LineNr", { fg = colors[index], bold = true })
end

-- Ensure the random color is selected each time Neovim starts
vim.cmd("autocmd VimEnter * lua SetRandomLineNrColor()")

-- Setting highlights for lines above and below
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#6e738d", bold = false })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#6e738d", bold = false })

if g.neovide then
  g.neovide_transparency = 0.6
  g.neovide_window_blurred = true
  g.neovide_floating_shadow = true

  g.neovide_floating_shadow = true
  g.neovide_floating_z_height = 03
  g.neovide_light_angle_degrees = 25
  g.neovide_light_radius = 2

  g.neovide_refresh_rate = 120
  g.neovide_cursor_vfx_mode = "ripple"
  g.neovide_cursor_animation_length = 0.03
  g.neovide_cursor_trail_size = 0.9
  g.neovide_remember_window_size = true
end

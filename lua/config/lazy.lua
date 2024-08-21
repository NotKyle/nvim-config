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

-- Lazy.nvim Setup
require("lazy").setup({
  spec = {
    -- Import LazyVim and its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- Additional plugin modules
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- User plugins
    { import = "plugins" },
  },
  defaults = {
    lazy = false, -- Custom plugins load during startup
    version = false, -- Always use the latest commit
  },
  install = { colorscheme = { "tokyonight-storm" } },
  checker = { enabled = true }, -- Automatically check for updates
  performance = {
    rtp = {
      -- Disable unnecessary plugins
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

-- Mini.nvim Setup
local function InitMini()
  -- MiniPick Setup
  require("mini.pick").setup({
    autoread = true,
    options = { default = "files" },
    content = {
      filter = function(fs_entry)
        return not vim.endswith(fs_entry.name, "~")
      end,
    },
  })

  -- MiniFiles Setup
  require("mini.files").setup({
    options = {
      use_as_default_explorer = true,
      permanent_delete = false,
    },
    windows = {
      preview = true,
      width_preview = 50,
      width_focus = 50,
      width_nofocus = 25,
      max_number = 2,
    },
    content = {
      filter = function(fs_entry)
        local whitelist = { ".env" }
        for _, whitelist_item in ipairs(whitelist) do
          if fs_entry.name == whitelist_item then
            return true
          end
        end
        return not (vim.startswith(fs_entry.name, ".") or vim.endswith(fs_entry.name, "~"))
      end,
    },
  })

  -- MiniStarter Setup
  require("mini.starter").setup({
    options = { default = "files" },
  })

  -- MiniStatusline Setup
  require("mini.statusline").setup({
    use_icons = vim.g.have_nerd_font,
    content = {
      active = function()
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
        local git = MiniStatusline.section_git({ trunc_width = 40 })
        local diff = MiniStatusline.section_diff({ trunc_width = 75 })
        local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
        local filename = MiniStatusline.section_filename({ trunc_width = 140 })
        local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
        local location = MiniStatusline.section_location({ trunc_width = 200 })
        local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

        local macro = (vim.fn.reg_recording() ~= "") and "[Macro] Recording @" .. vim.fn.reg_recording() or ""

        return MiniStatusline.combine_groups({
          { hl = mode_hl, strings = { mode } },
          { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
          "%<", -- Truncate point
          { hl = "MiniStatuslineFilename", strings = { filename } },
          "%=", -- End left alignment
          { hl = "MiniStatuslineFilename", strings = { macro } },
          { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
          { hl = mode_hl, strings = { search, location } },
        })
      end,
    },
  })
end
InitMini()

-- LSP Initialization
local function InitLSP()
  local lsp_file = vim.fn.stdpath("config") .. "/lsps.txt"
  local file = io.open(lsp_file, "r")

  if not file then
    print("No lsps.txt file found in your config directory. Please create one and add your LSP servers.")
    return
  end

  for line in file:lines() do
    vim.cmd("LspInstall " .. line)
  end

  file:close()
end
-- InitLSP()

-- Load additional LSP configurations
require("config.lsp")

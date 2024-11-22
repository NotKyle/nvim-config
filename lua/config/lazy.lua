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
    { import = "plugins.lsp" },
    { import = "plugins.editor" },
    { import = "plugins.appearance" },
    { import = "plugins.formatting" },
    -- { import = 'plugins.ui' },
    { import = "plugins.git" },
    { import = "plugins.coding" },
    { import = "plugins.misc" },
    { import = "plugins.disabled" },
  },
  defaults = {
    lazy = false, -- Set true if you want lazy-loading for custom plugins
    version = false, -- Use the latest git commit
  },
  -- install = { colorscheme = { "catppuccine-latte" } },
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
-- Function to create the filter array dynamically
local function create_filter_array(filter_array)
  local filter = {}
  for _, filter_item in ipairs(filter_array) do
    local filter_function = filter_item[1] -- e.g., "startswith", "endswith", "regex"
    local filter_values = filter_item[2] -- e.g., {".env"}, {"~"}, {"%.log$"}
    filter[filter_function] = filter_values
  end
  return filter
end

-- General function to apply filters (hides results if they match any filter)
local function apply_filters(fs_entry, filters)
  -- Check if the entry matches any of the 'startswith' filters
  for _, value in ipairs(filters.startswith or {}) do
    if vim.startswith(fs_entry.name, value) then
      return false -- Hide result if it matches the 'startswith' filter
    end
  end

  -- Check if the entry matches any of the 'endswith' filters
  for _, value in ipairs(filters.endswith or {}) do
    if vim.endswith(fs_entry.name, value) then
      return false -- Hide result if it matches the 'endswith' filter
    end
  end

  -- Check if the entry matches any of the 'regex' filters
  for _, pattern in ipairs(filters.regex or {}) do
    if string.match(fs_entry.name, pattern) then
      return false -- Hide result if it matches the 'regex' filter
    end
  end

  -- If none of the filters matched, show the result
  return true
end

-- Mini.nvim Files Setup
local function setup_mini_files(custom_filters)
  local filters = create_filter_array(custom_filters or {
    { "startswith", { ".env" } },
    { "endswith", { "~" } },
    { "regex", { "%.log$", "^config.*%.json$" } },
  })

  require("mini.files").setup({
    options = {
      use_as_default_explorer = false,
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
        return apply_filters(fs_entry, filters)
      end,
    },
  })

  -- Open `mini.files` always at the root directory
  vim.api.nvim_create_user_command("FilesRoot", function()
    require("mini.files").open(vim.fn.getcwd())
  end, { nargs = 0 })
end

-- Mini.nvim Pick Setup
local function setup_mini_pick(custom_filters)
  local filters = create_filter_array(custom_filters or {
    { "endswith", { "~" } },
    { "regex", { "%.tmp$", "%.bak$" } }, -- Example: different filters for file pick
  })

  require("mini.pick").setup({
    autoread = true,
    options = { default = "files" },
    content = {
      filter = function(fs_entry)
        return apply_filters(fs_entry, filters)
      end,
    },
  })
end

-- Usage Example:

-- Setup for Mini Files with default filters (hiding files matching any filter)
setup_mini_files({
  { "startswith", { ".env" } },
  { "endswith", { "~" } },
  { "regex", { "%.md$", "*.min.js", "*.min.css", "*.css" } }, -- Example: Hide all markdown files
})

-- Setup for Mini Pick with custom filters, allowing more specific results
setup_mini_pick({
  { "startswith", { ".env" } },
  { "endswith", { "~" } },
  { "startswith", { "README" } }, -- Example: Hide files starting with 'README'
  { "regex", { "%.md$", "*.min.*", "*.css" } }, -- Example: Hide all markdown files
})

local function setup_mini_starter()
  require("mini.starter").setup({
    options = { default = "files" },
  })
end

local function setup_mini_statusline()
  local MiniStatusline = require("mini.statusline")

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

local function InitMini()
  setup_mini_pick()
  setup_mini_files()
  setup_mini_starter()
  setup_mini_statusline()
end

InitMini()

-- LSP Initialization
local function InitLSP()
  local lsp_file = vim.fn.stdpath("config") .. "/lsps.txt"
  local file = io.open(lsp_file, "r")

  if not file then
    vim.notify(
      "No lsps.txt file found in your config directory. Please create one and add your LSP servers.",
      vim.log.levels.ERROR
    )
    return
  end

  for line in file:lines() do
    vim.cmd("LspInstall " .. line)
  end

  file:close()
  vim.notify("LSP servers installed successfully.", vim.log.levels.INFO)
end

-- Register the command to run InitLSP manually
vim.api.nvim_create_user_command("ReinstallLSP", InitLSP, {})

vim.cmd("set background=dark")

-- Set cursor colour to contrast the theme
-- vim.cmd("highlight Cursor guifg=black guibg=black")
-- vim.cmd("highlight CursorLine guibg=#f1f1f1 guifg=black")

local lspconfig = require("lspconfig")
lspconfig.phpactor.setup({
  on_attach = function(client, bufnr)
    -- You may want to attach specific autocommands here, but setting a buffer option for autocommands is not valid.
    -- Example of a custom command to show diagnostics only on certain events
    -- vim.api.nvim_create_autocmd({"BufWritePost"}, {
    --   buffer = bufnr,
    --   callback = function()
    --     vim.lsp.buf.formatting()
    --   end,
    -- })
  end,
  handlers = {
    -- Only show diagnostics after a debounce or on specific conditions
    ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      -- Delay updating diagnostics by 200ms for better performance
      update_in_insert = false,
      underline = true,
      virtual_text = true,
      signs = true,
      severity_sort = true,
      delay = 200, -- Delay in ms for updates
    }),
  },
  flags = {
    debounce_text_changes = 150, -- Debounce LSP requests
  },
})

vim.diagnostic.config({
  update_in_insert = false, -- Don't show diagnostics while typing
  virtual_text = {
    spacing = 4,
    prefix = "●", -- Custom prefix for diagnostic messages
  },
  signs = true,
  float = {
    source = "always",
  },
})

local signs = { Error = "✘", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

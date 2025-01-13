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

local function setup_mini_pick(custom_filters)
  -- Mini.nvim Pick Setup
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

-- Set cursor colour to contrast the theme
-- vim.cmd("highlight Cursor guifg=black guibg=black")
-- vim.cmd("highlight CursorLine guibg=#f1f1f1 guifg=black")

local lspconfig = require("lspconfig")

lspconfig.intelephense.setup({
  settings = {
    intelephens = {
      format = {
        tabSize = 4,
        insertSpaces = true,
      },
    },
  },
})

lspconfig.phpactor.setup({
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
  settings = {
    phpactor = {
      format = {
        tabSize = 4,
        insertSpaces = true,
      },
    },
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

-- Set colorscheme after it's loaded
-- vim.cmd("colorscheme nordfox")
-- vim.cmd("colorscheme nightfox")

-- vim.cmd("colorscheme everforest")

require("lualine").setup({
  options = {
    theme = "everforest",
  },
  sections = {
    lualine_c = {
      function()
        local current_buf_wd = vim.api.nvim_buf_get_name(0)
        local current_session = require("auto-session.lib").current_session_name(true)

        local get_buf_parent_dir_name = function()
          local buf_wd = vim.api.nvim_buf_get_name(0)
          local buf_wd_trimmed = string.match(buf_wd, "([^/]+)$")

          if buf_wd_trimmed then
            return buf_wd_trimmed
          else
            return "No Name"
          end
        end

        if current_session then
          return "[s]" .. current_session .. " | " .. "[buf]" .. get_buf_parent_dir_name()
        end

        -- return "[" .. require("auto-session.lib").current_session_name(true) .. "]"
      end,
    },
  },
})

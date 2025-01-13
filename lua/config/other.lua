-- local function setup_mini_starter()
--   require("mini.starter").setup({
--     options = { default = "files" },
--   })
-- end

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
  setup_mini_statusline()
end

InitMini()

-- LSP Initialization
-- local function InitLSP()
--   local lsp_file = vim.fn.stdpath("config") .. "/lsps.txt"
--   local file = io.open(lsp_file, "r")
--
--   if not file then
--     vim.notify(
--       "No lsps.txt file found in your config directory. Please create one and add your LSP servers.",
--       vim.log.levels.ERROR
--     )
--     return
--   end
--
--   for line in file:lines() do
--     vim.cmd("LspInstall " .. line)
--   end
--
--   file:close()
--   vim.notify("LSP servers installed successfully.", vim.log.levels.INFO)
-- end

-- Register the command to run InitLSP manually
-- vim.api.nvim_create_user_command("ReinstallLSP", InitLSP, {})

-- Set cursor colour to contrast the theme
-- vim.cmd("highlight Cursor guifg=black guibg=black")
-- vim.cmd("highlight CursorLine guibg=#f1f1f1 guifg=black")

local lspconfig = require("lspconfig")

-- lspconfig.intelephense.setup({
--   settings = {
--     intelephens = {
--       format = {
--         tabSize = 4,
--         insertSpaces = true,
--       },
--     },
--   },
-- })
--
-- lspconfig.phpactor.setup({
--   handlers = {
--     -- Only show diagnostics after a debounce or on specific conditions
--     ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--       -- Delay updating diagnostics by 200ms for better performance
--       update_in_insert = false,
--       underline = true,
--       virtual_text = true,
--       signs = true,
--       severity_sort = true,
--       delay = 200, -- Delay in ms for updates
--     }),
--   },
--   flags = {
--     debounce_text_changes = 150, -- Debounce LSP requests
--   },
--   settings = {
--     phpactor = {
--       format = {
--         tabSize = 4,
--         insertSpaces = true,
--       },
--     },
--   },
-- })

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

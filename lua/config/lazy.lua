local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
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

-- I keep getting fed up of losing my LSP servers whenever I need to reset my configuration
-- Making it so it's easier to reinstall them
function InitLSP()
  local file = io.open(vim.fn.stdpath("config") .. "/lsps.txt", "r")
  if file == nil then
    print("No lsps.txt file found in your config directory. Please create one and add your LSP servers.")
    return
  end
  for line in file:lines() do
    -- Install LSP using LspInstall
    vim.cmd("LspInstall " .. line)
  end
end

-- Mini setup
-- Mini Pick
-- Mini Sessions
-- Mini files
-- Mini Starter
function InitMini()
  require("mini.pick").setup({
    autoread = true,
  })

  require("mini.pick").setup()

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
        local whitelist = {
          ".env",
        }

        -- Check if the file is in the whitelist
        for _, whitelist_item in ipairs(whitelist) do
          if fs_entry.name == whitelist_item then
            return true
          end
        end

        -- Return true if the file name does not start with a dot
        return not vim.startswith(fs_entry.name, ".")
      end,
    },
  })

  require("mini.starter").setup({
    options = {
      default = "files",
    },
  })

  require("mini.statusline").setup({
      use_icons = vim.g.have_nerd_font,

      content = {
        active = function()
          local check_macro_recording = function()
            if vim.fn.reg_recording() ~= "" then
              return "[Macro] Recording @" .. vim.fn.reg_recording()
            else
              return ""
            end
          end

          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diff = MiniStatusline.section_diff({ trunc_width = 75 })
          local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local location = MiniStatusline.section_location({ trunc_width = 200 })
          local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
          local macro = check_macro_recording()

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
            "%<", -- Mark general truncate point
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

local isLspDiagnosticsVisible = true
vim.keymap.set("n", "<leader>lx", function()
    isLspDiagnosticsVisible = not isLspDiagnosticsVisible
    vim.diagnostic.config({
        virtual_text = isLspDiagnosticsVisible,
        underline = isLspDiagnosticsVisible
    }) end)

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Disable underline, it's very annoying
        underline = false,
        -- Enable virtual text, override spacing to 4
        virtual_text = {spacing = 4},
        signs = true,
        update_in_insert = false
    })

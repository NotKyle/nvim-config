-- lua/plugins/appearance.lua
return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme catppuccin-frappe")
    end,
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup()
    end,
  },
  {
    "folke/twilight.nvim",
    opts = {},
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },

    config = function()
      require("noice").setup({
        routes = {
          -- Hide 'written' messages
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "written",
            },
            opts = {
              skip = true,
            },
          },

          -- skip phpactor lsp progress messages (e.g; the annoying "Resolving code actions" message)
          {
            filter = {
              event = "lsp",
              kind = "progress",
              cond = function(message)
                local client = vim.tbl_get(message.opts, "progress", "client")
                return client == "phpactor"
              end,
            },
            opts = { skip = true },
          },

          -- Disable phpcs missing messages
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "phpcs",
            },
            opts = { skip = true },
          },
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        -- Clean command-line
        views = {
          cmdline_popup = {
            position = {
              row = 5,
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
            },
          },
          popupmenu = {
            relative = "editor",
            position = {
              row = 8,
              col = "50%",
            },
            size = {
              width = 60,
              height = 10,
            },
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
            },
          },
        },
      })
    end,
  },
  {
    "ramojus/mellifluous.nvim",
  },
  {
    "folke/zen-mode.nvim",
    opts = {},
  },
  {
    "tzachar/highlight-undo.nvim",
    opts = {},
  },
  -- {
  --   "OXY2DEV/bars-N-lines.nvim",
  --   -- No point in lazy loading this
  --   lazy = false,
  -- },

  -- NvChad stuff
  { "nvchad/minty", lazy = true },
  { "nvchad/volt", lazy = true },
  { "nvchad/menu", lazy = true },
}
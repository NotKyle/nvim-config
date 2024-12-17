-- lua/plugins/coding.lua
return {
  ---@type LazySpec
  {
    "Goose97/timber.nvim",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("timber").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "rafamadriz/friendly-snippets",
  },
  {
    "atiladefreitas/dooing",
    config = function()
      require("dooing").setup({
        -- Core settings
        save_path = vim.fn.stdpath("data") .. "/dooing_todos.json",

        -- Window settings
        window = {
          width = 55,
          height = 20,
          border = "rounded",
          padding = {
            top = 1,
            bottom = 1,
            left = 2,
            right = 2,
          },
        },

        -- To-do formatting
        formatting = {
          pending = {
            icon = "○",
            format = { "icon", "text", "due_date" },
          },
          done = {
            icon = "✓",
            format = { "icon", "text", "due_date" },
          },
        },

        -- Priorization options
        prioritization = false,
        priorities = {
          {
            name = "important",
            weight = 4,
          },
          {
            name = "urgent",
            weight = 2,
          },
        },
        priority_thresholds = {
          {
            min = 5, -- Corresponds to `urgent` and `important` tasks
            max = 999,
            color = nil,
            hl_group = "DiagnosticError",
          },
          {
            min = 3, -- Corresponds to `important` tasks
            max = 4,
            color = nil,
            hl_group = "DiagnosticWarn",
          },
          {
            min = 1, -- Corresponds to `urgent tasks`
            max = 2,
            color = nil,
            hl_group = "DiagnosticInfo",
          },
        },

        -- Default keymaps
        keymaps = {
          toggle_window = "<leader>td",
          new_todo = "i",
          toggle_todo = "x",
          delete_todo = "d",
          delete_completed = "D",
          close_window = "q",
          add_due_date = "H",
          remove_due_date = "r",
          toggle_help = "?",
          toggle_tags = "t",
          clear_filter = "c",
          edit_todo = "e",
          edit_tag = "e",
          delete_tag = "d",
          search_todos = "/",
          import_todos = "I",
          export_todos = "E",
          remove_duplicates = "<leader>D",
        },

        -- Calendar options
        calendar = {
          language = "en",
          icon = "",
          keymaps = {
            previous_day = "h",
            next_day = "l",
            previous_week = "k",
            next_week = "j",
            previous_month = "H",
            next_month = "L",
            select_day = "<CR>",
            close_calendar = "q",
          },
        },
      })
    end,
  },
  {
    "aileot/emission.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
      require("emission").setup({
        attach = {
          -- Useful to avoid extra attaching attempts in simultaneous buffer editing
          -- such as `:bufdo` or `:cdo`.
          delay = 150,
          excluded_buftypes = {
            "help",
            "nofile",
            "terminal",
            "prompt",
          },
          -- NOTE: Nothing is excluded by default. Add any as you need, but check
          -- the 'buftype' at first.
          excluded_filetypes = {
            -- "oil",
          },
        },
        highlight = {
          duration = 300, -- milliseconds
          min_byte = 2, -- minimum bytes to highlight texts
          filter = function(buf) -- See below for examples.
            return true
          end,
          -- NOTE: Buffer texts watched by emission.nvim are cached for the removed
          -- text highlight feature when the buffer is attached and after each
          -- set of highlight emissions.
          -- However, `min_byte` and `filter` options are likely to prevent
          -- necessary recaches. The default value "InsertLeave" forces texts to
          -- be re-cached regardless of the option values.
          -- Please add |autocmd-events| properly if emitted highlight texts are
          -- outdated with your filter settings.
          additional_recache_events = { "InsertLeave" },
        },
        added = {
          priority = 102,
          -- The options for `vim.api.nvim_set_hl(0, "EmissionAdded", {hl_map})`.
          -- NOTE: If you keep "default" key set to `true`, you can arrange the
          -- highlight groups hl-EmissionAdded by nvim_set_hl(), based on your
          -- colorscheme.
          -- NOTE: You can use "link" key to link the highlight settings to an
          -- existing highlight group like hl-DiffAdd.
          hl_map = {
            default = true,
            bold = true,
            fg = "#dcd7ba",
            bg = "#2d4f67",
          },
        },
        -- The same options as `added` are available.
        -- Note that the default values might be different from `added` ones.
        removed = {
          priority = 101,
          -- The options for `vim.api.nvim_set_hl(0, "EmissionRemoved", {hl_map})`.
          hl_map = {
            default = true,
            bold = true,
            fg = "#dcd7ba",
            bg = "#672d2d",
          },
        },
      })
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      -- Default configuration
      require("tiny-inline-diagnostic").setup({
        preset = "modern", -- Can be: "modern", "classic", "minimal", "ghost", "simple", "nonerdfont", "amongus"
        hi = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
          arrow = "NonText",
          background = "CursorLine", -- Can be a highlight or a hexadecimal color (#RRGGBB)
          mixing_color = "None", -- Can be None or a hexadecimal color (#RRGGBB). Used to blend the background color with the diagnostic background color with another color.
        },
        options = {
          -- Show the source of the diagnostic.
          show_source = false,

          -- Throttle the update of the diagnostic when moving cursor, in milliseconds.
          -- You can increase it if you have performance issues.
          -- Or set it to 0 to have better visuals.
          throttle = 20,

          -- The minimum length of the message, otherwise it will be on a new line.
          softwrap = 30,

          -- If multiple diagnostics are under the cursor, display all of them.
          multiple_diag_under_cursor = false,

          -- Enable diagnostic message on all lines.
          multilines = false,

          -- Show all diagnostics on the cursor line.
          show_all_diags_on_cursorline = false,

          -- Enable diagnostics on Insert mode. You should also se the `throttle` option to 0, as some artefacts may appear.
          enable_on_insert = false,

          overflow = {
            -- Manage the overflow of the message.
            --    - wrap: when the message is too long, it is then displayed on multiple lines.
            --    - none: the message will not be truncated.
            --    - oneline: message will be displayed entirely on one line.
            mode = "wrap",
          },

          -- Format the diagnostic message.
          -- Example:
          -- format = function(diagnostic)
          --     return diagnostic.message .. " [" .. diagnostic.source .. "]"
          -- end,
          format = nil,

          --- Enable it if you want to always have message with `after` characters length.
          break_line = {
            enabled = false,
            after = 30,
          },

          virt_texts = {
            priority = 9999,
          },

          -- Filter by severity.
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },

          -- Overwrite events to attach to a buffer. You should not change it, but if the plugin
          -- does not works in your configuration, you may try to tweak it.
          overwrite_events = nil,
        },
      })
    end,
  },
  {
    "Hashino/doing.nvim",
    config = function()
      require("doing").setup({
        -- default options
        message_timeout = 2000,
        winbar = {
          enabled = true,
          -- ignores buffers that match filetype
          ignored_buffers = { "NvimTree" },
        },

        doing_prefix = "Current Task: ",
        store = {
          -- automatically create a .tasks when calling :Do
          auto_create_file = true,
          file_name = ".tasks",
        },
      })
      -- example on how to change the winbar highlight
      vim.api.nvim_set_hl(0, "WinBar", { link = "Search" })

      local api = require("doing.api")

      vim.keymap.set("n", "<leader>de", api.edit, { desc = "[E]dit what tasks you`re [D]oing" })
      vim.keymap.set("n", "<leader>dn", api.done, { desc = "[D]o[n]e with current task" })
    end,
  },
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        notify = {
          enabled = false,
        },
        error = {
          enabled = true,
          -- Error messages are formatted using the builtins for error. See config.format.builtin
          -- See the section on formatting for more details on how to customize.
          --- @type NoiceFormat|string
          format = "error",
          --- @type NoiceFormat|string
          format_done = "error_done",
          view = "mini",
          -- Limit maximum number of errors to show to 3
          limit = 3,
        },
        lsp = {
          progress = {
            enabled = true,
            -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
            -- See the section on formatting for more details on how to customize.
            --- @type NoiceFormat|string
            format = "lsp_progress",
            --- @type NoiceFormat|string
            format_done = "lsp_progress_done",
            throttle = 1000 / 30, -- frequency to update lsp progress message
            view = "mini",
          },
        },
      })
    end,
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>e",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },

  {
    "rmagatti/auto-session",
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { "~/Downloads", "/" },
      -- log_level = 'debug',
      bypass_session_save_cmds = { "tabnew", "foldmethod" },
    },
  },
  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "andymass/vim-matchup",
    config = function()
      vim.api.nvim_set_hl(0, "OffScreenPopup", { fg = "#fe8019", bg = "#3c3836", italic = true })
      vim.g.matchup_matchparen_offscreen = {
        method = "popup",
        highlight = "OffScreenPopup",
      }
    end,
  },
  {
    "Rics-Dev/project-explorer.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      paths = {
        "~/Desktop/Sites/",
        "~/.config/nvim",
      },
      file_explorer = function(dir)
        vim.cmd("Telescope file_browser")
        vim.cmd("cd " .. dir)
      end,
    },
    config = function(_, opts)
      require("project_explorer").setup(opts)
    end,

    keys = {
      { "<leader>pp", "<cmd>ProjectExplorer<CR>", desc = "Open Project Explorer" },
    },
    lazy = false,
  },
  {
    "coffebar/neovim-project",
    dependencies = {
      { "Shatur/neovim-session-manager" },
    },
  },
  {
    "rachartier/tiny-code-action.nvim",
    event = "LspAttach",
    config = function()
      require("tiny-code-action").setup()
    end,
  },

  { "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically

  { "numToStr/Comment.nvim", opts = {} },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
        },
        scope = {
          enabled = false,
          char = "│",
          show_start = false,
          show_end = false,
          include = {
            node_type = { ["*"] = { "*" } },
          },
        },
      })
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
      require("mini.indentscope").setup({
        draw = {
          delay = 0,
          animation = require("mini.indentscope").gen_animation.none(),
        },
        symbol = "│",
      })

      vim.api.nvim_create_autocmd("FileType", {
        desc = "Disable indentscope for certain filetypes",
        pattern = {
          "NvimTree",
          "help",
          "Trouble",
          "trouble",
          "lazy",
          "notify",
          "better_term",
          "toggleterm",
          "lazyterm",
          "noice",
        },
        callback = function()
          ---@diagnostic disable-next-line: inject-field
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- helper keymaps to move forward and backward using [key ]key
  {
    "echasnovski/mini.bracketed",
    version = false,
    opts = {},
  },

  {
    "tpope/vim-abolish",
    config = function()
      vim.g.abolish_case = "smart"
    end,
  },
}

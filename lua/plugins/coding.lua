-- lua/plugins/coding.lua
return {
  ---@type LazySpec
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        notify = {
          enabled = false,
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
    "github/copilot.vim",
    config = function()
      -- Disable copilot suggestions
      vim.g.copilot_filetypes = {
        -- ['*'] = false,
      }

      vim.keymap.set("i", "<Right>", 'copilot#Accept("\\<Right>")', {
        expr = true,
        replace_keycodes = false,
        silent = true, -- Disable echo in command line
      })

      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<Tab>", "<Tab>")

      vim.g.disable_copilot = false

      vim.api.nvim_create_user_command("ToggleCopilot", function()
        vim.g.disable_copilot = not vim.g.disable_copilot
        if not vim.g.disable_copilot then
          vim.cmd("Copilot enable")
        else
          vim.cmd("Copilot disable")
        end
        vim.notify("Copilot: " .. (vim.g.disable_copilot and "Disabled" or "Enabled"))
      end, {
        desc = "Toggle Copilot",
      })

      vim.keymap.set("n", "<leader>tc", "<ESC><cmd>ToggleCopilot<CR>", { desc = "[T]oggle [C]opilot" })
    end,
  },

  {
    "tpope/vim-abolish",
    config = function()
      vim.g.abolish_case = "smart"
    end,
  },
}
